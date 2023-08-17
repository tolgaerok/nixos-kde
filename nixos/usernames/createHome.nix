# configuration.nix

{
  # Other NixOS options and configurations...

  users.userAccounts.defaultHome = {
    createHome = true;
    extraGroups = [
      # Add any extra groups here if needed.
    ];
    home = "/home";
    skeleton = {
      Pictures = {};
      Videos = {};
      Music = {};
      Documents = {};
      # Add more directories as needed.
    };
  };

  # Other NixOS options and configurations...
}
