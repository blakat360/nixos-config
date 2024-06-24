{ pkgs, ... }: {
  home.packages = with pkgs; [
    boost179
    cling
    clang-tools
    cmake
    gcc
    gnumake
    ninja
  ];

  xdg.configFile."clangd/config.yaml".text = ''
    CompileFlags:
      Add: [-std=c++20]
    Diagnostics:
      ClangTidy:
        Add: *
  '';
}
