{
  cig,
  pkgs,
  ...
}: {
  cig.fzf.homeManager = {
    programs.fzf = {
      enable = true;
      defaultOptions = ["--reverse" "--ansi"];
      defaultCommand = "fd .";
      fileWidgetCommand = "fd .";
      changeDirWidgetCommand = "fd --type d . $HOME";
    };
  };
}
