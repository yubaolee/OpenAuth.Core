# 常见问题处理

## vue运行的时候报错

在启动企业版的时候，如果提示下面错误：

![](/oidcerror.png)

请使用`npm run dev`命令来启动项目


## NodeJs v16中node-sass报错

在使用`npm install`时，最常见的一个错误就是关于node-sass包安装的错误，如下：

```shell

npm ERR! code 1
npm ERR! path D:\OpenAuth.Pro\Client\node_modules\node-sass
npm ERR! command failed
npm ERR! command C:\Windows\system32\cmd.exe /d /s /c node scripts/build.js
npm ERR! Building: C:\Program Files\nodejs\node.exe D:\OpenAuth.Pro\Client\node_modules\node-gyp\bin\node-gyp.js rebuild --verbose --libsass_ext= --libsass_cflags= --libsass_ldflags= --libsass_library=
npm ERR! gyp info it worked if it ends with ok
npm ERR! gyp verb cli [
npm ERR! gyp verb cli   'C:\\Program Files\\nodejs\\node.exe',
npm ERR! gyp verb cli   'D:\\OpenAuth.Pro\\Client\\node_modules\\node-gyp\\bin\\node-gyp.js',
npm ERR! gyp verb cli   'rebuild',
npm ERR! gyp verb cli   '--verbose',
npm ERR! gyp verb cli   '--libsass_ext=',
npm ERR! gyp verb cli   '--libsass_cflags=',
npm ERR! gyp verb cli   '--libsass_ldflags=',
npm ERR! gyp verb cli   '--libsass_library='
npm ERR! gyp verb cli ]
npm ERR! gyp info using node-gyp@3.8.0
npm ERR! gyp info using node@16.13.2 | win32 | x64
npm ERR! gyp verb command rebuild []
npm ERR! gyp verb command clean []
npm ERR! gyp verb clean removing "build" directory
npm ERR! gyp verb command configure []
npm ERR! gyp verb check python checking for Python executable "python2" in the PATH
npm ERR! gyp verb `which` failed Error: not found: python2
...
npm ERR! gyp verb check python checking for Python executable "python" in the PATH
npm ERR! gyp verb `which` failed Error: not found: python
npm ERR! gyp verb `which` failed     at getNotFoundError (D:\OpenAuth.Pro\Client\node_modules\which\which.js:13:12)
...
npm ERR! gyp verb could not find "python". checking python launcher
npm ERR! gyp verb could not find "python". guessing location
npm ERR! gyp verb ensuring that file exists: C:\Python27\python.exe
npm ERR! gyp ERR! configure error
npm ERR! gyp ERR! stack Error: Can't find Python executable "python", you can set the PYTHON env variable.
npm ERR! gyp ERR! stack     at PythonFinder.failNoPython (D:\OpenAuth.Pro\Client\node_modules\node-gyp\lib\configure.js:484:19)
npm ERR! gyp ERR! stack     at PythonFinder.<anonymous> (D:\OpenAuth.Pro\Client\node_modules\node-gyp\lib\configure.js:509:16)
npm ERR! gyp ERR! stack     at FSReqCallback.oncomplete (node:fs:198:21)
npm ERR! gyp ERR! command "C:\\Program Files\\nodejs\\node.exe" "D:\\OpenAuth.Pro\\Client\\node_modules\\node-gyp\\bin\\node-gyp.js" "rebuild" "--verbose" "--libsass_ext=" "--libsass_cflags=" "--libsass_ldflags=" "--libsass_library="
npm ERR! gyp ERR! cwd D:\OpenAuth.Pro\Client\node_modules\node-sass
npm ERR! gyp ERR! node -v v16.13.2
npm ERR! gyp ERR! node-gyp -v v3.8.0
npm ERR! gyp ERR! not ok
npm ERR! Build failed with error code: 1
```

修复方法：

* 修改package.json文件中node-sass版本：

```javascript

"node-sass": "^6.0.1",
```

* 清理node缓存，重新安装：

```shell
npm cache clean --force
npm i

```
