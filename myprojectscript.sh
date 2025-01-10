#!/bin/bash

SERVICE_NAME="cache-service-prod-sg"
SERVICE_PATH="/export/gcs1/data/Spart/cache-service-prod-sg/distro-current/scripts/"

check_status() {
    SERVICE_PID="$(pgrep -f "$SERVICE_NAME")"
    if [ ! -z "$SERVICE_PID" ]
       then
           echo "Service '$SERVICE_NAME' is already running with PID '$SERVICE_PID'."
           echo "Stopping '$SERVICE_NAME'..."
           kill -9 "$SERVICE_PID"
                if [ "$?" -eq 0 ]
                    then
                        echo "Service '$SERVICE_NAME' stopped Successfully."
                fi
           sleep 5
           echo "Starting '$SERVICE_NAME'..." 
           $SERVICE_PATH/service $SERVICE_NAME start
           sleep 5
                if [ ! -z "$SERVICE_PID" ]
                    then
                        echo "Service '$SERVICE_NAME' started with PID '$SERVICE_PID'."
                        exit 0
                    else
                        echo "Service '$SERVICE_NAME' is not started Successfully."
                        exit 1
                fi
    else
        echo "Starting '$SERVICE_NAME'..." 
        $SERVICE_PATH/service $SERVICE_NAME start
        sleep 5
                if [ ! -z "$SERVICE_PID" ]
                    then
                    echo "Service '$SERVICE_NAME' started with PID '$SERVICE_PID'."
                    exit 0
                else
                    echo "Service '$SERVICE_NAME' is not started Successfully."
                    exit 1
                fi
    fi
}
check_status