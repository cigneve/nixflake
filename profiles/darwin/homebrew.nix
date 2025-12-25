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
    "aerospace"
    "background-music"
    "betterdisplay"
    "blackhole-64ch"
    "buzz"
    "calibre"
    "chromium"
    "crossover"
    "darktable"
    "homebrew/core/dolphin"
    "droidcam-obs"
    "ghidra"
    "gimp"
    "inkscape"
    "cigneve/kde/kdeconnect"
    "kindle-previewer"
    "ltspice"
    "mitmproxy"
    "mullvad-vpn"
    "obs"
    "openmtp"
    "prismlauncher"
    "protonvpn"
    "qbittorrent"
    "reaper"
    "renpy"
    "sol"
    "sony-ps-remote-play"
    "steam"
    "tailscale-app"
    "temurin@21"
    "unity"
    "unity-hub"
    "utm"
    "whisky"
    "wireshark-app"
    "activitywatch"
    "super-productivity"
    
    "darktable"
    "jordanbaird-ice"
  ];
  homebrew.brews = [
    "jrnl"
    "node"
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
      # For aerospace
      "nikitabobko/homebrew-tap" = builtins.fetchGit {
        url = "https://github.com/nikitabobko/homebrew-tap";
        rev = "80dfd269edca8bc2ec5d83dbd332863cf684f753";
      };

    };

    # Optional: Enable fully-declarative tap management
    #
    # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
    mutableTaps = false;

    autoMigrate = true;
  };
}
