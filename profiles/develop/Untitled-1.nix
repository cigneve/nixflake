{
  makeOverridable = f: origArgs: let origRes = f origArgs; in { override = newArgs: (f newArgs)// {origRes} } // origRes
}