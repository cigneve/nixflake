{
    lib,...
}:{
    programs.yazi = {
      enable = true;
      keymap = {
          mgr.prepend_keymap = [
              {
                on   = [ "g" "c" ];
                run  = "plugin git-files";
                desc = "Show Git file changes";
              }
          ];
      };
      initLua = ''
          require("git"):setup()
          '';
      settings = {
          plugin.prepend_fetchers = [
            {
                id   = "git";
                name = "*";
                run  = "git";
            }
            {
                id   = "git";
                name = "*/";
                run  = "git";
            }
          ];
      };
      plugins = let yazi-rs-plugins = builtins.fetchGit {
          url = "https://github.com/yazi-rs/plugins/";
          rev = "d7588f6d29b5998733d5a71ec312c7248ba14555";
      }; in {
          git-files = (builtins.fetchGit {
              url = "https://github.com/ktunprasert/git-files.yazi.git";
              rev = "c7289ad66140f539e0427734b1282f6bd3f65c03";
          });
          git = yazi-rs-plugins.outPath + "/git.yazi";
      };
    };
}
