{ pkgs, inputs, ... }:
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = inputs.dracula-sddm;
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
    cd $out/
    rm Background.jpg
   '';
  #    cp -r ${image} $out/Background.jpg
}
