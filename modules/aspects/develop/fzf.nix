{
  cig,
  pkgs,
  ...
}: {
  cig.fzf.homeManager = {
    pkgs,
    inputs',
    ...
  }: {
    programs.fzf = {
      enable = true;
      defaultOptions = ["--reverse" "--ansi"];
      defaultCommand = "fd .";
      fileWidgetCommand = "fd .";
      changeDirWidgetCommand = "fd --type d . $HOME";
    };
  };
}
