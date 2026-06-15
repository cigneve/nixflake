{
  den,
  cig,
  inputs,
  ...
}: {
  flake-file.inputs = {
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # imports = [inputs.treefmt-nix.flakeModule];

  den.classes.treefmt = {};

  den.policies.treefmt-to-flake-parts = _: [
    (den.lib.policy.route {
      fromClass = "treefmt";
      intoClass = "flake-parts";
      path = ["treefmt"];
      adaptArgs = {config, ...}: config.allModuleArgs;
    })
  ];

  den.schema.flake-parts.includes = [
    den.policies.treefmt-to-flake-parts
    cig.formatter-fp
  ];

  cig.formatter-fp = {
      treefmt = {
        # Used to find the project root
        # projectRootFile = "flake.nix";
        projectRootFile = ".git/config";
        enableDefaultExcludes = true;

        programs.nixfmt = {
          # projectRootFile = "flake.nix";
          enable = true;
          includes = ["**/*.nix"];
        };
        # settings.formatter.nixfmt.options = [ ];
        programs.deadnix.enable = true;
        programs.statix.enable = true;

        programs.shellcheck.enable = true;

        programs.ruff = {
          check = true;
          format = true;
        };
        settings.formatter.ruff-check.priority = 1;
        settings.formatter.ruff-format.priority = 2;

        programs.taplo.enable = true;

        programs.toml-sort.enable = true;

        programs.mdformat.enable = true;

        settings = {
          on-unmatched = "warn";
          global.excludes = [
            "**/.gitkeep"
            # ".leaderrc"
            # "*.el" # TODO contribute an emacs treefmt
            # "*/config/nvim/*"
            # "*/config/ghostty/*"
            # "*/config/wezterm/*"
            # "*/vic/dots/ssh/*"
            # "*/vic/secrets/*"
            "**/*.atrb"
            "**/*.key"
            "**/*.crt"
            "**/*.gitignore"
            "**/*.gitmodules"
            "**/LICENSE"
            "**/.direnv"
            "**/node_modules/*"
            "node_modules/*"
            "**/*.code-workspace"
            "*.code-workspace"
          ];

          # settings.formatter.just = {
          #   # command = lib'.getExeName pkgs.just;
          #   command = "just";
          #   options = [ "--fmt" ];
          #   includes = [
          #     ".?justfile"
          #     "*.just"
          #   ];
          # };
        };
    };
    };
}
