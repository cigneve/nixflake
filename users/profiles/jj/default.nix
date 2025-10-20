{config, ...}: {
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = config.programs.git.userName;
        email = config.programs.git.userEmail;
      };
      aliases = {
        tug = ["bookmark" "move" "--from" "heads(::@- & bookmarks())" "-to" "@-"];
      };
      ui = {
        color = "always";
        pager = "delta";
      };
      diff = {
        format = "git";
      };
    };
  };
}
