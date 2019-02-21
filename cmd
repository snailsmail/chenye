sudo apt-get install git subversion silversearcher-ag meld git-all openssh-server openssh-client 

ssh-keygen(安装ssh公钥)（cd .ssh/）
安装过程中不需要设置密码，

git添加公钥后报错sign_and_send_pubkey: signing failed: agent refused operation的解决办法：
eval "$(ssh-agent -s)"
ssh-add


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

//删除用户名以及用户名下数据
drop user XXXX cascade;

//创建用户
create user chenye identified by 密码;

//授权
grant dba to chenye;

//查询所有用户
select username form dba_users;

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


//升级node版本
第一步，先查看本机node.js版本：

    $ node -v

第二步，清除node.js的cache：

    $ sudo npm cache clean -f

第三步，安装 n 工具，这个工具是专门用来管理node.js版本的，别怀疑这个工具的名字，是他是他就是他，他的名字就是 “n”

    $ sudo npm install -g n
   （安装后进行软链接，目前这样安装不是全局的）
    sudo ln -s ~/Tools/node-v6.11.2-linux-x64/bin/npm /usr/local/bin/npm      //软连接node

第四步，安装最新版本的node.js

    $ sudo n stable

第五步，再次查看本机的node.js版本：

    $ node -v
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

pm2是一个进程管理工具，可以使用它来管理node进程，并查看node进程状态，也支持性能监控，进程守护，负载均衡等功能。
安装pm2
npm install pm2 -g


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

tomcat部署项目
1.将项目的war包放在tomcat的webapps文件夹中
2.在conf/Calalina/localhost/文件夹下放入项目相关的xml文件，xml文件的文件名要与放在webapps下的war文件名相同
3.xml文件内容是指向项目需要的.properties文件路径
4.conf文件夹下的server.xml文件中可以修改启动项目的端口号等信息

启动项目时：
在tomcat的bin文件夹下输入命令 startup.sh
打印输出的日志,在logs文件夹下 tail -f calalina.out
可以直接在tomcat文件夹下输入命令
	bin/startup.sh ;tail -f logs/catalina.out

关掉项目:
在tomcat的bin文件夹下输入命令 shutdown.sh


####################################################

安装notepadqq方法:
    sudo add-apt-repository ppa:notepadqq-team/notepadqq  
    sudo apt-get update  
    sudo apt-get install notepadqq  

卸载notepadqq方法:
    sudo apt-get remove notepadqq  
    sudo add-apt-repository --remove ppa:notepadqq-team/notepadqq  

####################################################

oracle的一些操作
添加字段： alter table tableName add (字段名 字段类型 默认值 是否为空)
修改字段： alter table tableName modify (字段名 字段类型 默认值 是否为空)
删除字段： alter table tableName drop column 字段名
字段重命名： alter table tableName rename column 列名 to 新列名
表的重命名： alter table tableName rename to 新列名

将varchar2改为clob,先要将数据清空，再把字段先改为long类型再改为clob类型

####################################################

postman 是一个 HTTP 通信测试工具，REST API 的练习会用到它。

（1）下载

     Postman下载地址：https://www.getpostman.com/

（2）解压安装

    sudo tar -xzf Postman-linux-x64-5.5.3.tar.gz

    此时，在当前目录出现一个Postman文件夹。

    启动Postman

    ./Postman/Postman

（3）创建启动图标

    每次进入Postman目录很不方便，可以创建一个启动项。

     1.建立软链接

       sudo ln -s  /home/chenye/hdd/Postman/Postman   /usr/local/bin/postman    (前面地址为安装目录，后面软链接地址)

    2.创建启动项文件

      sudo vim  /usr/share/applications/postman.desktop

      写入：

      [Desktop Entry]

      Encoding=UTF-8

      Name=Postman

      Exec=/usr/local/bin/postman

      Icon=/home/chenye/hdd/Postman/resources/app/assets/icon.png

      Terminal=false

      Type=Application

      Categories=Development;

 在dash里就可以搜索到Postman。





