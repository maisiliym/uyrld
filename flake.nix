{
  description = "Uyrld";

  outputs = registry@{ self, kor, hob, pkgs, nixpkgs-mozilla, hyraizyn }:
    let
      meik = indeks:
        mapAttrs (n: flake: mkFlake flake) indeks;

      meikSobUyrld = sobUyrld@{ lamdy, modz ? [ ], self }:
        let
          kor = registry.kor.datom;
          inherit (kor) optionalAttr elem genAttrs;

          hyraizyn = registry.hyraizyn.datom;
          krimyn = registry.hyraizyn.krimyn;

          pkgs = registry.pkgs.meik {
            localSystem = hyraizyn.astra.sistym;
          };

          mozPkgs = registry.pkgs.meik {
            overlays = [ (import (nixpkgs-mozilla + /rust-overlay.nix)) ];
            localSystem = hyraizyn.astra.sistym;
          };

          Modz = [ "pkgs" "krimyn" "hyraizyn" "mozPkgs" "uyrld" ];
          iuzMod = genAttrs Modz (n: (elem n Modz));

          klozyr = optionalAttr iuzMod.pkgs pkgs
            // optionalAttr iuzMod.uyrld datom
            // optionalAttr iuzMod.mozPkgs mozPkgs
            // optionalAttr iuzMod.hyraizyn { inherit hyraizyn; }
            // optionalAttr iuzMod.krimyn { inherit krimyn; };

        in
        mkLamdy { inherit klozyr lamdyy; };

      mkFlake = flake@{ sobUyrld, ... }:
        meikSobUyrld (sobUyrld // { self = flake; });

      datom = mapAttrs (n: v: meik v.sobUyrld) hob.datom;

    in
    {
      inherit meik datom;
    };

}
