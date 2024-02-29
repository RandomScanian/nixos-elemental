{
  pkgs,
  lib,
  ...
}:
pkgs.writeShellScriptBin "dmenu_run" ''
  rofi -show drun $@
''
