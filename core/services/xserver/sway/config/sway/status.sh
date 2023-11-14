date_formatted=$(date "+%m/%d/%Y - %l:%M %p - ")

battery_status=$(cat /sys/class/power_supply/BAT0/capacity)

echo $battery_status% - $date_formatted 
