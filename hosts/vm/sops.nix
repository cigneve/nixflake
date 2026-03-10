{
  sops.age.sshKeyPaths = [ "/home/baba/.ssh/id_ed25519" ];
  sops.defaultSopsFile = ./secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.secrets."cloudflared-creds" = {};
}
