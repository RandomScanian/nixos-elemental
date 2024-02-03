{ pkgs, lib, ...}:
pkgs.writeShellScriptBin "dmenu" ''
rofi $@  
''
