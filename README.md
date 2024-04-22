# Log Analysis and Monitoring Script
## Overview
This Bash script provides functionalities to monitor a specified log file for new entries in real-time, analyze occurrences of specific keywords, and generate summary reports. It is designed to assist in log file analysis and monitoring tasks.
## Features
- Monitor a log file for new entries containing a specified keyword.
- Analyze the log file for occurrences of a keyword.
- Generate summary reports:
   Top error messages,
   Overall statistics.
# Usage
- To make this script executable use the command `chmod +x log_monitor_analysis.sh `

- To monitor log file without a keyword ` ./log_monitor_analysis.sh -m "" `

- To monitor log file with a keyword ` ./log_monitor_analysis.sh -m "keyword" `  eg : ` ./log_analysis.sh -m "ERROR" `
  
- To analyze the log file for a keyword ` ./log_monitor_analysis.sh -a "keyword" ` eg: `./log_monitor_analysis.sh -a "ERROR"`

- To generate summary reports ` ./log_monitor_analysis.sh -s `
