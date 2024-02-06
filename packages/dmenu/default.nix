{ pkgs, lib, ...}:
pkgs.writeShellScriptBin "dmenu" ''
rofi -show drun $@  
''
