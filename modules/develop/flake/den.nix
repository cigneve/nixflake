{ inputs, lib, ... }:
{
  flake-file.inputs.den.url = lib.mkDefault "github:denful/den";
  flake-file.inputs.flake-aspects.url = "github:denful/flake-aspects";
  flake-file.inputs.flake-file.url = lib.mkDefault "github:denful/flake-file";
  flake-file.inputs.flake-parts.url = "github:hercules-ci/flake-parts";

  flake-file.inputs.dendrix.url = "github:denful/dendrix";

  imports = [
    (inputs.flake-file.flakeModules.dendritic or { })
    (inputs.den.flakeModules.dendritic or { })
  ];

}
