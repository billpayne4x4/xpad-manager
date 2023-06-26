#!/bin/bash

if [ -f "/etc/modprobe.d/xpad.conf" ]; then
    # If the file exists, propose to load the module
    zenity --question --title="Manage XPad" --text="Module is currently unloaded. Would you like to load it?"
    if [ $? -eq 0 ]; then
        # If the user clicked "Yes", remove the blacklist file and load the module
        sudo rm /etc/modprobe.d/xpad.conf
        sudo modprobe xpad
        zenity --info --title="Manage XPad" --text="Module loaded."
    fi
else
    # If the file does not exist, propose to unload the module
    zenity --question --title="Manage XPad" --text="Module is currently loaded. Would you like to unload it?"
    if [ $? -eq 0 ]; then
        # If the user clicked "Yes", create the blacklist file and unload the module
        echo "blacklist xpad" | sudo tee /etc/modprobe.d/xpad.conf
        sudo rmmod xpad
        zenity --info --title="Manage XPad" --text="Module unloaded."
    fi
fi