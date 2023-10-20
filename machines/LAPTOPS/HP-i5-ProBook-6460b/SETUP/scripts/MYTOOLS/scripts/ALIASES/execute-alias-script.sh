# Path to your main script
main_script="/etc/nixos/setup-aliases.sh"

# Check if the main script exists
if [[ -e "$main_script" ]]; then
  # Execute the main script using source
  source "$main_script"
else
  echo "Main script not found: $main_script"
fi