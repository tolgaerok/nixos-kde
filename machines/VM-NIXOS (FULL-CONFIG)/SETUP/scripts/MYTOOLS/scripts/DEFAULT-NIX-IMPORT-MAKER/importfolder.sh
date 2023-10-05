#!/bin/bash
# Tolga Erok
# 8/7/2023
# Import folder-names and create default.nix to import 

import_snippets=""

for folder in */; do
    if [[ -d $folder ]]; then
        import_snippets+="      ./"${folder%/}$'\n'
    fi
done

cat << EOF > default.nix
{
    
  # Import default.nix from folders below
  imports =
    [
$import_snippets    ];  
  
}
EOF

echo "Import snippets created in snippets.nix"
