{config, inputs, ...}: {
  imports = [inputs.nix-homebrew.darwinModules.nix-homebrew];
  homebrew.enable = true;
  homebrew.casks = [
    {
      name = "chromium";
      args = {
        # require_sha = true;
        # https://github.com/nix-darwin/nix-darwin/blob/e04a388232d9a6ba56967ce5b53a8a6f713cdfcf/modules/homebrew.nix#L393
        no_quarantine = true;
      };
    }
    "hammerspoon"
    "cigneve/kde/kdeconnect"
  ];
  homebrew.brews = [
  ];
  homebrew.taps = builtins.attrNames config.nix-homebrew.taps;

  nix-homebrew = {
    # Install Homebrew under the default prefix
    enable = true;

    # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
    enableRosetta = true;

    # User owning the Homebrew prefix
    user = "ysaktan";

    # Optional: Declarative tap management
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "kde-mac/homebrew-kde" = builtins.fetchGit {
        url = "https://invent.kde.org/packaging/homebrew-kde.git";
        rev = "479d582fd1cd18b5e2125e6ec360e5d6fa0c5d8f";
      };
      "cigneve/homebrew-kde" = builtins.fetchGit {
        url = "https://github.com/cigneve/homebrew-kde.git";
        rev = "39bd81845413ab5b47037949bfba06814ee359b5";
      };

    };

    # Optional: Enable fully-declarative tap management
    #
    # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
    mutableTaps = false;

    autoMigrate = true;
  };
}
