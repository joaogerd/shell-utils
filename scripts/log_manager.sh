#!/bin/bash
# ----------------------------------------------------------------------------#
#           Improved Generic Log Management Script                           #
# ----------------------------------------------------------------------------#
# BOP
# !SCRIPT: log_manager.sh
#
# !DESCRIPTION:
#   This script provides a generic logging mechanism for shell scripts.
#   It supports different log levels and logs messages to both the console
#   and a log file. An option is provided to enable or disable colored output.
#
# !USAGE:
#   ./log_manager.sh -l <log_level> -m <message> [-f <log_file>] [-c <on|off>]
#
# !LOG LEVELS:
#   OK      - Success message
#   ACTION  - Recommended or performed action
#   INFO    - Informational message
#   WARN    - Warning message
#   ERROR   - Error message
#   DEBUG   - Debug message (detailed internal logs)
#
# !EXAMPLES:
#   ./log_manager.sh -l INFO -m "Script started successfully."
#   ./log_manager.sh -l ERROR -m "File not found!" -f /var/log/my_script.log -c off
#
# !REVISION HISTORY:
#   07 Feb 2025 - J. G. de Mattos - Original version
#   20 Feb 2025 - J. G. de Mattos - Improved version with colored output option
# EOP
# ----------------------------------------------------------------------------#

# Default log file
LOG_FILE="./script.log"
USE_COLOR=true

# Function to display usage information
usage() {
    echo "Usage: $0 -l <log_level> -m <message> [-f <log_file>] [-c <on|off>]"
    echo "Valid log levels: OK, ACTION, INFO, WARN, ERROR, DEBUG"
    exit 1
}

# Function to check if the log file is writable (or if the directory is writable if the file doesn't exist)
check_log_file() {
    if [ -e "$LOG_FILE" ]; then
        if [ ! -w "$LOG_FILE" ]; then
            echo "[ERROR] Log file exists but is not writable: $LOG_FILE"
            exit 1
        fi
    else
        # Check if the directory is writable
        dir=$(dirname "$LOG_FILE")
        if [ ! -w "$dir" ]; then
            echo "[ERROR] Cannot create log file in directory: $dir"
            exit 1
        fi
    fi
}


# Process parameters using getopts
while getopts ":l:m:f:c:h" opt; do
    case $opt in
        l)
            LOG_LEVEL="$OPTARG"
            ;;
        m)
            MESSAGE="$OPTARG"
            ;;
        f)
            LOG_FILE="$OPTARG"
            ;;
        c)
            if [[ "$OPTARG" =~ ^(on|off)$ ]]; then
                if [ "$OPTARG" = "on" ]; then
                    USE_COLOR=true
                else
                    USE_COLOR=false
                fi
            else
                echo "[ERROR] Invalid value for -c. Use 'on' or 'off'."
                usage
            fi
            ;;
        h)
            usage
            ;;
        \?)
            echo "[ERROR] Invalid option: -$OPTARG" >&2
            usage
            ;;
        :)
            echo "[ERROR] Option -$OPTARG requires an argument." >&2
            usage
            ;;
    esac
done

# Validate required parameters
if [ -z "$LOG_LEVEL" ] || [ -z "$MESSAGE" ]; then
    usage
fi

# Function to log a message to both the console and the log file
log_message() {
    local level="$1"
    local msg="$2"
    local timestamp
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")

    # Validate log level
    case "$level" in
        INFO|WARN|ERROR|DEBUG|OK|ACTION)
            ;;
        *)
            echo "[ERROR] Invalid log level: $level"
            exit 1
            ;;
    esac

    # Construct the log message
    local log_msg="[$timestamp] [$level] $msg"

    # Print to console with optional color
    if [ "$USE_COLOR" = true ]; then
        case "$level" in
            INFO|OK)
                echo -e "\e[32m$log_msg\e[0m"  # Green
                ;;
            ACTION)
                echo -e "\e[34m$log_msg\e[0m"  # Blue
                ;;
            WARN)
                echo -e "\e[33m$log_msg\e[0m"  # Yellow
                ;;
            ERROR)
                echo -e "\e[31m$log_msg\e[0m"  # Red
                ;;
            DEBUG)
                echo -e "\e[36m$log_msg\e[0m"  # Cyan
                ;;
            *)
                echo "$log_msg"
                ;;
        esac
    else
        echo "$log_msg"
    fi

    # Log to file
    echo "$log_msg" >> "$LOG_FILE" 2>/dev/null
    if [ $? -ne 0 ]; then
        echo "[ERROR] Could not write to log file: $LOG_FILE"
        exit 1
    fi
}

# Call this function before logging
check_log_file

# Main execution: log the message using the specified log level
log_message "$LOG_LEVEL" "$MESSAGE"

