{self, ...}: {
  flake.templates = let
    templatesPath = ../../templates;
  in {
    bootstrap = {
      description = "A bootstrapping flake for creating a new host configuration.";
      path = "${templatesPath}/bootstrap";
    };

    latex = {
      description = "A LaTeX environment for writing.";
      path = "${templatesPath}/latex";
    };

    vm-testing = {
      description = "A testing VM for quick ad-hoc testing of Nix configurations.";
      path = "${templatesPath}/vm-testing";
    };

    default = self.templates.bootstrap;
  };
}
