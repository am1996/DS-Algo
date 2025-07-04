
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    asio
    gcc
    crow
    sqlite
    pkg-config
    sqlite.dev
    cmake
  ];
}
