
{ pkgs }: {
  deps = [
    pkgs.sqlite
    pkgs.dotnetCorePackages.sdk_9_0
    pkgs.asio
    pkgs.cmake
    pkgs.gcc
    pkgs.pkg-config
  ];
}
