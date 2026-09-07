{
  description = "PostgreSQL 18 client tools for the practice database";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
      devShells = forAllSystems (system:
        let pkgs = import nixpkgs { inherit system; };
        in {
          default = pkgs.mkShell {
            packages = [ pkgs.postgresql_18 ];
            shellHook = ''
              export PGHOST=127.0.0.1
              export PGPORT=5432
              export PGDATABASE=practice_db
              export PGUSER=practice_user
            '';
          };
        });
    };
}
