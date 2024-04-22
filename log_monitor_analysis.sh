#!/bin/bash

# Log file to monitor
LOG_FILE="/path/to/your/logfile.log"

# Function to display usage
usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -m <keyword>   Monitor log file for new entries containing <keyword>"
    echo "  -a <keyword>   Analyze log file for occurrences of <keyword>"
    echo "  -s             Generate summary reports"
    echo "  -h             Display this help message"
    exit 1
}

# Function to monitor log file
monitor_log() {
    clear
    echo "Monitoring log file: $LOG_FILE"
    echo "Press Ctrl+C to stop monitoring"
    echo "-----------------------------------------"
    tail -n 10 -f "$LOG_FILE"
}

# Function to analyze log file for keyword occurrences
analyze_log() {
    if [ -z "$1" ]; then
        echo "Error: Please provide a keyword to analyze (-a <keyword>)"
        exit 1
    fi

    keyword="$1"
    count=$(grep -c "$keyword" "$LOG_FILE")
    
    echo "Analysis for keyword: $keyword"
    echo "-----------------------------------------"
    echo "Occurrences in the log: $count times"
}

# Function to generate top error messages
top_error_messages() {
    echo "Top Error Messages"
    echo "-----------------------------------------"
    grep -oE "ERROR:.*" "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 5
}

# Function to generate overall statistics
overall_statistics() {
    echo "Overall Statistics"
    echo "-----------------------------------------"
    total_lines=$(wc -l < "$LOG_FILE")
    total_errors=$(grep -c "ERROR" "$LOG_FILE")
    total_warnings=$(grep -c "WARNING" "$LOG_FILE")
    total_info=$(grep -c "INFO" "$LOG_FILE")

    echo "Total Lines in Log File: $total_lines"
    echo "Total Error Messages: $total_errors"
    echo "Total Warning Messages: $total_warnings"
    echo "Total Info Messages: $total_info"
}

# Main script
while getopts "m:a:sh" opt; do
    case $opt in
        m)
            keyword_monitor="$OPTARG"
            monitor_log | grep --line-buffered "$keyword_monitor"
            ;;
        a)
            keyword_analyze="$OPTARG"
            analyze_log "$keyword_analyze"
            ;;
        s)
            top_error_messages
            echo
            overall_statistics
            ;;
        h)
            usage
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
    esac
done

# If no options provided, display usage
if [ $OPTIND -eq 1 ]; then
    usage
fi
