
{ pkgs ? import <nixpkgs> {} }:
pkgs.buildInputs = [
  pkgs.openssl
];
pkgs.mkShell {
  buildInputs = with pkgs; [
    asio
    gcc
    sqlite
    pkg-config
    powershell
    sqlite.dev
    cmake
  ];
}
