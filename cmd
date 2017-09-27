sudo apt-get install git subversion silversearcher-ag meld git-all openssh-server openssh-client 

ssh-keygen(安装ssh公钥)（cd .ssh/）
######################################################################

//安装jdk
下载解压后
在.bashrc文件中添加
export JAVA_HOME=/home/chenye/Tools/jdk1.8.0_144
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH

测试
jdk -version
######################################################################

//安装maven
下载解压后
在.bashrc文件中添加
export M2_HOME=/home/chenye/Tools/apache-maven-3.0.5
export M2=$M2_HOME/bin
export PATH=$M2:$PATH

测试
mvn -version
######################################################################

//git

git config --global user.name "Your Name"
git config --global user.email "email@example.com"
git config --global alias.st status
git config --global core.quotepath false(乱码问题)
######################################################################

//安装shadowsocks
sudo add-apt-repository ppa:hzwhuang/ss-qt5
sudo apt-get update
sudo apt-get install shadowsocks-qt5
######################################################################

//登陆别人的电脑
ssh xx@192.168.1.xxx
//从别人电脑上传东西
 scp xx@192.168.1.xxx:~/xxx ~/xx/
######################################################################

//安装redis
sudo apt-get install redis-server
在命令行输入：redis-cli进入redis命令（FLUSHALL 删除所有现有的数据库）
在命令行输入：redis-server启动redis
######################################################################

//将本地文件传到github上
准备工作：新建一个新的全库，然后在setting的ssh key上讲公钥贴进去
测试公钥是否正确  ssh -T git@github.com 出现hi XXX，you have successfully authenticated
1.新建文件夹
mkdir test
cd test
 git clone git@github.com:snailsmail/chenye.git

2.git init
git add .
git commit -m 'aa'
git remote add origin git@github.com:snailsmail/chenye.git
git push origin master

若执行git remote add origin出现错误则执行 git remote rm origin
git remote add origin git@github.com:snailsmail/chenye.git

在执行git push origin master报错时 执行git pull origin master
再执行 git push origin master


######################################################################
bash-git-prompt

1. Clone this repository to your home directory.

	cd ~
	git clone https://github.com/magicmonty/bash-git-prompt.git .bash-git-prompt --depth=1

2.Add to the ~/.bashrc:

	GIT_PROMPT_ONLY_IN_REPO=1
	source ~/.bash-git-prompt/gitprompt.sh


######################################################################

df -h (查询各挂载点的内存)
dpkg --get-selections | grep linux（查看安装的旧的内核）

free -m （查看内存使用情况）

进程查询
ps -ef | grep java

######################################################################

//数据库数据的导出
exp eams_500_hf_test/1@192.168.1.250:1521/orcl file=~/Tools/oracle.dmp full=y

//数据库数据导入
imp xxx/xxx:orcl file=~/Tools/oracle.dmp fromuser=eams_500_hf_test touser=chenye

//数据库查看系统时间
SELECT sysdate from dual;

//启动数据库
sudo service oracle-xe start

######################################################################

//进入ubuntu图形界面失败
//按shift + f1 进入命令行界面
//输入用户名密码，进入用户命令行界面，
//然后更新软件
sudo apt-get update(更新)
sudo apt update
sudo apt-get upgrade（升级）
sudo apt upgrade

######################################################################

//安装ndoejs npm grunt bower n(用于node的版本管理)

//安装node 和 npm
在官网（ https://nodejs.org）下载最新的LTS版本node，
在本地解压
1 sudo ln -s ~/Tools/node-v6.11.2-linux-x64/bin/node /usr/local/bin/node    //软连接node
2 sudo ln -s ~/Tools/node-v6.11.2-linux-x64/bin/npm /usr/local/bin/npm      //软连接node

3 node -v 			      //查看版本号
4 npm -v			      //查看版本号

//yeoman是一整套前端解决方案，核心组件是yo，因此只需要安装yo即可
1 sudo npm install -g yo             //安装yo，全局安装
2 yo --version                       //检查版本号

//bower，grunt 的安装
1 sudo npm install -g bower          //安装bower，全局安装
2 sudo npm install -g grunt-cli      //安装grunt , 全局安装

3 bower -v                           //查看版本号
4 grunt -v       		     //查看版本号

//全局安装/本地安装
　　全局安装：将模块安装在/usr/local/lib/node_modules/下
　　本地安装：将模块安装在当前目录下的node_modules/（node_modules/是自动生成的）如果要使用模块命令只能在该目录下使用

//卸载模块
1 sudo npm uninstall moduleName      //卸载本地安装的模块
2 sudo npm uninstall -g moduleName   //卸载全局安装的模块   


######################################################################

//禁用右键菜单
 $(document).bind("contextmenu",function(e){
   return false;
 });
