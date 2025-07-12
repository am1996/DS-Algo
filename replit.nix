
{ pkgs }: {
  deps = [
    pkgs.dotnetCorePackages.runtime_9_0
    pkgs.asio
    pkgs.cmake
    pkgs.gcc
    pkgs.pkg-config
  ];
}
