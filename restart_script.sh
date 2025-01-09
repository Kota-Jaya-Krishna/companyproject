#!/bin/bash

# Define variables
SERVICE_NAME="your_service_name"
PID_FILE="/var/run/$SERVICE_NAME.pid"
LOG_FILE="/var/log/$SERVICE_NAME.log"

# Function to start the service
start_service() {
    if [ -f "$PID_FILE" ]; then
        echo "Service '$SERVICE_NAME' is already running with PID $(cat $PID_FILE)."
        exit 0
    fi

    echo "Starting '$SERVICE_NAME'..."
    # Replace the following line with the actual command to start your service
    nohup your_service_command > "$LOG_FILE" 2>&1 &
    echo $! > "$PID_FILE"
    echo "Service '$SERVICE_NAME' started with PID $(cat $PID_FILE)."
}

# Function to stop the service
stop_service() {
    if [ ! -f "$PID_FILE" ]; then
        echo "Service '$SERVICE_NAME' is not running."
        exit 0
    fi

    echo "Stopping '$SERVICE_NAME'..."
    kill "$(cat $PID_FILE)"
    rm -f "$PID_FILE"
    echo "Service '$SERVICE_NAME' stopped."
}

# Function to check the status of the service
status_service() {
    if [ -f "$PID_FILE" ]; then
        echo "Service '$SERVICE_NAME' is running with PID $(cat $PID_FILE)."
    else
        echo "Service '$SERVICE_NAME' is not running."
    fi
}

# Main script logic
case "$1" in
    start)
        start_service
        ;;
    stop)
        stop_service
        ;;
    status)
        status_service
        ;;
    restart)
        stop_service
        start_service
        ;;
    *)
        echo "Usage: $0 {start|stop|status|restart}"
        exit 1
        ;;
esac
