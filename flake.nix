{
  description = "Dev shell for C# with ClangSharp and Zig";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.dotnet-sdk_9
            pkgs.zig_0_13
            pkgs.llvmPackages_20.clang
            pkgs.llvmPackages_20.libclang
          ];

          shellHook = ''
            export DOTNET_ROOT="${pkgs.dotnet-sdk_9}/lib/dotnet"
            export PATH="$PATH:$HOME/.dotnet/tools"
            export LD_LIBRARY_PATH="${pkgs.llvmPackages_20.libclang.lib}/lib:$LD_LIBRARY_PATH"
            export LIBCLANG_PATH="${pkgs.llvmPackages_20.libclang.lib}/lib"
            dotnet tool install --global ClangSharpPInvokeGenerator --version 20.1.2.1
          '';
        };
      });
}
