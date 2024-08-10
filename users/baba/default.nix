{pkgs, ...}: let
  name = "Yusuf Said Aktan";
  email = "contact@ysaktan.com";
  username = "baba";
in {
  environment.systemPackages = with pkgs; [cachix];

  programs.gnupg.agent.pinentryPackage = pkgs.pinentry-curses;

  home-manager.users.baba = {
    imports = [
      ../profiles/git
      ../profiles/jj
      ../profiles/direnv
    ];

    home.sessionVariables = {
      TERM = "foot";
      GDK_SCALE = "2";
    };

    programs.nix-index = {
      enable = true;
      enableFishIntegration = true;
    };

    programs.rbw = {
      settings = {
        email = "chaos435@hotmail.com";
        pinentry = pkgs.pinentry-curses;
      };
      enable = true;
    };

    home.packages = with pkgs; [
      typst
      pandoc
      unrar
      clang-tools
      python3
      poetry
      pipx
      gcc
      # Go
      go
      gopls
      yt-dlp
      gallery-dl

      distrobox

      #Nix stuff
      nil
      alejandra

      rquickshare

      # Dictionary
      sdcv
    ];

    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentryPackage = pkgs.pinentry-curses;
    };

    home.stateVersion = "23.05";

    programs.git = {
      userName = name;
      userEmail = email;
      # signing = {
      #   # TODO: not me
      #   key = "F604E0EBDF3A34F2B9B472621238B9C4AD889640";
      #   signByDefault = true;
      # };
      # TODO: sendemail config
    };

    programs.ssh = {
      enable = true;
      hashKnownHosts = true;

      # matchBlocks =
      #   let
      #     githubKey = toFile "github" (readFile ../../secrets/github);

      #     # gitlabKey = toFile "gitlab" (readFile ../../secrets/gitlab);
      #   in
      #   {
      #     github = {
      #       host = "github.com";
      #       identityFile = githubKey;
      #       extraOptions = { AddKeysToAgent = "yes"; };
      #     };
      #     # gitlab = {
      #     #   host = "gitlab.com";
      #     #   identityFile = gitlabKey;
      #     #   extraOptions = { AddKeysToAgent = "yes"; };
      #     # };
      #   };
    };
    programs.zellij.enableFishIntegration = true;
  };

  # Avoid typing the username on TTY and only prompt for the password
  # https://wiki.archlinux.org/title/Getty#Prompt_only_the_password_for_a_default_user_in_virtual_console_login
  services.getty.loginOptions = "-p -- ${username}";
  services.getty.extraArgs = ["--noclear" "--skip-login"];

  users.users.baba = {
    uid = 1000;
    description = name;
    isNormalUser = true;
    # mkpasswd -m sha-512 <password>
    hashedPassword = "$y$j9T$9gXgYwkSGmkBZFHCL81gC1$FbetOSNYOC7rw546mRw6dZxlmgL.v0HDIZa/mWCbkQ0";
    openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINhYkvu/rVDYYlcM8Rq8HP3KPY2AX3mCvmyZ+/L1/yuh speed@hyrule.local"];
    # video is needed to control the backlight
    extraGroups = ["wheel" "input" "docker" "video" "audio"];
  };
}
