
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    asio
    gcc
    sqlite
    pkg-config
    sqlite.dev
    cmake
  ];
}
