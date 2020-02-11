{
  description = "Uyrld";

  outputs = flakes@{ self, kor, hob, pkgs, nixpkgs-mozilla, hyraizyn }:
    let
      meik = { lamdy, modz ? [ ] }:
        let
          inherit (kor) optionalAttr elem genAttrs;

          hyraizyn = flakes.hyraizyn.datom;
          krimyn = flakes.hyraizyn.krimyn;

          pkgs = flakes.pkgs.meik {
            localSystem = hyraizyn.astra.sistym;
          };

          mozPkgs = flakes.pkgs.meik {
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

      datom = mapAttrs (n: v: meik v.sobUyrld) hob.datom;

    in
    {
      inherit meik datom;
    };

}
