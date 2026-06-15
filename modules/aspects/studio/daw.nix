{pkgs, ...}: {
  cig.studio._.daw.nixos = {
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
  };
}
