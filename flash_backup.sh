#!/bin/bash

HOME_NAME=/home/al
RSYNC=$HOME_NAME/projects/rsync/rsync
#RSYNC=/usr/bin/rsync
#TODO: EXCLUDES
EXCLUDES=$HOME_NAME/projects/backup/exclude_file
FLASH_DRIVE_NAME=flash32g
MOUNT_DIR='/run/media/al'/$FLASH_DRIVE_NAME
BACKUP_DIR=/backup

TOBACKUP=(/usr/lib/systemd/system \
$HOME_NAME/Downloads \
$HOME_NAME/Documents \
$HOME_NAME/projects \
$HOME_NAME/.vim \
$HOME_NAME/.local/share/gnome-shell/extensions \
$HOME_NAME/.gnupg \
$HOME_NAME/.config \
$HOME_NAME/.mozilla/firefox \
$HOME_NAME/.thunderbird \
$HOME_NAME/.local/share/themes)

FILES_TO_BACKUP=($HOME_NAME/.bashrc \
$HOME_NAME/.bash_history \
$HOME_NAME/.vimrc \
/etc/fstab)

#result=$(udisksctl mount -b /dev/disk/by-label/$FLASH_DRIVE_NAME 2>&1);
#if echo "$result" | grep -q "Error looking up"; then
#  echo $result > ~/.dirs_backup.log
#  echo $result > ~/.files_backup.log
#  exit
#fi
#

mountpoint=$(lsblk -o MOUNTPOINT | grep $FLASH_DRIVE_NAME)
if [[ -n $mountpoint ]]
then
  :
else
  echo "Error. Drive not mounted" > $HOME_NAME/.dirs_backup.log
  echo "Error. Drive not mounted" > $HOME_NAME/.files_backup.log
  exit 0
fi

if [ ! -d $MOUNT_DIR$BACKUP_DIR ]
then
  mkdir -p $MOUNT_DIR$BACKUP_DIR
fi

for x in ${TOBACKUP[*]}
do
  if [ ! -d $MOUNT_DIR$BACKUP_DIR/${x} ]
  then
    mkdir -p $MOUNT_DIR$BACKUP_DIR/${x}
  fi
  $RSYNC --perms -vrlt --delete --delete-excluded --exclude-from=$EXCLUDES /${x}/ \
         $MOUNT_DIR$BACKUP_DIR/${x} > $HOME_NAME/.dirs_backup.log 2>&1
done

for x in ${FILES_TO_BACKUP[*]}
do
  $RSYNC --perms -v ${x} $MOUNT_DIR$BACKUP_DIR > $HOME_NAME/.files_backup.log 2>&1
done

#udisksctl unmount -b /dev/disk/by-label/$FLASH_DRIVE_NAME 2>&1

exit 0
