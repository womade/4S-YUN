#!/bin/sh
cat <<-EOF > /root/cloudreve/ssss.ini

[System]
Mode = master
Listen = :${PORT}
Debug = false
SessionSecret = ssss
HashIDSalt = 0000

[Database]
; 数据库类型，目前支持 sqlite | mysql
Type = mysql
; 数据库地址
Host = $DB_Host
; MySQL 端口
Port = 3306
; 用户名
User = $DB_User
; 密码
Password = $DB_Password
; 数据库名称
Name = $DB_Name
; 数据表前缀
TablePrefix = s_

EOF

/root/aria2/trackers-list-aria2.sh
/root/cloudreve/cloudreve -c /root/cloudreve/ssss.ini