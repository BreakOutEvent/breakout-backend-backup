#!/usr/bin/env bash

# The following env variables need to be defined
#
# $BREAKOUT_DATABASE_NAME: Name of the database to be backuped
# $BREAKOUT_DATABASE_USER: Database user with at least read priviledges
# $BREAKOUT_DATABASE_PW: Password of the database user
#
# $BREAKOUT_BACKUP_PW: Password used for encrypting the zipped backup

# $BREAKOUT_OWNCLOUD_USER: Username of an owncloud user
# $BREAKOUT_OWNCLOUD_PW: Password of the owncloud user
# $BREAKOUT_OWNCLOUD_URL: The url of the owncloud, including the folder where
# to put the backup. Make sure this folder exists before!

# Dump database to file
echo `date +%Y-%m-%d:%H:%M:%S`: Starting dump of database $BREAKOUT_DATABASE_NAME

DATE=`date +%Y-%m-%d:%H:%M:%S`
FILENAME=${DATE}-breakout-backend.sql

mysqldump -h breakout-mariadb -u $BREAKOUT_DATABASE_USER --password=$BREAKOUT_DATABASE_PW $BREAKOUT_DATABASE_NAME > $FILENAME
echo `date +%Y-%m-%d:%H:%M:%S`: Finished dump of database $BREAKOUT_DATABASE_NAME

# Encrypt dumped database file
echo `date +%Y-%m-%d:%H:%M:%S`: Encrypting and zipping file
FILENAMEZIP=${FILENAME}.zip
zip -e -P "$BREAKOUT_BACKUP_PW" -9 "$FILENAMEZIP" "$FILENAME"

# Upload file to owncloud
echo `date +%Y-%m-%d:%H:%M:%S`: Uploading file to owncloud
curl -T "$FILENAMEZIP" -u "${BREAKOUT_OWNCLOUD_USER}:${BREAKOUT_OWNCLOUD_PW}" "${BREAKOUT_OWNCLOUD_URL}${FILENAMEZIP}"

# Remove backup file
#rm $FILENAME
#rm $FILENAMEIZP
