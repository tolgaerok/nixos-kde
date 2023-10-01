{pkgs, ...}: {

  # Github related

  environment = {
    systemPackages = with pkgs; [ 

      # git-extras
      # git-my
      # gitg
      # gitless 
      # gitlint
      # glab
      #Git related
      #gh
      gitFull  # git git-jump git-upload-pack git-credential-libsecret git-receive-pack git-upload-archive git-cvsserver scalar git-shell gitk git-http-backend git-credential-netrc
      gitlab
      hut

    ];
  };
}