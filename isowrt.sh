#!/bin/bash

red="\e[31m"
none="\e[0m"

bold=$(tput bold)
normal=$(tput sgr0)

shopt -s globstar extglob
PS3='File number: '

files=($(for i in ~/**/*.iso ; do echo "$i"; done | awk '{ print "\""$0"\""}'))
IFS= mapfile -t files < <(find ~/ -type f -name "*.iso" -o -type d -name ".*.iso" | sort)

echo ""
echo "Select a file:"
select file in "${files[@]}"; do
    if [[ -n $file ]]; then
        echo "You selected: $file"
        break
    else
        echo "Invalid option. Try again."
    fi
done

echo ""

sleep 0.5

lsblk -d | awk '/ 8:/'

function usb() {
    echo ""
    read -p "Enter your USB drive name: " usbdrive
    echo ""
    read -e -p "Your flash drive: /dev/${usbdrive}/ (y or n) " choice
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

sudo dd if="${file}" of="/dev/${usbdrive}" bs=4M status=progress && sync
