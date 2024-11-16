{pkgs, ...}: {
  musnix.enable = true;
  musnix.rtcqs.enable = true;
  environment.systemPackages = with pkgs; [rnnoise-plugin];
}
