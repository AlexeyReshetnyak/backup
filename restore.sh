#!/bin/bash

MOUNT_DIR='/run/media/al/flash32g'
BACKUP_DIR=backup

#cp -rv $MOUNT_DIR/$BACKUP_DIR/home/al/projects/* /home/al/projects
#cp -rv $MOUNT_DIR/$BACKUP_DIR/home/al/.vim/* /home/al/.vim
#cp -rv $MOUNT_DIR/$BACKUP_DIR/home/al/.local/share/gnome-shell/extensions* /home/al/.local/share/gnome-shell/extensions
cp -rv $MOUNT_DIR/$BACKUP_DIR/home/al/Downloads/*  /home/al/Downloads
cp -rv $MOUNT_DIR/$BACKUP_DIR/home/al/Documents/* /home/al/Documents
cp -rv $MOUNT_DIR/$BACKUP_DIR/home/al/projects/backup/notify_backup_errors.desktop ~/.config/autostart

#cp -v $MOUNT_DIR/$BACKUP_DIR/.vimrc /home/al/
#mkdir -p /home/al/.config/run-or-raise
#cp -v $MOUNT_DIR/$BACKUP_DIR/shortcuts.conf /home/al/.config/run-or-raise
cp -v $MOUNT_DIR/$BACKUP_DIR/.vimrc /home/al/
#mkdir -p /home/al/.config/autostart
cp -v $MOUNT_DIR/$BACKUP_DIR/notify_backup_errors.desktop /home/al/.config/autostart/
sudo cp -v $MOUNT_DIR/$BACKUP_DIR/usr/lib/systemd/system/disksbackup.service /usr/lib/systemd/system

sudo systemctl enable disksbackup.service 
sudo systemctl start disksbackup.service 
systemctl daemon-reload

echo 'Check fstab ssd options.'
echo 'Enable Gnome extensions in settings.'
