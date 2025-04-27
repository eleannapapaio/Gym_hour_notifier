#!/bin/bash

# Gym hours in English (using your exact schedule)
declare -A HOURS=(
    ["Δευτέρα"]="00:30"
    ["Τρίτη"]="00:30"
    ["Τετάρτη"]="00:30"
    ["Πέμπτη"]="00:30"
    ["Παρασκευή"]="00:30"
    ["Σάββατο"]="22:00"
    ["Κυριακή"]="20:00"
)

# Get English day name (uppercase)
TODAY=$(date +"%^A")
CLOSING_TIME=${HOURS[$TODAY]}

# Calculate remaining time
current_epoch=$(date +%s)
closing_epoch=$(date -d "$CLOSING_TIME" +%s 2>/dev/null)

if [[ -n "$closing_epoch" ]]; then
    if (( closing_epoch > current_epoch )); then
        time_diff=$((closing_epoch - current_epoch))
        hours=$((time_diff / 3600))
        minutes=$(( (time_diff % 3600) / 60 ))
        
        if (( hours > 0 )); then
            REMAINING_TIME="$hours hours and $minutes minutes"
        else
            REMAINING_TIME="$minutes minutes"
        fi
    else
        REMAINING_TIME="already closed"
    fi
else
    REMAINING_TIME="unknown"
fi

# Display results
echo "Today is $TODAY. Gym closes at $CLOSING_TIME. Time left: $REMAINING_TIME"
notify-send "Gym Hours" "Today is $TODAY\nCloses at $CLOSING_TIME\nTime left: $REMAINING_TIME"

