
source .env

sudo tar -czvf $BACKUPTARGET/nextcloud-backup_`date +"%d_%m_%Y.tar.gz"` -C $DIR_NEXTCLOUD data themes config  2>&1 | tee $BACKUPTARGET/nextcloud-backup_`date +"%d_%m_%Y.log"`