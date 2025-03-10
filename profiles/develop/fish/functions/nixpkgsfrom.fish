function nixpkgsfrom -d "Set nixpkgs input from flake"
    set defaultpath ~/pj/nixflake

    set flakepath $argv[1]
    test -z "$flakepath" || test ! (-e "$flakepath") && test -e "$defaultpath" && set flakepath "$defaultpath"
    test -z "$flakepath" && return 1
    nix flake update --override-input nixpkgs github:nixos/nixpkgs/$(nix flake metadata --json "$flakepath" | jq -r '.locks.nodes.nixpkgs.locked.rev')
end
