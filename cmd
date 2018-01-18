sudo apt-get install git subversion silversearcher-ag meld git-all openssh-server openssh-client 

ssh-keygen(安装ssh公钥)（cd .ssh/）
######################################################################

//ubuntu 文件权限(chown chmod)
http://zhaoyuqiang.blog.51cto.com/6328846/1214718

使用命令chomd改变文件的读写权限
chomd 777 **.**(给某文件赋读写权限)

使用命令chown改变目录或文件的所有权
chown chenye:chenye **.**(修改某文件的所有权和所属权)

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
git config --global credential.helper store（解决每次提交都要输入用户名密码问题）

这些命令会在～/.gitconfig文件下生成相应的设置


删除远程tag: 
    git push origin :v1.1   
    //也可以这样  
    git push origin --delete tag V1.1 
删除本地tag: 
	git tag -d v1.1
打tag
git tag -a v1.1 -m "注释"  
git push origin v1.1  
//查看所有tag  
git tag -l 
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

//eams-ui地址
http://192.168.1.249/eams-ui/

_gh_pages/index.html是项目的第一个页面

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

/etc/fstab 存放系统挂载信息
amount -a 修改/etc/fstab文件让它立即执行

安装gparted调整linux分区大小
sudo apt-get install gparted

进程查询
ps -ef | grep java

内核版本
uname -r

查看系统信息
cat /etc/lsb-release

######################################################################
oracle 11g xe
刚装上登不进去sqlplus：
sqlplus
as sysdba
sys
***(安装过程中的密码)

登录进去后：
shutdown
startup

然后可以创建新用户密码了
create user ** identified by **;
grant dba to **;

######################################################################
dmp文件的导出和导入
//数据库数据的导出
exp eams_500_hf_test/1@192.168.1.250:1521/orcl file=~/Tools/oracle.dmp full=y
//数据库数据导入
imp xxx/xxx:orcl file=~/Tools/oracle.dmp fromuser=eams_500_hf_test touser=chenye

dpdmp文件的导出和导入
1）.数据泵工具导出的步骤：
	1.创建directory
		create directory eams_dir as '/home/chenye';
	2.授权
		grant read,write on directory eams_dir to chenye_180109;
	--查看目录及权限
		select privilege, directory_name, derectory_path from user_tab_privs t, all_directories d where t.table_name(+)=d.directory_name order by 2,1;
	3.执行导出
		expdp chenye/123456@xe schemas=chenye directory=eams_dir dumpflie=expdp_eams.dpdmp logfile=expdp_eams.dplog full=y;
	4.执行导入
		impdp chenye_180109/123456@xe directory=eams_dir dumpfile=expdp_eams.dpdmp logfile=expdp_eams.dplog remap_schemas=chenye:chenye_180109

//数据库查看系统时间
SELECT sysdate from dual;

//启动数据库
sudo service oracle-xe start

//查看表结构
select dbms_metadata.get_ddl('TABLE', 'LESSON_SURVEY_ANSWER') FROM dual;

//创建序列
CREATE SEQUENCE SEQ_LESSON_SURVEY_TASK;

//查询序列
select SEQ_LESSON_SURVEY_TASK.nextval from dual

oracle日期处理
to_date('2017-09-09', 'yyyy-MM-dd hh24:mi:ss')

//impdp时报错ORA-39083&ORA-01917
impdp 加个选型： exclude=grant

/*分为四步 */
/*第1步：创建临时表空间  */
create temporary tablespace user_temp  
tempfile '~\user_temp.dbf' 
size 50m  
autoextend on  
next 50m maxsize 20480m  
extent management local;  
 
/*第2步：创建数据表空间  */
create tablespace user_data  
logging  
datafile '~\user_data.dbf' 
size 50m  
autoextend on  
next 50m maxsize 20480m  
extent management local;  
 
/*第3步：创建用户并指定表空间  */
create user username identified by password  
default tablespace user_data  
temporary tablespace user_temp;  
 
/*第4步：给用户授予权限  */
grant connect,resource,dba to username;
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
4 grunt --version      		     //查看版本号

//全局安装/本地安装
　　全局安装：将模块安装在/usr/local/lib/node_modules/下
　　本地安装：将模块安装在当前目录下的node_modules/（node_modules/是自动生成的）如果要使用模块命令只能在该目录下使用

//卸载模块
1 sudo npm uninstall moduleName      //卸载本地安装的模块
2 sudo npm uninstall -g moduleName   //卸载全局安装的模块   
npm update -g npm(更新npm)

######################################################################

淘宝NPM镜像（npm下载在国外服务器，速度过慢，选择淘宝NPM镜像提高速度）
 npm install -g cnpm --registry=https://registry.npm.taobao.org
安装模块直接 cnpm install [name] 命令
查询版本: cnpm -v 

######################################################################

使用cnpm安装vue-cli 和 webpack
cnpm install -g vue-cli
sudo ln -s ~/Tools/node-v6.11.2-linux-x64/bin/vue /usr/local/bin/vue
查询版本: vue -V(注意V大写)
若无法识别‘vue’，可能时npm版本过低，执行npm install -g npm 更新版本
cnpm install -g webpack
sudo ln -s ~/Tools/node-v6.11.2-linux-x64/bin/webpack /usr/local/bin/webpack
查询版本: webpack -v

######################################################################

sudo apt install jekyll
######################################################################

git log -g
git checkout -b bugfix/cy-grade-04 94ce435759233ab41f9fecdf7fbfe36fc39e0f88

//撤销提交
git reset --hard  commit-id2
git push origin HEAD --force

//删除远程分支
git push origin :feature/cy01
######################################################################
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

激活码
2017.2.27更新
选择“license server” 输入：http://idea.imsxm.com/

####################################################
IDEA注册码地址
http://idea.lanyus.com/
####################################################
hexo　一款基于Node.js的静态博客框架
####################################################
MathMl
MathJax
####################################################
eams-bootstrap-ui项目
１．npm install
２．bower install
３．grunt dist docs
４．(jektll build)jekyll serve
####################################################
设置desktop（以idea为例）
idea的启动文件在idea文件夹下的bin/idea.sh,点击运行
一般的desktop文件在/usr/share/applications/下

####################################################
安装qq
1.安装wine
wget https://dl.winehq.org/wine-builds/Release.key
sudo apt-key add Release.key
sudo apt-add-repository 'https://dl.winehq.org/wine-builds/ubuntu/'
sudo apt-get update
sudo apt-get install winehq-devel

2.下载安装包 
链接: https://pan.baidu.com/s/1nu8UXiL 密码: s7ps
tar xvf wineQQ8.9_19990.tar.xz -C ~/

卸载qq的方法：

rm -rf ~/.wine

rm -rf ~/.local/share/applications/wine-QQ.desktop

rm -rf ~/.local/share/icons/hicolor/256x256/apps/QQ.png

rm -rf ~/.fonts/simsun.ttc
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################
####################################################


