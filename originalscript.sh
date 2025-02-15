#!/bin/bash

# Define variables

SERVICE_NAME="nginx"
PID_FILE="/var/run/$SERVICE_NAME.pid"
LOG_FILE="/var/log/$SERVICE_NAME.log"

check_status() {
    if [ -f "$PID_FILE" ]
       then
           echo "Service '$SERVICE_NAME' is already running with PID $(cat $PID_FILE)."
           echo "Stopping '$SERVICE_NAME'..."
           kill "$(cat $PID_.FILE)"
           rm -f "$PID_FILE"
           echo "Service '$SERVICE_NAME' stopped successfully."
           sleep 5
           echo "Starting '$SERVICE_NAME'..." 
           systemctl start "$SERVICE_NAME" > "$LOG_FILE" 2>&1 &
           sleep 5
           #echo "Service '$SERVICE_NAME' started with PID '$(cat $PID_FILE)'."
                if [ -f "$PID_FILE" ]
                    then
                        echo "Service '$SERVICE_NAME' started with PID $(cat $PID_FILE)."
                        exit 0
                    else
                        echo "Service '$SERVICE_NAME' is not started Successfully."
                        exit 1
                fi
    else
        echo "Starting '$SERVICE_NAME'..." 
        systemctl start "$SERVICE_NAME" > "$LOG_FILE" 2>&1 &
        sleep 5
                if [ -f "$PID_FILE" ]
                    then
                    echo "Service '$SERVICE_NAME' started with PID $(cat $PID_FILE)."
                    exit 0
                else
                    echo "Service '$SERVICE_NAME' is not started Successfully."
                    exit 1
                fi
    fi
}
check_status