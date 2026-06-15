{
  flake-file = {
    nixConfig = {
      allow-import-from-derivation = true;
      # Flake-specific substituters and trusted-public-keys, not affecting the system configuration.
      extra-substituters = [
        # Nix community cache server.
        "https://nix-community.cachix.org"
        # Flox cache server.
        "https://cache.flox.dev"
        # Numtide cache server.
        "https://numtide.cachix.org"
        "https://cache.numtide.com"
      ];
      extra-trusted-public-keys = [
        # Nix community cache server public key.
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        # Flox cache server public key.
        "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
        # Numtide cache server public key.
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE"
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      ];
      submodules = true;
      lazy-trees = true;
      accept-flake-config = true;
      auto-optimise-store = true;
      use-xdg-base-directories = true;
      show-trace = true;
    };
  };
}
