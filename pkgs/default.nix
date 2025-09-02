inputs: final: prev: {
  # https://github.com/colemickens/nixpkgs-wayland/issues/233
  modprobed-db = prev.callPackage ./misc/modprobed-db.nix {};
  proggy = prev.callPackage ./development/proggy.nix {};
  # https://github.com/LnL7/nix-darwin/issues/1041
  inherit (inputs.nixpkgs-stable.legacyPackages.${prev.system}) karabiner-elements;
  # curie = prev.callPackage ./development/curie.nix {};
}
