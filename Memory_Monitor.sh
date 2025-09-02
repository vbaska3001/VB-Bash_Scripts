

#!/bin/bash


# Creating log file to store the logs, getting timestamp for memory spikes, and setting threshold value to 75

log_file=Memory_monitor.log
timestamp=$(date "+%Y-%m-%d_%H-%M-%S")
threshold=75

# Using the top and read commands to get the PID, Memory, User and Process name running in the system.
# Filtering the result to find the process consuming higher memory using the sort, head and awk commands.

read pid user mem cmd <<< $(top -b -n1 | awk 'NR>7 {print $1, $2, $10, $12}' | sort -k3 -nr | head -n1)

# top -b -n1 : to get the top processes
# awk 'NR>7 {print $1, $2, $10, $12}' : to filter the mentioned columns after column 7 (N7)
# sort -k3 -nr : to sort the result of 3rd column in reverse order numerically(100-0)
# head -n1 : to get the 1st result after sorting

echo "$timestamp | PID:$pid | USER:$user | MEM:$mem | CMD:$cmd" >> "$log_file"

# To print the output of the PID, USER, MEMORY CONSUMED and PROCESS NAME - CMD in the log file


# To send an alert message with CMD name and MEM percentage consumed

if (( $(echo "$mem > $threshold" | bc -l)));
then
	echo "!!! HIGH MEMORY USAGE FOUND !!!"
	echo "$cmd PROCESS IS CONSUMING $mem% MEMORY"
fi


# The above script can be run in Linux-Based machines to monitor the processes running and send an alert message with the details of the process consuming higher memory than a specified threshold value.
# The output is stored with a timestamp in the Memory_monitor.log file. The file name can be changed based on user requirements.


# This script is written for a specific use case (as explained in the comments). You can change it as needed for your system.
# Make sure to test it before using it in a real (production) environment.




