
{ pkgs }: {
  deps = [
    pkgs.clang_18
    pkgs.clang-tools_18
    pkgs.ccls
    pkgs.gdb
    pkgs.gnumake
  ];
}
