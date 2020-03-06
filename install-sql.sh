#!/bin/bash
HOSTNAME=$DATABASE_HOST #数据库信息

PORT=$DATABASE_PORT

USERNAME=$DATABASE_USER
PASSWORD=$DATABASE_PWD

DBNAME=$DATABASE_NAME'_encoder'  #数据库名称


ADMINUSER=$ADMIN_USER
ADMINPASSWORD=$ADMIN_PWD
WEBTITLE=$WEB_TITLE #网站title
WEBURL='https://'$WEB_URL'.video.poy.cn'; #网站域名





#创建数据库

create_db_sql="create database IF NOT EXISTS ${DBNAME}"

mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} -e "${create_db_sql}"
mysql -h${HOSTNAME} -u${USERNAME} -p${PASSWORD} ${DBNAME} < /var/www/html/install/database.sql

#sign=`echo -n  $ADMINPASSWORD | md5sum`
#sign=`echo -n $ADMINPASSWORD |md5sum|cut -d ' ' -f1`


#插入初始化管理员账号
insert_admin_sql="INSERT INTO streamers (siteURL, user, pass, priority, created, modified, isAdmin) VALUES ('${WEBURL}', '${ADMINUSER}', '${ADMINPASSWORD}', 1, now(), now(), 1)"
mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} ${DBNAME} -e "${insert_admin_sql}"



#插入默认配置
insert_congig_sql="INSERT INTO configurations (id, allowedStreamersURL, defaultPriority, version, created, modified) VALUES (1, '', 1, '2.6', now(), now())"


mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} ${DBNAME} -e "${insert_congig_sql}"