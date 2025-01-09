{
  description = "System Configuration Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    stable.url = "github:nixos/nixpkgs?ref=nixos-23.11";
    ki-editor.url = "github:ki-editor/ki-editor";
  };

  outputs = { self, nixpkgs, stable, ki-editor, ...  }: {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
        modules = [
          ({ pkgs, ... } : {system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;})
          { environment.systemPackages = [
            stable.legacyPackages.x86_64-linux.bibata-cursors
            stable.legacyPackages.x86_64-linux.jetbrains.idea-community
            ki-editor.packages.x86_64-linux.default
          ]; }
          ./configuration.nix
      ];
    };
  };
}
