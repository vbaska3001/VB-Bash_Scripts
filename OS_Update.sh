#!/bin/bash


# Checking the OS from the path and assigning it to a variable. Storing upgrade and error logs in separate file.

os_path=/etc/os-release
log_file=~/logs/upgrade_logs.log
error_file=~/logs/error_logs.log

# Creating a function to check the exit status and redirect the errors to error log file

check_exit_status() {
	if [ $? -ne 0 ]
	then
		echo "An error occurred during the upgrade process. Check the $error_file!"
	fi
}

# Creating if conditions to check the OS Version and upgrading the system based on the Distro present in the system.

if grep -qw "Ubuntu" $os_path || grep -w "Debian" $os_path
then
	echo "OS is based on Ubuntu/Debian. Upgrading using the apt command."
	sudo apt update && sudo apt upgrade 1>>$log_file 2>>$error_file
	check_exit_status
fi

if grep -w "Arch" $os_path
then
	echo "OS is based on Arch Distro. Upgrading using the pacman command."
	sudo pacman -Syu 1>>$log_file 2>>$error_file
	check_exit_status
fi

if grep -w "CentOS" $os_path || grep -w "Fedora" $os_path
then
        echo "OS is based on Cent Distro. Upgrading using the dnf command."
        sudo dnf upgrade --refresh -y 1>>$log_file 2>>$error_file
        check_exit_status
fi


# The above script can be used to update and upgrade the OS of Linux systems based on their Distro and provide the upgrade and error logs upon process completion.
# The script can be run at specified timings by executing it in cron jobs.
# The script can be modified based on the distros required, other packages to install, and log file name changes as per user requirement.

# This script is written for a specific use case (as explained in the comments). You can change it as needed for your system. 
# Make sure to test it before using it in a real (production) environment.


