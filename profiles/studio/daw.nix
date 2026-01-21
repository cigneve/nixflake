{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    reaper
    vital
    tenacity
    klick
    qpwgraph

    # Audio plugins (LV2, VST2, VST3, LADSPA)
    # distrho # TODO: Temporarily disabled
    easyeffects
    calf
    eq10q
    lsp-plugins
    x42-plugins
    x42-gmsynth
    dragonfly-reverb
    guitarix
    fil-plugins
    geonkick

    # Windows VST compatibility
    yabridge
    yabridgectl
    wineWowPackages.stable
  ];
  # Setup Yabridge
  # home.file = {
  #   ".config/yabridgectl/config.toml".text = ''
  #     plugin_dirs = ['/home/babadir/.win-vst']
  #     vst2_location = 'centralized'
  #     no_verify = false
  #     blacklist = []
  #   '';
  # };
}
