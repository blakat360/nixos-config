{ config, pkgs, nix-colors, mach-nix, ... }:

{
  home.packages = with pkgs; [
    jupyter
  ];

  programs.fish.functions = {
    mkJupyterShell =
      let
        shell_source = ''
          with (import <nixpkgs> { });
          let
            mach-nix = import (builtins.fetchGit {
              url = 'https://github.com/DavHau/mach-nix';
              ref = 'refs/tags/3.5.0';
            }) { };
            built-in-reqs = builtins.readFile ./requirements.txt;
            python = mach-nix.mkPython {
              requirements = built-in-reqs + '''
              ''';
            };
          in mach-nix.nixpkgs.mkShell {

            buildInputs = [ python ];
          }
        '';
      in
      ''
				echo "${shell_source}" > shell.nix
      '';
  };
}
