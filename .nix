{ pkgs ? import <nixpkgs> {} }:
let
  myPackage = pkgs.callPackage ./myPackage.nix {};
in
  myPackage
{ pkgs }: {
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