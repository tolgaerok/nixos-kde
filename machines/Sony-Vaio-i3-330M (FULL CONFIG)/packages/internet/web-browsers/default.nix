{ pkgs, ... }: {
  # Web Browsers:
  environment = { systemPackages = with pkgs; [ firefox google-chrome ]; };

  programs = {
    firefox = {
      enable = true;
      policies = {
        CaptivePortal = false;
        DisableFirefoxAccounts = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        FirefoxHome = {
          Pocket = false;
          Snippets = false;
        };
        UserMessaging = {
          ExtensionRecommendations = false;
          SkipOnboarding = true;
        };
      };
    };
  };

  nixpkgs.config.firefox.enablePlasmaBrowserIntegration = true;

}