######################################################################
git log -g
git checkout -b bugfix/cy-grade-04 94ce435759233ab41f9fecdf7fbfe36fc39e0f88

//撤销提交
git reset --hard  commit-id2
git push origin HEAD --force




######################################################################
angular2-quickstart 
git clone https://github.com/angular/quickstart.git quickstart
cd quickstart
npm install
npm start
####################################################################################################################
angular应用程序是由组件组成：一个组价是一个组合，由一个HTML模板和一个组件类（控制一部分屏幕）组成
app/app.component.ts

	import { Component } from '@angular/core';
	@Component({
		selector: 'my-app',
		template: '<h1>Hello {{name}} </h1>'
	})
	export class AppComponent { name = 'Angular'; }
####################################################################################################################
写一个Angular 2的应用最基本的步骤概括为三步：写root组件，启动它（Boostrap），写index.html。
1.一些关于命名空间的基本知识
把所有代码放入一个立即调用的函数中，通过传入一个空对象app，实现对命名空间的隔离，避免了
污染全局命名空间。
//app.component.js
(function(app) {
	app.AppComponent = 
	ng.core.Component({
		selector: '#my-app',
		template: "<h1>My First Angular 2 App</h1>"
	})
	.Class({
		constructor: function () {}
	});
})(window.app || (window.app = {}));
将要导出的内容添加到app命名空间内，比如我们通过app.AppComponent=...,来将AppComponent导出，
其他文件通过app对象来使用。
一个组件控制一个视图，严格意义上组件就是class。
它使用NG的core命名空间中的Component方法和Class方法定义。
Component方法：接收一个具有两个属性的对象作为配置参数，selector是选择器（同jQuery选择器），template是渲染视图的内容（html）。

Class方法：接收一个对象，用于实现component，通过给它属性和方法来绑定到视图，定义它的行为（constructor属性是一个函数，用于定义这些行为？）

//boot.js
(function  (app) {
  document.addEventListener('DOMContentLoaded',function() {
    // 页面文档完全加载并解析完毕之后，调用bootstrap方法，传入根组件AppComponent来启动它
    ng.platform.browser.bootstrap(app.AppComponent);
  });
})(window.app || (window.app = {}));

页面文档完全加载并解析完毕之后，会触发DOMContentLoaded事件，HTML文档不会等待样式文件、图片文件、子框架页面的加载(load事件可以用来检测HTML页面是否完全加载完毕(fully-loaded))。

//index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Angular 2</title>
    <!-- IE required polyfill -->
    <script src="node_modules/es6-shim/es6-shim.min.js"></script>

    <!-- Angular所需的lib -->
    <script src="node_modules/angular2/bundles/angular2-polyfills.js"></script>
    <script src="node_modules/rxjs/bundles/Rx.umd.js"></script>
    <script src="node_modules/angular2/bundles/angular2-all.umd.js"></script>

    <!-- 自己编写的模块 -->
    <script src='app/app.component.js'></script>
    <script src='app/boot.js'></script>
</head>
<body>
    <!-- Angular需要通过selector找到的视图 -->
    <div id="my-app">Loading...</div>
</body>
</html>

需要注意的是boot.js要放在app.component.js之后，当Angular调用boot.js的启动程序，它读取AppComponent组件，找到“my-app”选择器，定位到一个id为“my-app”的元素，将template的内容加载到元素里面。

 

使用npm start来启动程序，在package.json的配置中实际上将npm start命令映射到了启动lite-server服务，它可以监控文件改动，实现自动刷新。

//package.json
{
  "name": "angular2-quickstart",
  "version": "1.0.0",
  "scripts": {
    "start": "npm run lite",
    "lite": "lite-server"
  },
  "license": "ISC",
  "dependencies": {
    "angular2": "2.0.0-beta.0",
    "systemjs": "0.19.6",
    "es6-promise": "^3.0.2",
    "es6-shim": "^0.33.3",
    "reflect-metadata": "0.1.2",
    "rxjs": "5.0.0-beta.0",
    "zone.js": "0.5.10"
  },
  "devDependencies": {
    "lite-server": "^1.3.1"
  }
}
////////////////////////////////////////////////////////////
安装webstorm
1.在官网地址:http://www.jetbrains.com/webstorm/　下载webstorm
2.
解压

tar zxvf WebStorm-172.3544.10.tar.gz

移动

sudo mv WebStorm-172.3544.10/ /opt/WebStorm-172.3544.10/

创建链接

sudo ln -s /opt/WebStorm-172.3544.10/ /opt/WebStorm

启动

/opt/WebStorm/bin/webstorm.sh

####################################################3
oracle日期处理
to_date('2017-09-09', 'yyyy-MM-dd hh24:mi:ss')
####################################################3



