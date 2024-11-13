# Miscallenous functions
function jmproot
    z $(git rev-parse --show-toplevel)
end

function nixswitch
    sudo nixos-rebuild switch --flake ~/pj/nixflake/#babadir
end

function nixtest
    sudo nixos-rebuild test --flake ~/pj/nixflake/#babadir
end
