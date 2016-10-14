require.config({
	baseUrl: '.',
	
	waitSeconds: 600,
	
	shim: {
		'bootstrap': {
			deps: ['../components/jquery/dist/jquery.js']
		},
		'ace': {
			deps: ['../components/jquery/dist/jquery.js', '../components/bootstrap/dist/js/bootstrap.js']
		},
		'ace-elements': {
			deps: ['../assets/js/ace.js']
		}
	}
});
require(['../components/jquery/dist/jquery.js', '../components/bootstrap/dist/js/bootstrap.js', '../assets/js/ace.js', '../assets/js/ace-extra.js', '../assets/js/ace-elements.js'], function($) {
	//try, to hide possible errors in case ace.demo is not available
	try {
		ace.demo.init(true);//true means the call is not from inside a jQuery document ready event
	} catch(e) {}
	
	/**
	//you can restore state of elements now (ace-extra.js is loaded)
	$('.ace-save-state').each(function() {
		ace.settings.loadState(this);
	});
	
	//or as soon as you render an element such as sidebar, etc ...
	  ace.settings.loadState('sidebar');
	*/
});