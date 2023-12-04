{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.simpleFlake {
      inherit self nixpkgs;
      name = "orchard";
      config = {
        allowUnfree = true;
      };
      overlay = (final: prev: {
        nodejs = prev.nodejs_20;
        dotnet-sdk = prev.dotnet-sdk_7;
      });
      shell = { pkgs }:
        pkgs.mkShell {
          packages = with pkgs;
          [
            # Nix
            nil
            nixpkgs-fmt

            # C#
            dotnet-sdk
            omnisharp-roslyn
            netcoredbg

            # Web
            nodejs
            nodePackages.yarn
            nodePackages.typescript-language-server
            nodePackages.vscode-langservers-extracted
            nodePackages.yaml-language-server

            # Misc
            nodePackages.yaml-language-server
            marksman
            taplo
          ];
        };
    };
}
