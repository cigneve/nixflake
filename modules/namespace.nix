{
  inputs,
  den,
  ...
}:
{
  imports = [
    (inputs.den.namespace "cig" false)
  ];

  _module.args.__findFile = den.lib.__findFile;
}
