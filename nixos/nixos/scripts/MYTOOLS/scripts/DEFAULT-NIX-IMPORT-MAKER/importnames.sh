#!/bin/bash
# Tolga Erok
# 8/7/2023
# Import nix snippets or .nix files and create default.nix to import 

import_snippets=""

for file in *.nix; do
    if [[ -f $file ]]; then
        import_snippets+="      ./$file"$'\n'
    fi
done

cat << EOF > default.nix
{
  # Execute the following:
  imports =
    [
$import_snippets    ];

}
EOF

echo "Import snippets created in default.nix"
