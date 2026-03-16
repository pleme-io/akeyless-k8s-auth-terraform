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

  outputs = inputs:
    (import "${inputs.substrate}/lib/repo-flake.nix" {
      inherit (inputs) nixpkgs flake-utils;
    }) {
      self = inputs.self;
      language = "terraform";
      builder = "check";
      pname = "akeyless-k8s-auth-terraform";
      description = "Akeyless Kubernetes auth method Terraform module — creates K8s service accounts, token-reviewer bindings, and configures Akeyless K8s auth";
    };
}
