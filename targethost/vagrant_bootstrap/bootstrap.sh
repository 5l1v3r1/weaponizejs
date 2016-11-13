#!/bin/bash

RDBPWD=$1
DBNAME=$2
DBUSER=$3
DBPASSWD=$4
APPDIR=$5

sudo apt-get upgrade -y openssl >> /dev/null
sudo apt-get update >> /dev/null
sudo apt-get install -y curl >> /dev/null

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs build-essential redis-server vim >> /dev/null

#echo "mysql-server mysql-server/root_password password $RDBPWD" | debconf-set-selections
#echo "mysql-server mysql-server/root_password_again password $RDBPWD" | debconf-set-selections
#apt-get -y install mysql-server-5.5 >> /dev/null

#mysql -uroot -p$RDBPWD -e "CREATE DATABASE $DBNAME"
#mysql -uroot -p$RDBPWD -e "grant all privileges on $DBNAME.* to '$DBUSER'@'localhost' identified by '$DBPASSWD'"

#mysql -u$DBUSER -p$DBPASSWD $DBNAME < $APPDIR/sql_scripts/create_db.sql
#mysql -u$DBUSER -p$DBPASSWD $DBNAME < $APPDIR/sql_scripts/seed_dev.sql

sudo service redis-server restart

sudo iptables -t nat -A PREROUTING -i eth1 -p tcp --dport 80 -j REDIRECT --to-port 8080

cd $APPDIR
npm install --save

echo Finished setup.
