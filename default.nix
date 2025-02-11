{ pkgs ? import
    (fetchTarball {
      name = "jpetrucciani-2025-02-11";
      url = "https://github.com/jpetrucciani/nix/archive/d8aa2985c2dc71b366ba7e7a3505e34829c719b0.tar.gz";
      sha256 = "03w6zc1xac8323705z2sv92r6lyld3cyb83gzzsa1nc4q4rzi2fc";
    })
    { }
}:
let
  name = "TruthBot";


  tools = with pkgs; {
    cli = [
      jfmt
      nixup
    ];
    python = [
      ruff
      (python311.withPackages (p: with p; [
        black
        uv
      ]))
    ];
    scripts = pkgs.lib.attrsets.attrValues scripts;
  };

  scripts = with pkgs; { };
  paths = pkgs.lib.flatten [ (builtins.attrValues tools) ];
  env = pkgs.buildEnv {
    inherit name paths; buildInputs = paths;
  };
in
(env.overrideAttrs (_: {
  inherit name;
  NIXUP = "0.0.8";
})) // { inherit scripts; }
