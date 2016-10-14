/**
 <b>Settings box</b>. It's good for demo only. You don't need this.
*/
(function($ , undefined) {

 $('#ace-settings-btn').on(ace.click_event, function(e){
	e.preventDefault();

	$(this).toggleClass('open');
	$('#ace-settings-box').toggleClass('open');
 })

 $('#ace-settings-navbar').on('click', function(){
	ace.settingFunction.navbar_fixed(null, this.checked);
 })

 $('#ace-settings-sidebar').on('click', function(){
	ace.settingFunction.sidebar_fixed(null, this.checked);
 })

 $('#ace-settings-breadcrumbs').on('click', function(){
	ace.settingFunction.breadcrumbs_fixed(null, this.checked);
 })

 $('#ace-settings-add-container').on('click', function(){
	ace.settingFunction.main_container_fixed(null, this.checked);
 })



 $('#ace-settings-compact').on('click', function(){
	if(this.checked) {
		$('#sidebar').addClass('compact');
		var hover = $('#ace-settings-hover');
		if( hover.length > 0 ) {
			hover.removeAttr('checked').trigger('click');
		}
	}
	else {
		$('#sidebar').removeClass('compact');
		$('#sidebar[data-sidebar-scroll=true]').ace_sidebar_scroll('reset')
	}
	
	if(ace.vars['old_ie']) ace.helper.redraw($('#sidebar')[0], true);
 })


 $('#ace-settings-highlight').on('click', function(){
	if(this.checked) $('#sidebar .nav-list > li').addClass('highlight');
	else $('#sidebar .nav-list > li').removeClass('highlight');
	
	if(ace.vars['old_ie']) ace.helper.redraw($('#sidebar')[0]);
 })


 $('#ace-settings-hover').on('click', function(){
	if($('#sidebar').hasClass('h-sidebar')) return;
	if(this.checked) {
		$('#sidebar li').addClass('hover')
		.filter('.open').removeClass('open').find('> .submenu').css('display', 'none');
		//and remove .open items
	}
	else {
		$('#sidebar li.hover').removeClass('hover');

		var compact = $('#ace-settings-compact');
		if( compact.length > 0 && compact.get(0).checked ) {
			compact.trigger('click');
		}
	}
	
	$('.sidebar[data-sidebar-hover=true]').ace_sidebar_hover('reset')
	$('.sidebar[data-sidebar-scroll=true]').ace_sidebar_scroll('reset')
	
	if(ace.vars['old_ie']) ace.helper.redraw($('#sidebar')[0]);
 })

 
 
 //these are only for Ace demo! 
 //we want to save only important states(sidebar-fixed and sidebar-collapsed) so before fixing sidebar or collapsing it, hide mobile menu or remove extra classes!
 //and then save class name, etc to localStorage for later retrieval
 
 /**
 $(document).on('presettings.ace', function(ev, event_name, event_val, event_source, save_state) {
	if( !save_state ) return false;
	
	var $event_name = event_name;
	if( (event_name == 'sidebar_fixed' || event_name == 'sidebar_collapsed') ) {
		var sidebar = event_source ? $(event_source) : $('#sidebar');
		var tmpClassName = sidebar.attr('class');
		sidebar.attr('class', event_name == 'sidebar_fixed' ? 'sidebar-fixed' : 'menu-min');//don't save these classes in demo
	
		//we don't use 'one' because other 'settings.ace' events could be triggered before the 'sidebar_*' one!
		$(document).on('settings.ace.sidebar', function(ev, event_name) {
			if( (event_name == $event_name) ) {
				sidebar.addClass(tmpClassName);
				$(document).off('settings.ace.sidebar');
			}
		});
	}
	else if( (event_name == 'navbar_fixed') ) {
		var navbar = event_source ? $(event_source) : $('#navbar');
		var tmpClassName = navbar.attr('class');
		navbar.attr('class', 'navbar-fixed-top');//don't save these classes in demo
	
		//we don't use 'one' because other 'settings.ace' events could be triggered before the 'sidebar_*' one!
		$(document).on('settings.ace.navbar', function(ev, event_name) {
			if( (event_name == $event_name) ) {
				navbar.addClass(tmpClassName);
				$(document).off('settings.ace.navbar');
			}
		});
	}

 });
 */


 //check/uncheck the checkbox in settings box
 var checkbox = this;
 $(document).on('settings.ace', function(ev, event_name, event_val, event_source, save_state) {
	var checkbox = '';
	switch(event_name) {
		case 'navbar_fixed':
			checkbox = 'ace-settings-navbar';
		break;
		
		case 'sidebar_fixed':
			checkbox = 'ace-settings-sidebar';
		break;
		
		case 'breadcrumbs_fixed':
			checkbox = 'ace-settings-breadcrumbs';
		break;
		
		case 'main_container_fixed':
			checkbox = 'ace-settings-add-container';
		break;
	}
	
	if( checkbox && (checkbox = document.getElementById(checkbox)) ) {
		$(checkbox).prop('checked', event_val);

		try {
			if(save_state == true) ace.settings.saveState(checkbox, 'checked');
		} catch(e) {}
	}
 });


  ////
  ace.settingFunction = {
	navbar_fixed : function(navbar, fixed , save, chain) {
		if(ace.vars['very_old_ie']) return false;
		
		var navbar = navbar || '#navbar';
		if(typeof navbar === 'string') navbar = $(navbar).get(0);
		if(!navbar) return false;
	
		var fixed = fixed || false;
		var save = typeof save !== 'undefined' ? save : true;
		

		var event;
		$(document).trigger(event = $.Event('presettings.ace'), ['navbar_fixed' , fixed , navbar, save]);
		if (event.isDefaultPrevented()) {
			return false;
		}

	
		if(chain !== false && !fixed) {
			//unfix sidebar as well
			var sidebar = $('#sidebar');
			if(sidebar.hasClass('sidebar-fixed')) {
				ace.settingFunction.sidebar_fixed(sidebar.get(0), false, save);
			}
		}

		if(fixed) {
			$(navbar).addClass('navbar-fixed-top');
		} else {
			$(navbar).removeClass('navbar-fixed-top');
		}

		if(save) {
			ace.settings.saveState(navbar, 'class', 'navbar-fixed-top', fixed);//the 'last' boolean means whether to append this classname or to remove it from previous value			
		}

		$(document).trigger('settings.ace', ['navbar_fixed' , fixed , navbar, save]);
	},


	sidebar_fixed : function(sidebar, fixed , save, chain) {
		if(ace.vars['very_old_ie']) return false;
		
		var sidebar = sidebar || '#sidebar';
		if(typeof sidebar === 'string') sidebar = $(sidebar).get(0);
		if(!sidebar) return false;
		

		var fixed = fixed || false;
		var save = typeof save !== 'undefined' ? save : true;
		
		
		var event;
		$(document).trigger(event = $.Event('presettings.ace'), ['sidebar_fixed' , fixed , sidebar, save]);
		if (event.isDefaultPrevented()) {
			return false;
		}
		
		
		if(chain !== false) {
			if(fixed) {
				//fix navbar as well
				ace.settingFunction.navbar_fixed(null, true, save);
			}

			else {
				//unfix breadcrumbs as well
				ace.settingFunction.breadcrumbs_fixed(null, false, save);
			}
		}

		var toggler = $('#menu-toggler');
		if(fixed) {
			$(sidebar).addClass('sidebar-fixed');
			toggler.addClass('fixed');
		} else {
			$(sidebar).removeClass('sidebar-fixed');
			toggler.removeClass('fixed');
		}
		
		if( save ) {
			ace.settings.saveState(sidebar, 'class', 'sidebar-fixed', fixed);//the 'last' boolean means whether to append this classname or to remove it from previous value
			if(toggler.length != 0) ace.settings.saveState(toggler[0], 'class', 'fixed', fixed);
		}

		$(document).trigger('settings.ace', ['sidebar_fixed' , fixed , sidebar, save]);
	},
	
	//fixed position
	breadcrumbs_fixed : function(breadcrumbs, fixed , save, chain) {
		if(ace.vars['very_old_ie']) return false;

		var breadcrumbs = breadcrumbs || '#breadcrumbs';
		if(typeof breadcrumbs === 'string') breadcrumbs = $(breadcrumbs).get(0);
		if(!breadcrumbs) return false;
	
		var fixed = fixed || false;
		var save = typeof save !== 'undefined' ? save : true;
		
		
		var event;
		$(document).trigger(event = $.Event('presettings.ace'), ['breadcrumbs_fixed' , fixed , breadcrumbs, save]);
		if (event.isDefaultPrevented()) {
			return false;
		}
		
		
		if(fixed && chain !== false) {
			//fix sidebar and navbar as well
			ace.settingFunction.sidebar_fixed(null, true, save);
		}

		if(fixed) {
			$(breadcrumbs).addClass('breadcrumbs-fixed');
		} else {
			$(breadcrumbs).removeClass('breadcrumbs-fixed');
		}
		
		if( save ) {
			ace.settings.saveState(breadcrumbs, 'class', 'breadcrumbs-fixed', fixed);
		}

		$(document).trigger('settings.ace', ['breadcrumbs_fixed' , fixed , breadcrumbs, save]);
	},

	//fixed size
	main_container_fixed : function(main_container, fixed , save) {
		if(ace.vars['very_old_ie']) return false;
		
		var fixed = fixed || false;//fixed width? inside .container
		var save = typeof save !== 'undefined' ? save : true;
		
		var main_container = main_container || '#main-container';
		if(typeof main_container === 'string') main_container = $(main_container).get(0);
		if(!main_container) return false;
		
		
		var event;
		$(document).trigger(event = $.Event('presettings.ace'), ['main_container_fixed' , fixed , main_container, save]);
		if (event.isDefaultPrevented()) {
			return false;
		}
		
		
		var navbar_container = $('#navbar-container');
		if(fixed) {
			$(main_container).addClass('container');
			$(navbar_container).addClass('container');
		} else {
			$(main_container).removeClass('container');
			$(navbar_container).removeClass('container');
		}

		
		if( save ) {
			ace.settings.saveState(main_container, 'class', 'container', fixed);
			if(navbar_container.length != 0) ace.settings.saveState(navbar_container[0], 'class', 'container', fixed);
		}

		
		if(navigator.userAgent.match(/webkit/i)) {
			//webkit has a problem redrawing and moving around the sidebar background in realtime
			//so we do this, to force redraw
			//there will be no problems with webkit if the ".container" class is statically put inside HTML code.
			$('#sidebar').toggleClass('menu-min')
			setTimeout(function() {	$('#sidebar').toggleClass('menu-min') } , 10)
		}
		
		$(document).trigger('settings.ace', ['main_container_fixed', fixed, main_container, save]);
	}
	/**
	,
	sidebar_collapsed : function(sidebar, collapsed , save) {
		if(ace.vars['very_old_ie']) return false;

		var sidebar = sidebar || '#sidebar';
		if(typeof sidebar === 'string') sidebar = $(sidebar).get(0);
		if(!sidebar) return false;

		var collapsed = collapsed || false;
		var save = typeof save !== 'undefined' ? save : true;
		
		
		var event;
		$(document).trigger(event = $.Event('presettings.ace'), ['sidebar_collapsed' , collapsed , sidebar, save]);
		if (event.isDefaultPrevented()) {
			return false;
		}
		

		if(collapsed) {
			$('#sidebar').addClass('menu-min');
		} else {
			$('#sidebar').removeClass('menu-min');
		}
		
		if( save ) {
			ace.settings.saveState(sidebar, 'class', 'menu-min', collapsed);//the 'last' boolean means whether to append this classname or to remove it from previous value
		}

		$(document).trigger('settings.ace', ['sidebar_collapsed' , collapsed, sidebar, save]);
	}
	*/
  }


})(jQuery);