{
  description = "System Configuration Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    ki-editor.url = "github:ki-editor/ki-editor";
  };

  outputs = { self, nixpkgs, ki-editor, ...  }: {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
        modules = [
          ({ pkgs, ... } : {system.configurationRevision = nixpkgs.lib.mkIf (self ? rev) self.rev;})
          { environment.systemPackages = [ ki-editor.packages.x86_64-linux.default ]; }
          ./configuration.nix
      ];
    };
  };
}
