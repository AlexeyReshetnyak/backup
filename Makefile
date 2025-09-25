reload:
	sudo systemctl restart disksbackup.service 
	sudo systemctl daemon-reload
	sudo systemctl status disksbackup.service 

install:
	sudo cp -v disksbackup.service /usr/lib/systemd/system/
	sudo systemctl enable disksbackup.service 
	sudo systemctl start disksbackup.service 
	cp -v notify_backup_errors.desktop ~/.config/autostart/
	sudo cp -v flash_backup.sh /usr/local/bin
	mkdir -p ~/bin
	cp -v notify_backup_errors.sh ~/bin
	sudo systemctl status disksbackup.service
	
uninstall:
	sudo systemctl disable disksbackup.service 
	sudo systemctl daemon-reload
	sudo rm -fv /usr/lib/systemd/system/disksbackup.service 
	rm -fv ~/.config/autostart/notify_backup_errors.desktop
	sudo rm -fv /usr/local/bin/flash_backup.sh 
	rm ~/bin/notify_backup_errors.sh 
