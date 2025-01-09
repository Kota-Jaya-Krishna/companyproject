#!/bin/bash

# Define variables
SERVICE_NAME="nginx"
echo "Success-1"
PID_FILE="/var/run/$SERVICE_NAME.pid"
echo "Success-2"
LOG_FILE="/var/log/$SERVICE_NAME.log"
echo "Success-3"

check_status() {
    if [ -f "$PID_FILE" ]
       then
           echo "Service '$SERVICE_NAME' is already running with PID $(cat $PID_FILE)."
           echo "Stopping '$SERVICE_NAME'..."
           kill "$(cat $PID_FILE)"
           rm -f "$PID_FILE"
           echo "Service '$SERVICE_NAME' stopped successfully."
           sleep 5
           echo "Starting '$SERVICE_NAME'..." 
           systemctl start nginx > "$LOG_FILE" 2>&1 &
           echo "Service '$SERVICE_NAME' started with PID $(cat $PID_FILE)."
                #if [ -f "$PID_FILE" ]
                 #   then
                  #  echo "Service '$SERVICE_NAME' started with PID $(cat $PID_FILE)."
                   # exit 0
                #fi
    else
        echo "Starting '$SERVICE_NAME'..." 
        nohup systemctl start nginx > "$LOG_FILE" 2>&1 &
                if [ -f "$PID_FILE" ]
                    then
                    echo "Service '$SERVICE_NAME' started with PID $(cat $PID_FILE)."
                    exit 0
                fi
    fi
}
check_status