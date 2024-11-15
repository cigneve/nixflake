{
    lib,...
}:{
    programs.yazi = {
      enable = true;
    };
    xdg.configFile."yazi" = {
        source = ./config;
    };
}
