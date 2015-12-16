#!/bin/bash -xe
# Database credentials
 user="root"
 password="cb7ebb"
 host="localhost"
 db_name="wordpress"
# Other options
 backup_path="/var/www/html"
 #date=$(date +"%d-%b-%Y")
# Set default file permissions
 umask 177
# Dump database into SQL file
 mysqldump --user=$user --password=$password --host=$host $db_name > $backup_path/wordpress.sql
# Delete files older than 30 days
# find $backup_path/* -mtime +30 -exec rm {} \;
cd /var/www/
/bin/tar czvf /var/www/shared.tar.gz html/wp-content/uploads/ html/wp-content/upgrade html/wp-config.php

aws s3 cp /var/www/shared.tar.gz s3://wordpres-shared
aws s3 cp /var/www/html/wordpress.sql s3://wordpres-shared
