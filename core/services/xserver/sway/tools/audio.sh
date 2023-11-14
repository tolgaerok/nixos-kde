# Get current audio outputs and running status
output=$(pw-dump | jq -r '.[] | select(.info.props."media.class" == "Audio/Sink") | .id, .info.props."node.description", .info.state')

array=()
switch_next=0

# Dump them to an array
while IFS= read -r line; do
  array+=("$line")
done <<< "$output"

# Loop through array, determine what's running and queue next iteration to be set to new default output
for ((i = 0; i < ${#array[@]}; i=i+3)); do
  if [ "$switch_next" == 1 ]; then
    wpctl set-default ${array[i]}
    switch_next=0
  fi

  if [ "${array[i+2]}" == "running" ]; then
    switch_next=1
  fi
done

#  If the current running was the last item, make the first element active
if [ "$switch_next" == 1 ]; then
  wpctl set-default ${array[0]}
  switch_next=0
fi

# Grab the NEW audio outputs status and display which one is active
output=$(pw-dump | jq -r '.[] | select(.info.props."media.class" == "Audio/Sink") | .id, .info.props."node.description", .info.state')

array=()

while IFS= read -r line; do
  array+=("$line")
done <<< "$output"


for ((i = 0; i < ${#array[@]}; i=i+3)); do
  if [ "${array[i+2]}" == "running" ]; then
    notify-send -h string:x-canonical-private-synchronous:my-notification --expire-time=1000 "${array[i+1]}"
    echo "*${array[i]} - ${array[i+1]} - ${array[i+2]}"
  else
    echo " ${array[i]} - ${array[i+1]} - ${array[i+2]}"
  fi
done