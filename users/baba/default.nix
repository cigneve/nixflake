{pkgs,lib, config,...}: let
  name = "Yusuf Said Aktan";
  email = "contact@aktan.org";
  username = "baba";
in {
  config = {
    environment.systemPackages = with pkgs; [cachix];

    # programs.gnupg.agent.pinentryPackage = pkgs.pinentry-curses;

    home-manager.users.baba = {
      imports = [
        ../profiles/git
        ../profiles/jj
        ../profiles/direnv
      ];

      home.sessionVariables = {
        TERM = "foot";
        # GDK_SCALE = "2";
      };

      programs.aerc = {
        enable = true;
        extraConfig.general.unsafe-accounts-conf = true;
      };
      programs.mbsync.enable = true;
      programs.notmuch = {
        enable = true;
        hooks = {
          preNew = "mbsync --all";
        };
      };
      accounts.email = {
        accounts = {
          bilkent= rec {
            userName = address;
            primary = true;
            address = "said.aktan@ug.bilkent.edu.tr";
            imap = {
              host = "mail.bilkent.edu.tr";
              port = 993;
            };
            mbsync = {
              enable = true;
              create = "maildir";
            };
            notmuch.enable = true;
            smtp = {
              host = "asmtp.bilkent.edu.tr";
            };
            realName = name;
            aerc.enable = true;
            passwordCommand = "echo 2QNGs7mi";
            signature = {
              delimiter = ''
              --
              '';
              showSignature = "append";
              text = ''
                Yusuf Said Aktan
                Bilkent CS Undergrad student
                No:22402715
                Personal:contact@ysaktan.com
              '';
            };
          };
        };
      };
      programs.nix-index = {
        # enable = true;
        # enableFishIntegration = true;
      };

      programs.rbw = {
        settings = {
          email = "chaos435@hotmail.com";
          pinentry = if pkgs.stdenv.isLinux then pkgs.pinentry-qt else pkgs.pinentry_mac;
        };
        enable = true;
      };

      home.packages = with pkgs; [
        pinentry_mac
        # Notetaking and document
        typst
        typstfmt
        tinymist
        pandoc
        ## PDF utils
        poppler_utils


        tealdeer
        navi
        clang-tools
        (python3.withPackages (ps: with ps; [regex]))
        poetry
        pipx
        gcc
        # Go
        go
        gopls
        gotools
        yt-dlp
        gallery-dl


        #Nix stuff
        nil
        alejandra

        rquickshare

        # Dictionary
        sdcv
        hunspell
        hunspellDicts.tr_TR
        hunspellDicts.en_US

        beancount
      ] ++ 
      # Bilkent stuff
      [
        # Java
        jdt-language-server
        openjdk
        gradle
      ]
      # Linux only
      ++ lib.optionals pkgs.stdenv.isLinux [
        # Broken on darwin
        calibre
        unrar
        distrobox
      ];

      # services.gpg-agent = {
      #   enable = true;
      #   enableSshSupport = true;
      #   pinentryPackage = pkgs.pinentry-curses;
      # };

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
      # programs.zellij.enableFishIntegration = lib.mkForce true;

      programs.watson = {
        enable = true;
      };
      # TODO: Add VSCode
    };


    users.users.baba = if pkgs.stdenv.isLinux then{
      uid = 1000;
      description = name;
      isNormalUser = true;
      # mkpasswd -m sha-512 <password>
      hashedPassword = "$y$j9T$9gXgYwkSGmkBZFHCL81gC1$FbetOSNYOC7rw546mRw6dZxlmgL.v0HDIZa/mWCbkQ0";
      openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINhYkvu/rVDYYlcM8Rq8HP3KPY2AX3mCvmyZ+/L1/yuh speed@hyrule.local"];
      # video is needed to control the backlight
      extraGroups = ["wheel" "input" "docker" "video" "audio" "network" "networkmanager"];
    } else {
      name = "ysaktan";
      home = "/Users/ysaktan";
    };

    # TODO: is this idiomatic?
    services = lib.optionalAttrs pkgs.stdenv.isLinux {
      # Avoid typing the username on TTY and only prompt for the password
      # https://wiki.archlinux.org/title/Getty#Prompt_only_the_password_for_a_default_user_in_virtual_console_login
      getty.loginOptions = lib.mkIf pkgs.stdenv.isLinux "-p -- ${username}";
      getty.extraArgs = if pkgs.stdenv.isLinux then  ["--noclear" "--skip-login"] else [];
    };
  };
}
