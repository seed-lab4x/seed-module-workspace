#!/bin/bash

set -e

if [[ -z "$( command -v wslpath )" ]] || [[ -z "$( command -v wslvar )" ]];
then
    echo "Install wslu"

    sudo apt install -y apt-transport-https wget
    wget -O - https://pkg.wslutiliti.es/public.key | sudo tee -a /etc/apt/trusted.gpg.d/wslu.asc

    os_name="$( env -i bash -c '. /etc/os-release ; echo $NAME' )"
    if [[ "$os_name" == *"Debian"* ]];
    then
        echo "Debian detected. add pkg.wslutiliti.es apt source"
        os_version_codename="$( env -i bash -c '. /etc/os-release ; echo $VERSION_CODENAME' )"
        echo "deb https://pkg.wslutiliti.es/debian $os_version_codename main" | sudo tee -a /etc/apt/sources.list
        sudo apt update
    fi

    sudo apt install -y wslu
fi

mount_with_metadata="$( mount | grep '/mnt/c' | cat | grep 'metadata' | cat )"
if [[ -n "$mount_with_metadata" ]];
then
    echo "Mounted C drive already with metadata option. umount it to use 'wslvar'."

    re="\((.*)\)"
    if [[ $mount_with_metadata =~ $re ]];
    then
        mount_option=${BASH_REMATCH[1]}
        sudo umount /mnt/c
    else
        echo "Unable to parse '/mnt/c' mount options by /$re/."
        return 1
    fi
else
    mount_option="metadata"
fi

echo "Mount C drive without metadata option."
sudo mount -t drvfs 'C:\' /mnt/c

userprofile="$( wslvar USERPROFILE )"
user_path="$( wslpath $userprofile )"
user_name="$( whoami )"

echo "Remount C drive with metadata option."
sudo umount /mnt/c
sudo mount -t drvfs 'C:\' /mnt/c -o "$mount_option"


if [[ -d $HOME/.ssh ]];
then
    real_path="$( cd -P "$HOME/.ssh" && pwd )"

    if [[ "$real_path" == "$user_path/.ssh" ]];
    then
        echo "already link $HOME/.ssh to $real_path"
        linked="true"
    else
        backup_path="$HOME/.ssh.bak.$( date +%s )"
        echo "Backup $HOME/.ssh to $backup_path"
        mv "$HOME/.ssh" "$backup_path"
    fi
fi
if [[ -z "$linked" ]];
then
    echo "make link $HOME/.ssh to $user_path/.ssh"
    sudo ln -s $user_path/.ssh $HOME/.ssh
fi

sudo chown -R $user_name:$user_name $user_path/.ssh
sudo chmod -R 700 $user_path/.ssh/
ls -la $HOME/.ssh/
