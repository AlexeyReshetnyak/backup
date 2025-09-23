#!/bin/bash

if grep -qi error ~/.dirs_backup.log; then
    notify-send -u critical "$(basename ~/.dirs_backup.log)" "$(cat ~/.dirs_backup.log)";
fi
