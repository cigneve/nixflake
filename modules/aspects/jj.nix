{
  cig,
  ...
}: {
  cig.jj.homeManager = {
    pkgs,
    inputs',
    ...
  }: {
    programs.jujutsu = {
      enable = true;
      settings = {
        user = {
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
  };
}
