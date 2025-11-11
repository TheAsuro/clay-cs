{
  description = "Dev shell for C# with ClangSharp and Zig";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.dotnet-sdk_9  # C# / .NET SDK
            pkgs.zig_0_13           # Zig
            pkgs.llvmPackages.clang  # Clang (provides libclang for ClangSharp)
          ];

          shellHook = ''
          '';
        };
      });
}
