#!/bin/bash

SERVICE_NAME="nginx"

check_status() {
    SERVICE_PID="$(pgrep -f "$SERVICE_NAME")"
    if [ ! -z "$SERVICE_PID" ]
       then
           echo "Service '$SERVICE_NAME' is already running with PID '$SERVICE_PID'."
           echo "Stopping '$SERVICE_NAME'..."
           # Stop all PIDs associated with the service
           for PID in $SERVICE_PID;do
           kill -9 "$PID"
           done
                if [ "$?" -eq 0 ]
                    then
                        echo "Service '$SERVICE_NAME' stopped Successfully."
                fi
           sleep 10
           echo "Starting '$SERVICE_NAME'..." 
           systemctl start "$SERVICE_NAME"
           sleep 10
           SERVICE_PID="$(pgrep -f "$SERVICE_NAME")"
                if [ -z "$SERVICE_PID" ]
                    then
                        echo "Service '$SERVICE_NAME' is not started Successfully."
                        exit 1
                    else
                        echo "Service '$SERVICE_NAME' started with PID '$SERVICE_PID'."
                        exit 0
                fi
    else
        echo "Starting '$SERVICE_NAME'..." 
        systemctl start "$SERVICE_NAME"
        SERVICE_PID="$(pgrep -f "$SERVICE_NAME")"
        sleep 10
                if [ -z "$SERVICE_PID" ]
                    then
                        echo "Service '$SERVICE_NAME' is not started Successfully."
                        exit 1
                    else
                        echo "Service '$SERVICE_NAME' started with PID '$SERVICE_PID'."
                        exit 0
                fi
    fi
}
check_status