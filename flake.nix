{
  description = "Akeyless Kubernetes auth method Terraform module — creates K8s service accounts, token-reviewer bindings, and configures Akeyless K8s auth";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    substrate = {
      url = "github:pleme-io/substrate";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, substrate, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs { inherit system; };
      mkTerraformModuleCheck = (import "${substrate}/lib/terraform-module.nix").mkTerraformModuleCheck;
    in {
      checks.default = mkTerraformModuleCheck pkgs {
        pname = "akeyless-k8s-auth-terraform";
        version = "0.0.0-dev";
        src = self;
        description = "Akeyless Kubernetes auth method Terraform module — creates K8s service accounts, token-reviewer bindings, and configures Akeyless K8s auth";
        homepage = "https://github.com/pleme-io/akeyless-k8s-auth-terraform";
      };

      devShells.default = pkgs.mkShellNoCC {
        packages = with pkgs; [
          opentofu
          tflint
          terraform-docs
        ];
      };
    });
}
