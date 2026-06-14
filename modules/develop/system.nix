{ pkgs, lib, ... }:
{
  imports = [
    ./fish/system.nix
  ];

  environment =
    let
      envVars = {
        PAGER = "less";
        LESS = "-iFJMRWX -z-4 -x4";
        HELIX_RUNTIME = "${pkgs.helix}/lib/runtime";
        EDITOR = "${pkgs.helix}/bin/hx";
        VISUAL = "${pkgs.helix}/bin/hx";
      };
    in
    {
      systemPackages = with pkgs; [
        gnumake
        file
        gnupg
        less
        wget
        rsync
        picocom
        helix
        zellij
        (lib.mkIf pkgs.stdenv.isLinux foot)
        dua
        pass
        tokei
        (lib.mkIf pkgs.stdenv.isLinux iptables)
        tcpdump
        graphviz
        imagemagick
        usbutils
        pciutils
        cargo-outdated
        zola
        asciinema
        gh
        libqalculate
        bandwhich
        jless
        xh
        xplr
        bottom
        ouch
        bzip2
        gzip
        lrzip
        p7zip
        unzip
        xz
        bat
        eza
        fd
        fzf
        procs
      ] ++ lib.optionals pkgs.stdenv.isLinux [ xdg-utils ];
    } // (
      if pkgs.stdenv.isLinux
      then { sessionVariables = envVars; }
      else { variables = envVars; }
    );

  documentation.man.enable = true;
}
