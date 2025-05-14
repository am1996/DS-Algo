
{ pkgs }: {
  deps = [
    pkgs.gcc
    pkgs.crow
    pkgs.sqlite
    pkgs.pkg-config
    pkgs.sqlite.dev
  ];
}
