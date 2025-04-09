{...}: {
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Yusuf Said Aktan";
        email = "contact@ysaktan.com";
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
