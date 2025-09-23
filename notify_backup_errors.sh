#!/bin/bash

if grep -qi error ~/.dirs_backup.log; then
    notify-send -u critical "$(basename ~/.backup.log)" "$(cat ~/.backup.log)";
fi
