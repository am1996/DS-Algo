
{ pkgs }: {
  deps = [
    pkgs.nim-unwrapped-2
    pkgs.go
    pkgs.python-launcher
    pkgs.perl538Packages.Mojolicious
    pkgs.sqlite
    pkgs.dotnetCorePackages.sdk_9_0
    pkgs.asio
    pkgs.cmake
    pkgs.gcc
    pkgs.pkg-config
  ];
}
