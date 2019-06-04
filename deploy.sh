#!/usr/bin/env bash
# Jenkins 部署脚本

#需要配置如下参数
# 项目路径, 在Execute Shell中配置项目路径, pwd 就可以获得该项目路径
# export JENKINS_PATH=这个jenkins任务在部署机器上的路径

# 输入你的环境上tomcat的全路径
# export TOMCAT_APP_PATH=tomcat在部署机器上的路径

# 输入项目名称
# export PROJECT_NAME = 项目名称

### base 函数
killTomcat()
{
    pid=`ps -ef|grep tomcat|grep java|awk '{print $2}'`
    echo "tomcat Id list :$pid"
    if [ "$pid" = "" ]
    then
      echo "no tomcat pid alive"
    else
      kill -9 $pid
    fi
}
cd $JENKINS_PATH/$PROJECT_NAME
mvn clean install

# 停tomcat
killTomcat

# 删除原有工程
rm -rf $TOMCAT_APP_PATH/webapps/ROOT
rm -rf $TOMCAT_APP_PATH/webapps/ROOT.war
rm -rf $TOMCAT_APP_PATH/webapps/$PROJECT_NAME.war

# 复制新的工程
cp $JENKINS_PATH/$PROJECT_NAME/target/$PROJECT_NAME.war $TOMCAT_APP_PATH/webapps/

cd $TOMCAT_APP_PATH/webapps/
mv $PROJECT_NAME.war ROOT.war

# 启动Tomcat
cd $TOMCAT_APP_PATH/
sh bin/startup.sh



