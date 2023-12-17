#!/bin/bash

if grep -qi error ~/.dirs_backup.log; then
    notify-send -u critical "$(basename ~/.dirs_backup.log)" "$(cat ~/.dirs_backup.log)";
fi

if grep -qi error ~/.files_backup.log; then
    notify-send -u critical "$(basename ~/.files_backup.log)" "$(cat ~/.files_backup.log)";
fi
