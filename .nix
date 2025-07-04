
{ pkgs ? import <nixpkgs> {} }:

{
  deps = [
    pkgs.asio
    pkgs.gcc
    pkgs.crow
    pkgs.sqlite
    pkgs.pkg-config
    pkgs.sqlite.dev
    # other dependencies
  ];
}
