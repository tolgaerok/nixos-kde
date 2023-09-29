#!/bin/bash

# Function to display the menu
display_menu() {
  local current_dir="$1"
  local menu_items=()
  local item_count=0

  # Get a list of script files and directories in the current directory
  for item in "$current_dir"/*; do
    if [[ -d "$item" ]]; then
      menu_items+=("$(basename "$item")/" "")
    elif [[ -f "$item" && -x "$item" ]]; then
      menu_items+=("$(basename "$item")" "")
    fi
    ((item_count++))
  done

  # Check if no valid menu items were found
  if [[ $item_count -eq 0 ]]; then
    dialog --clear --msgbox "No scripts found in $current_dir" 8 40
    return 1
  fi

  # Display the menu using dialog
  dialog --clear --menu "Select a script or directory:" 15 45 10 "${menu_items[@]}" "Back" "" "Exit" "" 2>&1 >/dev/tty \
    || return 1
}

# Function to execute the selected script
execute_script() {
  local script_path="$1"

  # Clear the screen
  clear

  # Execute the script
  ./"$script_path"

  # Prompt the user to press Enter to return to the menu
  read -rp "Press Enter to return to the menu..." _
}

# Main menu loop
current_directory="scripts"
menu_stack=()

while true; do
  choice=$(display_menu "$current_directory")

  # Check if the user canceled the menu or closed the dialog window
  [[ -z "$choice" ]] && {
    if [[ ${#menu_stack[@]} -gt 0 ]]; then
      current_directory=$(dirname "$current_directory")
      continue
    else
      break
    fi
  }

  # Check if the choice is "Back"
  if [[ "$choice" == "Back" ]]; then
    if [[ ${#menu_stack[@]} -gt 0 ]]; then
      current_directory=$(dirname "$current_directory")
    fi
    continue
  fi

  # Check if the choice is "Exit"
  if [[ "$choice" == "Exit" ]]; then
    clear
    break
  fi

  # Check if the choice is a directory
  if [[ "$choice" == */ ]]; then
    menu_stack+=("$current_directory")
    current_directory="${current_directory}/${choice%/}"
  else
    # Execute the selected script
    execute_script "$current_directory/$choice"
  fi
done
