#!/bin/bash

red="\e[31m"
none="\e[0m"

bold=$(tput bold)
normal=$(tput sgr0)

ls ~/

sleep 0.5

echo ""
read -p "${bold}Enter the folder where the iso is located (The folder must be in $HOME)${normal}: " fullname
echo -e "${bold}Folder: ${red}/home/$USER/${fullname}${none}${normal}"

files=(~/${fullname}/*.iso)

# Prompt the user to select a file
echo "Select a file:"
select file in "${files[@]}"; do
    # Check if a valid option was selected
    if [[ -n $file ]]; then
        echo "You selected: $file"
        break
    else
        echo "Invalid option. Try again."
    fi
done

echo ""

sleep 0.5

lsblk

function usb() {
    echo ""
    read -p "Enter your USB drive name: " usbdrive
    echo ""
    read -e -p "Your flash drive: /dev/${usbdrive} (y or n) " choice
}

usb

while [ "$choice" != "y" ]; do
    if [ "$choice" = "n" ]; then
        echo "you select no"
        sleep 1
        usb
    fi
done

echo "Wait..."

sudo dd if=${file} of=/dev/${usbdrive} bs=4M status=progress && sync
