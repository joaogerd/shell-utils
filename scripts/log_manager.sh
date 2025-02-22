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
#   OK       - Success message
#   ACTION   - Recommended or performed action
#   INFO     - Informational message
#   WARNING  - Warning message
#   ERROR    - Error message
#   DEBUG    - Debug message (detailed internal logs)
#   NOTICE   - Important but non-critical information
#   NEUTRAL  - Neutral message
#   DETAIL   - Additional details or technical logs
#
# !EXAMPLES:
#   ./log_manager.sh -l INFO -m "Script started successfully."
#   ./log_manager.sh -l ERROR -m "File not found!" -f /var/log/my_script.log -c off
#
# !REVISION HISTORY:
#   07 Feb 2025 - J. G. de Mattos - Original version
#   20 Feb 2025 - J. G. de Mattos - Improved version with colored output option
#   21 Feb 2025 - J. G. de Mattos - Added new log levels and improved color formatting
# EOP
# ----------------------------------------------------------------------------#

# Default log file
LOG_FILE="./script.log"
USE_COLOR=true

# ANSI Colors
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
MAGENTA="\e[35m"
WHITE="\e[37m"
GRAY="\e[90m"
RESET="\e[0m"

# Function to display usage information
usage() {
    echo "Usage: $0 -l <log_level> -m <message> [-f <log_file>] [-c <on|off>]"
    echo "Valid log levels: OK, ACTION, INFO, WARNING, ERROR, DEBUG, NOTICE, NEUTRAL, DETAIL"
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
                USE_COLOR=$([ "$OPTARG" = "on" ] && echo true || echo false)
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

# Function to log a message with correct color formatting
log_message() {
    local level="$1"
    local msg="$2"
    local timestamp
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")

    # Validate log level
    case "$level" in
        OK|ACTION|INFO|WARNING|ERROR|DEBUG|NOTICE|NEUTRAL|DETAIL)
            ;;
        *)
            log_message ERROR "Invalid log level: $level"
            exit 1
            ;;
    esac

    # Assign correct color based on log level (Only the word inside [])
    case "$level" in
        OK)        color="${GREEN}OK${RESET}" ;;
        ACTION)    color="${BLUE}ACTION${RESET}" ;;
        INFO)      color="${BLUE}INFO${RESET}" ;;
        WARNING)   color="${YELLOW}WARNING${RESET}" ;;
        ERROR)     color="${RED}ERROR${RESET}" ;;
        DEBUG)     color="${CYAN}DEBUG${RESET}" ;;
        NOTICE)    color="${MAGENTA}NOTICE${RESET}" ;;
        NEUTRAL)   color="${WHITE}NEUTRAL${RESET}" ;;
        DETAIL)    color="${GRAY}DETAIL${RESET}" ;;
    esac

    # Construct the formatted log message
    local log_msg="[$timestamp] [${color}] $msg"

    # Print to console with optional color
    if [ "$USE_COLOR" = true ]; then
        echo -e "$log_msg"
    else
        echo "[$timestamp] [$level] $msg"
    fi

    # Log to file
    echo "[$timestamp] [$level] $msg" >> "$LOG_FILE" 2>/dev/null
    if [ $? -ne 0 ]; then
        echo "[ERROR] Could not write to log file: $LOG_FILE"
        exit 1
    fi
}

# Call this function before logging
check_log_file

# Main execution: log the message using the specified log level
log_message "$LOG_LEVEL" "$MESSAGE"

