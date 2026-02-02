{lib,config,...}: let cfg = config.cigneve_readeck; in {
  home-manager.users.services = {
    virtualisation.quadlet = {
      containers.readeck = {
        autoStart = true;
        containerConfig = {
          image = "codeberg.org/readeck/readeck:latest";
          PublishPort = ["8000:8000"];
          containerConfig = {
            Image = "codeberg.org/readeck/readeck:latest";

            publishPorts = ["8080:8080"];
            # Environment variables for custom ports or logs
            Environment = [
              "READECK_SERVER_HOST=0.0.0.0"
              "READECK_SERVER_PORT=8000"
              "READECK_LOG_LEVEL=info"
            ];
            # Main data volume (SQLite DB + Archived articles)
            Volume = [
              "/var/lib/readeck:/readeck:Z"
            ];
          };
        };
      };
    };
  };  
}
