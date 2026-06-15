{cig,  ...}:   let
    personalFonts = {
      monospace = "Comic Code Medium";
      serifAlias = "Cambria";
      serif = "Sprat";
      sans = "Avenir Next LT Pro";
    };
  in {
    cig.fonts.nixos = {pkgs,...}:{
      fonts = {
    packages = with pkgs; [
      ubuntu-classic
      font-awesome
      noto-fonts
      noto-fonts-cjk-sans
      twemoji-color-font
      inter
      fira-code-symbols
      fira-mono
      fira
      libertine
      roboto
      proggy
      cozette
    ];
    fontconfig.defaultFonts = {
      serif = [personalFonts.serifAlias];
      sansSerif = [personalFonts.sans];
      monospace = [personalFonts.monospace];
    };
    fontconfig.localConf = ''
      <fontconfig>
        <match>
          <test name="family"><string>Helvetica</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Inter</string>
          </edit>
        </match>

      </fontconfig>
    '';
   }; };
}
