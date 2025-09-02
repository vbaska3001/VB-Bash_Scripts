#!/bin/bash


# Declaring while condition to loop the script

while true;
do

# Creating Timestamp variable to capture the Time for logging

	timestamp=$(date "+%Y-%m-%d %H-%M-%S")
	
# Creating log files to store the output of the Ping with Timestamp

	output_log="Ping_Logs $timestamp.log"
	error_log="Ping_Errors $timestamp.log"
	
# Ping commands to ping various targets and store the outputs in output log file

	ping -c 5 -I en0 8.8.8.8 >> "$output_log" 2>&1
	ping -c 5 -I eth0 www.youtube.com >> "$output_log" 2>&1
	ping -c 5 -I wlan0 www.netflix.com >> "$output_log" 2>&1

# Creating an if condition to check if there are errors and move them to Error Log file
# Grep command with -qEi to consider multiple case-insensitive words from the output log
# Last part of the if condition moves the errors to the error log file

	if grep -qEi "Request timeout|100% packet loss|Temporary Failure|ping: invalid multicast interface:" "$output_log";
	then
		echo "Error Seen at $timestamp" >> "$error_log"
	grep -Ei "Request timeout|100% packet loss|Temporary Failure|ping: invalid multicast interface:" "$output_log" >> "$error_log"
	fi

# Setting sleep to 3600 to run the script every 1 hour!

	sleep 3600
done


# The above ping script pings the mentioned target sites based on the specified interface 5 times every 1 hour.
# The ping output is stored in the log file named Ping_Logs with timestamp and errors are moved to Ping_Errors log file with timestamp every 1 hour.
# The script can be modified based on the ping count, target, interface and file names as per the use case of implementation.


# This script is written for a specific use case (as explained in the comments). You can change it as needed for your system.
# Make sure to test it before using it in a real (production) environment.



 

