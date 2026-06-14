{config, ...}: {
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = config.programs.git.settings.user.name;
        email = config.programs.git.settings.user.email;
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
