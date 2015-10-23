/*!
 * B-JUI  v1.2 (http://b-jui.com)
 * Git@OSC (http://git.oschina.net/xknaan/B-JUI)
 * Copyright 2014 K'naan (xknaan@163.com).
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 */

/* ========================================================================
 * B-JUI: bjui-upload.js  v1.2
 * @author K'naan (xknaan@163.com)
 * -- Modified from Huploadify 2.0 (author:吕大豹)
 * http://git.oschina.net/xknaan/B-JUI/blob/master/BJUI/js/bjui-upload.js
 * ========================================================================
 * Copyright 2014 K'naan.
 * Licensed under Apache (http://www.apache.org/licenses/LICENSE-2.0)
 * ======================================================================== */

+function ($) {
    'use strict';
    
    // UPLOAD CLASS DEFINITION
    // ======================
    var Upload = function(element, options) {
        this.$element      = $(element)
        this.options       = options
        this.tools         = this.TOOLS()
    }
    
    Upload.DEFAULTS = {
        fileTypeExts        : '*.jpg;*.png',     //允许上传的文件类型，格式'*.jpg;*.doc'
        uploader            : '',     //文件提交的地址
        auto                : false,  //是否开启自动上传
        method              : 'POST', //发送请求的方式，get或post
        multi               : false,  //是否允许选择多个文件
        formData            : {},     //发送给服务端的参数，格式：{key1:value1,key2:value2}
        fileObjName         : 'file', //在后端接受文件的参数名称，如PHP中的$_FILES['file']
        fileSizeLimit       : 204800, //允许上传的文件大小，单位KB
        previewImg          : true,   //是否预览上传图片
        previewLoadimg      : null,   //预览图片前的载入图标
        dragDrop            : false,  //是否允许拖动上传
        showUploadedPercent : true,   //是否实时显示上传的百分比，如20%
        showUploadedSize    : true,   //是否实时显示已上传的文件大小，如1M/2M
        buttonText          : '选择上传文件',     //上传按钮上的文字
        removeTimeout       : 1e3,              //上传完成后进度条的消失时间
        itemTemplate        : FRAG.uploadTemp,  //上传队列显示的模板
        breakPoints         : false,            //是否开启断点续传
        fileSplitSize       : 1024 * 1024,      //断点续传的文件块大小，单位Byte，默认1M
        onUploadStart       : null,  //上传开始时的动作
        onUploadSuccess     : null,  //上传成功的动作
        onUploadComplete    : null,  //上传完成的动作
        onUploadError       : null,  //上传失败的动作
        onInit              : null,  //初始化时的动作
        onCancel            : null,  //删除掉某个文件后的回调函数，可传入参数file
        onSelect            : null
    }
    
    Upload.MIMETYPES = {
        zip  :[ 'application/x-zip-compressed' ],
        jpg  :[ 'image/jpeg' ],
        png  :[ 'image/png' ],
        gif  :[ 'image/gif' ],
        swf  :[ 'application/x-shockwave-flash' ],
        doc  :[ 'application/msword' ],
        xls  :[ 'application/vnd.ms-excel' ],
        docx :[ 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' ],
        xlsx :[ 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' ],
        ppt  :[ 'application/vnd.ms-powerpoint' ],
        pptx :[ 'application/vnd.openxmlformats-officedocument.presentationml.presentation' ],
        mp3  :[ 'audio/mpeg' ],
        mp4  :[ 'video/mp4' ],
        pdf  :[ 'application/pdf' ],
        txt  :[ 'text/plain' ],
        xml  :[ 'text/xml' ]
    }
    
    Upload.prototype.TOOLS = function() {
        var that  = this, options = this.options
        var tools = {
            //将文件的单位由bytes转换为KB或MB，若第二个参数指定为true，则永远转换为KB
            formatFileSize: function(size, byKB) {
                if (size > 1024 * 1024 && !byKB)
                    size = (Math.round(size * 100 / (1024 * 1024)) / 100).toString() + 'MB'
                else
                    size = (Math.round(size * 100 / 1024) / 100).toString() + 'KB'
                
                return size
            },
            //根据文件序号获取文件
            getFile: function(index, files) {
                for (var i = 0; i < files.length; i++) {
                    if (files[i].index == index) return files[i]
                }
                return false
            },
            //将输入的文件类型字符串转化为数组,原格式为*.jpg;*.png
            getFileTypes: function(str) {
                var result = []
                var arr1   = str.split(';')
                
                for (var i = 0; i < arr1.length; i++) {
                    result.push(arr1[i].split('.').pop())
                }
                return result
            },
            //根据后缀名获得文件的mime类型
            getMimetype: function(name) {
                return Upload.MIMETYPES[name]
            },
            //根据配置的字符串，获得上传组件accept的值
            getAcceptString: function(str) {
                var types  = this.getFileTypes(str)
                var result = []
                
                for (var i = 0; i < types.length; i++) {
                    var mime = this.getMimetype(types[i])
                    
                    if (mime) result.push(mime)
                    else result.push('.'+ types[i])
                }
                return result.join(',')
            },
            //过滤上传文件
            filter: function(files) {
                var arr = []
                var typeArray = this.getFileTypes(options.fileTypeExts)
                
                if (typeArray.length > 0) {
                    for (var i = 0; i < files.length; i++) {
                        var thisFile = files[i]
                        
                        if (parseInt(this.formatFileSize(thisFile.size, true)) > options.fileSizeLimit) {
                            that.$element.alertmsg('error', '文件"'+ thisFile.name +'"大小超出限制！')
                            continue
                        }
                        if ($.inArray(thisFile.name.split('.').pop().toLowerCase(), typeArray) >= 0) {
                            arr.push(thisFile)
                        } else {
                            that.$element.alertmsg('error', '文件"'+ thisFile.name +'"类型不允许！')
                        }
                    }
                }
                return arr
            },
            //获取选择文件，file控件
            getFiles: function(e) {
                var files = e.target.files || e.dataTransfer.files // 获取文件列表对象
                
                files = this.filter(files)
                for (var i = 0; i < files.length; i++) {
                    files[i].id     = files[i].lastModifiedDate.getTime() +'_'+ files[i].size +'_'+ (files[i].type || '').replace(/\W/g, '')
                    this.renderQueueItem(files[i])
                    that.queueData.files++
                }
                
                return files
            },
            //生成上传队列Dom
            renderQueueItem: function(file) {
                var uploadedSize = 0
                var $temp = $(options.itemTemplate
                        .replace('{fileId}', file.id)
                        .replace('{fileName}', file.name)
                        .replace('#upConfirm#', BJUI.regional.upload.upConfirm)
                        .replace('#upPause#', BJUI.regional.upload.upPause)
                        .replace('#upCancel#', BJUI.regional.upload.upCancel)
                        .replace('{percent}', '0.00%')
                        .replace('{uploadedSize}', '0KB')
                        .replace('{fileSize}', this.formatFileSize(file.size)))
                
                //如果是自动上传，去掉上传按钮
                if (options.auto) {
                    $temp.find('> .info > .up_confirm').remove()
                }
                $temp.data('upfile', file)
                that.$uploadFileList.append($temp)
                //如果断点续传
                if (options.breakPoints) {
                    uploadedSize = this.getUploadedSize(file.id)
                    if (uploadedSize > file.size) uploadedSize = file.size
                }
                this.showProgress(file.id, uploadedSize, file.size)
                //判断是否预览图片
                if (options.previewImg && file.type.indexOf('image') != -1) {
                    var $prevbox = $temp.find('> .preview > .img')
                    
                    if (options.previewLoadimg) $prevbox.html('<img src="'+ options.previewLoadimg +'" height="114">')
                    this.previewImg(file, $prevbox)
                } else {
                    $temp.find('> .preview').remove()
                }
                //判断是否显示已上传文件大小
                if (options.showUploadedSize) {
                    var $fileSize = $temp.find('> .filesize')
                    
                    $fileSize.find('> .uploadedsize').html(this.formatFileSize(uploadedSize))
                    $fileSize.find('> .filesize').html(this.formatFileSize(file.size))
                } else {
                    $temp.find('> .filesize').remove()
                }
                //判断是否显示上传百分比
                if (options.showUploadedPercent) {
                    $temp.find('> .percent').html((uploadedSize / file.size * 100).toFixed(2) +'%')
                } else {
                    $temp.find('> .percent').remove()
                }
                options.onSelect && options.onSelect(files)
                //判断是否是自动上传
                if (options.auto) that.fileUpload(file, uploadedSize)
                
                $temp.on('click.bjui.upload.confirm', '.up_confirm', function(e) {
                    var $this = $(this), $queue = $this.closest('.item')
                    
                    $this.hide().next().show()
                    that.fileUpload($queue.data('upfile'), uploadedSize)
                })
                $temp.on('click.bjui.upload.cancel', '.up_cancel', this.removeQueueItem)
            },
            successQueueItem: function(file, xhr) {
                tools.showProgress(file.id, file.size, file.size)
                options.onUploadSuccess && options.onUploadSuccess.toFunc().call(that, file, xhr.responseText, that.$element)
                //在指定的间隔时间后删掉进度条
                setTimeout(function() {
                    that.$element.find('#'+ file.id).fadeOut('normal', function() {
                        $(this).remove()
                        var filelen = that.$element.find('> .queue > .item:visible').length
                        
                        if (filelen == 0) {
                            that.$element.find('> .queue').hide()
                            that.$file.val('')
                        }
                    })
                }, options.removeTimeout)
            },
            removeQueueItem: function(e, xhr) {
                if (xhr) xhr.abort()
                
                $(this).closest('.item').fadeOut('normal', function() {
                    $(this).remove()
                    
                    var filelen = that.$element.find('> .queue > .item:visible').length
                    if (filelen == 0) that.$element.find('> .queue').hide()
                })
                
                e.preventDefault()
            },
            //预览上传图片
            previewImg: function(file, $obj) {
                if (file && $obj.length) {
                    var reader = new FileReader()
                    
                    reader.onload = function(e) {
                        $obj.html('<img src="'+ e.target.result +'">')
                    }
                    reader.readAsDataURL(file)
                }
            },
            //上传进度条
            showProgress: function(fileId, uploadedSize, fileSize) {
                var initWidth     = uploadedSize / fileSize * 100 +'%',
                    initFileSize  = that.tools.formatFileSize(uploadedSize),
                    initUppercent = (uploadedSize / fileSize * 100).toFixed(2) +'%'
                that.$element.find('#'+ fileId +' > .progress > .bar').css('width', initWidth)
            },
            //断点续传：获取已上传的文件片断大小
            getUploadedSize: function(fileId) {
                return localStorage.getItem(fileId) * 1
            },
            //断点续传：保存已上传的文件片断大小
            saveUploadedSize:function(fileId, value) {
                localStorage.setItem(fileId, value)
            },
            //发送文件块函数
            sendBlob: function(url, xhr, file, formdata) {
                var fd = new FormData()
                
                xhr.open(options.method, url, true)
                xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest')
                //xhr.setRequestHeader('X_Requested_With', location.href.split('/')[5].replace(/[^a-z]+/g, '$'))
                fd.append(options.fileObjName, file)
                if (formdata) {
                    for (var key in formdata) {
                        fd.append(key, formdata[key])
                    }
                }
                xhr.send(fd)
            }
        }
        
        return tools
    }
    
    Upload.prototype.init = function() {
        var that     = this
        var $element = this.$element
        var options  = this.options
        
        if (!(options.uploader)) {
            BJUI.debug('Upload Plugin: The options uploader is undefined!')
            return
        } else {
            options.uploader = decodeURI(options.uploader).replacePlh($element.closest('.unitBox'))
            
            if (!options.uploader.isFinishedTm()) {
                $element.alertmsg('error', (options.warn || FRAG.alertPlhMsg.replace('#plhmsg#', BJUI.regional.plhmsg)))
                BJUI.debug('Upload Plugin: The options uploader is incorrect: '+ options.uploader)
                return
            }
            
            options.uploader = encodeURI(options.uploader)
        }
        
        if ($element.hasClass('bjui-upload')) return
        
        var $uploadFrag = $(FRAG.uploadFrag
            .replaceAll('#multi#', options.multi ? 'multiple' : '')
            .replaceAll('#accept#', that.tools.getAcceptString(options.fileTypeExts))
            .replaceAll('#btnTxt#', (options.icon ? '<i class="fa fa-'+ options.icon +'">&nbsp;&nbsp;' : '') + options.buttonText))
        
        $element
            .addClass('bjui-upload')
            .append($uploadFrag)
        
        this.$file           = $element.find('> .bjui-upload-select-file')
        this.$uploadFileList = $element.find('> .queue')
        this.queueData       = { files:0, success:0, error:0 }
        
        //do select files
        $element
            .on('change.bjui.upload', '.bjui-upload-select-file', function(e) {
                that.fileSelect(e)
            })
            .on('click.bjui.upload', '.bjui-upload-select', function(e) {
                that.$file.trigger('click')
            })
        
        options.onInit && options.onInit()
        
        //如果允许拖动上传
        if (options.dragDrop) {
            /* 拖拽元素在目标元素头上移动的时候 */
            $element[0].ondragover = function(ev) {
                ev.preventDefault()
                return true
            }
            
            $element[0].ondrop = function(e) { 
                that.fileSelect(e)
                
                e.stopPropagation()
                e.preventDefault()
            }
        }
    }
    
    Upload.prototype.fileSelect = function(e) {
        this.$uploadFileList.show()
        this.tools.getFiles(e)
    }
    
    Upload.prototype.fileUpload = function(file, uploadedSize) {
        var that = this, $element = that.$element, options = that.options, tools = that.tools
        var xhr  = false, originalFile = file
        
        //校正进度条和上传比例的误差
        xhr = new XMLHttpRequest()
        
        if (options.breakPoints) {
            //对文件进行切割，并保留原来的信息
            file = originalFile.slice(uploadedSize, uploadedSize + options.fileSplitSize)
        }
        if (xhr.upload) {
            // 上传进度
            xhr.upload.onprogress = function(e) { that.onProgress(file, e.loaded, originalFile.size) }
            // 上传回调
            xhr.onreadystatechange = function(e) {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    var returnData = JSON.parse(xhr.responseText), upOver = false
                    if (options.breakPoints) {
                        //更新已上传文件大小，保存到本地
                        uploadedSize += options.fileSplitSize
                        tools.saveUploadedSize(originalFile.id, uploadedSize)
                        //继续上传其他片段
                        if (uploadedSize < originalFile.size) {
                            file = originalFile.slice(uploadedSize, uploadedSize + options.fileSplitSize)
                            //上传文件
                            tools.sendBlob(options.uploader, xhr, file, options.formData)
                        } else {
                            upOver = true
                        }
                    } else {
                        upOver = true
                    }
                    if (upOver) {
                        that.queueData.success++
                        tools.successQueueItem(originalFile, xhr)
                        options.onUploadComplete && options.onUploadComplete(originalFile, xhr.responseText)
                    }
                } else {
                    that.queueData.error++
                    //错误回调
                    options.onUploadError && options.onUploadError(originalFile, xhr.responseText)
                }
                //队列完成回调
                if (options.onQueueComplete) {
                    if (that.queueData.files = that.queueData.success + that.queueData.error)
                        option.onQueueComplete(that.queueData)
                }
            }
            options.onUploadStart && options.onUploadStart()
            
            //开始上传
            options.formData.fileName = originalFile.name
            options.formData.lastModifiedDate = originalFile.lastModifiedDate.getTime()
            tools.sendBlob(options.uploader, xhr, file, options.formData)
        }
        
        //暂停事件
        $element
            .find('#'+ originalFile.id +' > .info > .up_pause')
            .on('click.bjui.upload.pause', function(e) {
                xhr.abort()
                $(this).hide().prev().show()
            })
        
        //取消事件
        $element
            .find('#'+ originalFile.id +' > .info > .up_cancel')
            .off('click.bjui.upload.cancel')
            .on('click.bjui.upload.cancel', $.proxy(function(e) {
                this.tools.removeQueueItem(e, xhr)
            }, this))
    }
    
    Upload.prototype.onProgress = function(file, loaded, total) {
        var that        = this, options = that.options
        var $progress   = that.$element.find('#'+ file.id + ' .progress')
        var thisLoaded  = loaded
        //根据上一次触发progress时上传的大小，得到本次的增量
        var lastLoaded  = $progress.attr('lastLoaded') || 0
        
        loaded -= parseInt(lastLoaded)
        if (loaded > file.size) loaded = file.size
        
        that.$progressBar = $progress.children('.bar')
        var oldWidth      = options.breakPoints ? parseFloat(that.$progressBar.get(0).style.width || 0) : 0
        var percent       = (loaded / total * 100 + oldWidth).toFixed(2)
        var percentText   = percent > 100 ? '100%' : percent + '%'
        
        //校正四舍五入的计算误差
        if (options.showUploadedSize) {
            var $filesize = $progress.nextAll('.filesize')
            
            $filesize.find('> .uploadedsize').text(that.tools.formatFileSize(loaded))
        }
        if (options.showUploadedPercent) {
            $progress.nextAll('.up_percent').text(percentText)
        }
        that.$progressBar.css('width', percentText)
        //记录本次触发progress时已上传的大小，用来计算下次需增加的数量
        if (thisLoaded < options.fileSplitSize) {
            $progress.attr('lastLoaded', thisLoaded)
        } else {
            $progress.removeAttr('lastLoaded')
        }
    }
    
    Upload.prototype.destroy = function() {
        
    }
    
    // UPLOAD PLUGIN DEFINITION
    // =======================
    
    function Plugin(option) {
        var args     = arguments
        var property = option
        
        if (window.FileReader) {
            return this.each(function () {
                var $this   = $(this)
                var options = $.extend({}, Upload.DEFAULTS, $this.data(), typeof option == 'object' && option)
                var data    = $this.data('bjui.upload')
            
                if (!data) $this.data('bjui.upload', (data = new Upload(this, options)))
                if (typeof property == 'string' && $.isFunction(data[property])) {
                    [].shift.apply(args)
                    if (!args) data[property]()
                    else data[property].apply(data, args)
                } else {
                    data.init()
                }
            })
        } else { //for IE8-9
            this.each(function() {
                if (!$.fn.uploadify) return
                var options = {
                    swf           : BJUI.PLUGINPATH +'uploadify/scripts/uploadify.swf',
                    fileTypeExts  : '*.jpg;*.png',
                    id            : 'fileInput',
                    fileObjName   : 'file',
                    fileSizeLimit : 204800,
                    buttonText    : '选择上传文件',
                    auto          : false,
                    multi         : false,
                    height        : 24
                }
                var $element = $(this), op = $element.data()
                
                if (!op.id) op.id = $element.attr('id')
                $.extend(options, op)
                if (!(options.uploader)) {
                    BJUI.debug('Upload Plugin: The options uploader is undefined!')
                    return
                } else {
                    options.uploader = decodeURI(options.uploader).replacePlh($element.closest('.unitBox'))
                    
                    if (!options.uploader.isFinishedTm()) {
                        $element.alertmsg('error', (options.warn || FRAG.alertPlhMsg.replace('#plhmsg#', BJUI.regional.plhmsg)))
                        BJUI.debug('Upload Plugin: The options uploader is incorrect: '+ options.uploader)
                        return
                    }
                    
                    options.uploader = encodeURI(options.uploader)
                }
                if (options.id == 'fileInput') options.id = options.id + (new Date().getTime())
                var $file = $('<input type="file" name="'+ options.name +'" id="'+ options.id +'">')
                
                if (options.onInit && typeof options.onInit == 'string')
                    options.onInit = options.onInit.toFunc()
                if (options.onCancel && typeof options.onCancel == 'string')
                    options.onCancel = options.onCancel.toFunc()
                if (options.onSelect && typeof options.onSelect == 'string')
                    options.onSelect = options.onSelect.toFunc()
                if (options.onUploadSuccess && typeof options.onUploadSuccess == 'string')
                    options.onUploadSuccess = options.onUploadSuccess.toFunc()
                if (options.onUploadComplete && typeof options.onUploadComplete == 'string')
                    options.onUploadComplete = options.onUploadComplete.toFunc()
                if (options.onUploadError && typeof options.onUploadError == 'string')
                    options.onUploadError   = options.onUploadError.toFunc()
                
                $file.appendTo($element)
                if (!options.auto) {
                    var $upBtn = $('<button class="btn btn-orange" data-icon="cloud-upload">开始上传</button>')
                    
                    $upBtn
                        .hide()
                        .insertAfter($element)
                        .click(function() {
                            $file.uploadify('upload', '*');
                            $(this).hide()
                        })
                        
                    options.onSelect = function() {
                        $upBtn.show()
                    }
                }
                $file.uploadify(options)
            })
        }
    }
    
    var old = $.fn.upload
    
    $.fn.upload             = Plugin
    $.fn.upload.Constructor = Upload
    
    // UPLOAD NO CONFLICT
    // =================
    
    $.fn.upload.noConflict = function () {
        $.fn.upload = old
        return this
    }
    
    // UPLOAD DATA-API
    // ==============
    
    $(document).on(BJUI.eventType.initUI, function(e) {
        var $this = $(e.target).find('[data-toggle="upload"]')
        
        if (!$this.length) return
        
        Plugin.call($this)
    })

}(jQuery);