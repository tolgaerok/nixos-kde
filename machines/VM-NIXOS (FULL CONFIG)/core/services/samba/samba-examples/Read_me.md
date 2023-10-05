Outline for configuring Samba examples in the NixOS configuration.nix file:

1. Open the NixOS configuration.nix file: 
   - Use a text editor to open the configuration.nix file, usually located in the "/etc/nixos/" directory.

2. Add Samba configuration:
   - Insert the necessary Samba configuration into the file. This can include defining shared directories, access permissions, and other settings.

3. Save the changes:
   - Save the modified configuration.nix file.

4. Apply the configuration changes:
   - Run the following command to apply the changes: `sudo nixos-rebuild switch`.

5. Create a directory for Samba shares:
   - Open a terminal and execute the command: `sudo mkdir /home/NixOs-KDE`.
   - Customize the directory name and path according to your preference.

6. Set permissions for the Samba directory:
   - Run the command: `sudo chmod 770 /home/NixOs-KDE`.
   - Adjust the permissions (e.g., ownership and access) to suit your needs.

7. Create a Samba group:
   - Execute the command: `sudo groupadd samba`.
   - Modify the group name if desired.

8. Create a new user:
   - Run the command: `sudo useradd -m <USERNAME>`.
   - Replace "<USERNAME>" with the desired username for the Samba user.

9. Set the Samba password for the user:
   - Execute the command: `sudo smbpasswd -a <USERNAME>`.
   - Replace "<USERNAME>" with the username you created in the previous step.
   - Provide a password when prompted.

10. Add the user to the Samba group:
    - Run the command: `sudo usermod -aG samba <USERNAME>`.
    - Replace "<USERNAME>" with the username of the Samba user.

11. Test share locations:
    - If your shares dont work, repeat step 4

Once these steps are completed, your Samba configuration should be updated, and the user should have appropriate permissions and access to the specified directory.

   
Summary:   
1. `sudo  mkdir /home/NixOs-KDE`       ---( Change to your suitings )
2. `sudo  chmod 770 /home/NixOs-KDE`   ---( Change to your suitings )
3. `sudo groupadd samba`               ---( Change to your suitings )
4. `sudo useradd -m <USERNAME>`
5. `sudo smbpasswd -a <USERNAME>`
6. `sudo usermod -aG samba <USERNAME>`   

![samba 2](https://github.com/tolgaerok/Linux-Tweaks-And-Scripts/assets/110285959/f8001c9f-d1e1-4de8-8eb0-b29c8897375a)
   
![samba working](https://github.com/tolgaerok/Linux-Tweaks-And-Scripts/assets/110285959/a22909bd-bbcd-41a4-adba-f951963c93b3)

