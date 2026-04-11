#!/usr/bin/env zsh

read live_seconds _ < /proc/uptime
total=${live_seconds%.*}
past_durations=( ${(f)"$(last -x reboot shutdown -s today | grep -oP '\(\K[0-9:]+(?=\))')"} )

for d in $past_durations; do
  [[ $d != *:* ]] && continue
  parts=(${(s/:/)d})
  (( total += parts[1] * 3600 + parts[2] * 60 ))
done

(( h = total / 3600 ))
(( m = (total % 3600) / 60 ))
printf "%02d:%02d\n" $h $m
