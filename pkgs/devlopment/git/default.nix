{pkgs, ...}: {

  # Github related

  environment = {
    systemPackages = with pkgs; [ 

      #Git related
      gh
      git-extras
      git-my
      gitFull  # git git-jump git-upload-pack git-credential-libsecret git-receive-pack git-upload-archive git-cvsserver scalar git-shell gitk git-http-backend git-credential-netrc
      gitg
      gitlab
      gitless
      gitlint
      glab
      hut

    ];
  };
}