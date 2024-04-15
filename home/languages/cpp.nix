{ pkgs, ... }: {
  home.packages = with pkgs; [
    cling
    cmake
    gcc
    ninja
  ];

  xdg.configFile."clangd/config.yaml".text = ''
    CompileFlags:
      Add: [-std=c++20]
  '';
}
