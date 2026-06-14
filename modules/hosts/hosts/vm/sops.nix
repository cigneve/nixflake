{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ sops ];
  sops.age.sshKeyPaths = [ "/home/baba/.ssh/id_ed25519" ];
  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.secrets."cloudflared-creds" = {
    format = "json";
    sopsFile = ./secrets/da38ced1-2335-4195-b6f7-60a99b15a878.json;
    key = "";
    mode = "0440";
    group = "keys";
   };
}
