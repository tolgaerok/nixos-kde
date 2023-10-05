{ lib, pkgs, ... }:

let
  email = "kingtolga@gmail.com";
  fullname = "Tolga Erok";

in {
  programs = {
    git = {
      enable = true;

      lfs = {
        # Git Large File Storage (LFS)
        enable = true;
      };

      config = {
        commit = {
          # Remove the gpgsign line or set it to "false" to disable GPG signing...
          # gpgsign = "false";

          # Add this line to enable signing commits with your SSH key
          # You may also need to configure Git to use your SSH key globally
          # (outside of this NixOS configuration).
          # See the note below for instructions.
          signingKey = "ssh-ed25519";
        };

        #init = { defaultBranch = "main"; };
        #pull = { rebase = "true"; };
        core.editor = "kate";
        github.user = "tolgaerok";
        init.defaultBranch = "main";
        pull.rebase = true;

        # ignores = [ ".envrc" ".direnv" ];
        
        url = {
          "git@github.com:" = { insteadOf = [ "https://github.com/" ]; };
          "git@gitlab.com:" = { insteadOf = [ "https://gitlab.com/" ]; };
        };

        user = {
          email = "${email}";
          name = "${fullname}";
        };

        status = { short = true; };
      };
    };
  };

  # Do in terminal::
  # cat ~/.ssh/id_ed25519.pub
  # git config --global user.signingkey your_ssh_key_id_here

}
