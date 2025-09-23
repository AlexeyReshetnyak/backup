reload:
	sudo systemctl restart disksbackup.service 
	sudo systemctl daemon-reload
	sudo systemctl status disksbackup.service 

install:
	sudo systemctl stop disksbackup.service 
	sudo systemctl disable disksbackup.service 
	sudo cp -v disksbackup.service /usr/lib/systemd/system/
	sudo systemctl enable disksbackup.service 
	sudo systemctl start disksbackup.service 
	sudo systemctl status disksbackup.service
	cp -v notify_backup_errors.desktop ~/.config/autostart/
