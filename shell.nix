{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    ruby
    watchman
  ];

  nativeBuildInputs = with pkgs; [
    libyaml
    vips
  ];

  shellHook = ''
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [ pkgs.vips ]}:$LD_LIBRARY_PATH"
  '';
}