####################################################


//datatable某列隐藏以及显示
$(document).ready(function() { 
   var myTable = $('#example').dataTable(); 
   myTable.column(0).visible(false)//将第一列的数据隐藏
   myTable.column(1).visible(true)//让第二列的数据显示
} );

$('tr').find('td:eq(0)').hide();

####################################################
Visual Studio Code 开发node
####################################################

--------------------数据泵导入----------------------
1、以sysdba 进入sqlplus
sqlplus / as sysdba     用户名 sys as sysdba 密码eams
2、创建用户
create user shnu170104（用户名） identified by eams（密码）;
3、赋予用户权限
grant connect,resource,dba to shnu170104;
4、退出sysdba
exit;
5、以新建用的用户身份进入sqlplus
sqlplus

6、创建目录
create directory shnu170104 as 'D:\shnu';
7、退出当前sqlplus
exit;
8、以sysdba 进入sqlplus 并将目录权限赋予新建用户
grant read, write on directory shnu170104 to shnu170104

9 退出sqlplus
10、导入
（退出数据库登录时导入）
impdp shnu170104/eams directory=shnu170104 dumpfile=shnu0104.dpdmp （导出的数据泵文件名）logfile=shnu170104.log FULL=y remap_schema=eams_JW:shnu170104 （导出数据库登录名：导入数据库登录名）remap_tablespace=users:users（导出数据库表空间：导入数据库表空间）
有多个不同表空间时的导入：
impdp shnu170104/eams directory=shnu170104 dumpfile=shnu0104.dpdmp logfile=shnu170104.log FULL=y remap_schema=eams_JW:shnu170104 remap_tablespace=users:users

impdp jdz170822/eams directory=shnu170814 dumpfile=eams20170822.dpdmp FULL=y remap_schema=eams:jdz170822 remap_tablespace=users:users2

要把导入的dpdmp文件放在创建的目录里


####################################################
mongoDb安装
curl -O https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-3.0.6.tgz    # 下载（版本号可以修改）
或直接下载
下载地址：https://www.mongodb.com/download-center#community
tar -zxvf mongodb-linux-x86_64-3.0.6.tgz                                   # 解压

mv mongodb-linux-x86_64-3.0.6/ /usr/local/mongodb                          # 将解压包拷贝到指定目录

在.bashrc文件中添加export PATH=/usr/local/mongodb/bin:$PATH
source ~/.bashrc

$ cd /usr/local/mongodb/bin

#$ ./mongod --dbpath=~/hdd/mongodb/data/db 指定mongodb启动的数据库路径 启动
#sudo ./mongod --dbpath=~/hdd/mongodb/data/db  --fork --logpath=~/hdd/mongodb/data/logs   #常驻 --fork
或
sudo gedit mongodb.conf 
修改掉
# Where to store the data.
dbpath=~/hdd/mongodb/data/db
#where to log
logpath=~/hdd/mongodb/data/logs

之后可以直接启动mongodb
$ ./mongod //启动
$ mongo //进入shell

mongodb远程链接
 1、首先修改mongodb的配置文件 让其监听所有外网ip

编辑文件：/etc/mongodb.conf

修改后的内容如下：

    bind_ip = 0.0.0.0

    port = 27017

   auth=true

2、/etc/init.d/mongodb restart

3、连接 

#本地连接
/usr/local/mongodb/bin/mongo

 
#远程连接
 
/usr/local/mongodb/bin/mongo 127.0.0.1/admin -u username -p password
4、给某个数据库添加用户访问权限
  db.addUser('user','pwd')
  db.auth('user','pwd')
5、删除用户
db.removeUser('username')


1.通过非授权的方式启动mongo

2.创建admin数据库

use admin

3.添加管理员用户
db.createUser({user:"admin",pwd:"123456",roles:["root"]})

备注：用户名和密码可随意定

4.认证

db.auth("admin", "123456")



