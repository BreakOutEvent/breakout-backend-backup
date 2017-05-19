# breakout-backend-backup
Docker container periodically running a backup script to transfer from a database to the owncloud

# Usage
```bash
docker run -e BREAKOUT_DATABASE_NAME=database \
-e BREAKOUT_DATABASE_USER=username \
-e BREAKOUT_DATABASE_PW="password" \
-e BREAKOUT_BACKUP_PW=password_of_backup \
-e BREAKOUT_OWNCLOUD_USER=owncloud_user \
-e BREAKOUT_OWNCLOUD_PW=owncloud_password \
-e BREAKOUT_OWNCLOUD_URL=https://baseurl/remote.php/webdav/foldername/ \
--link databasecontaintername:breakout-mariadb \
-d registry_name/imagename:version
```

# Todos
- [ ] Move from deprecated `--link` to `docker network`

This is based on https://github.com/thepiwo/backup-to-owncloud, thanks! 🙌
