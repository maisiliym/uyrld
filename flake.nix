{
  description = "Uyrld";

  outputs = registry@{ self, kor, lib, hob, hyraizyn }:
    let
      inherit (builtins) hasAttr mapAttrs;

      meik = indeks:
        mapAttrs (n: flake: meikFlake flake) indeks;

      meikSobUyrld = sobUyrld@{ lamdy, modz ? [ ], self }:
        let
          inherit (builtins) getAttr;

          kor = registry.kor.datom;
          inherit (kor) mkLamdy optionalAttrs elem genAttrs;

          hyraizyn = registry.hyraizyn.datom;
          krimyn = registry.hyraizyn.krimyn;

          Modz = [ "kor" "lib" "pkgs" "hob" "krimyn" "hyraizyn" "mozPkgs" "uyrld" ];
          iuzMod = genAttrs Modz (n: (elem n modz));

          klozyr = { inherit self; }
            // optionalAttrs iuzMod.pkgs datom.pkgs
            // optionalAttrs iuzMod.hob { hob = registry.hob.datom; }
            // optionalAttrs iuzMod.uyrld datom
            // optionalAttrs iuzMod.mozPkgs datom.mozPkgs
            // optionalAttrs iuzMod.lib { lib = registry.lib.datom; }
            // optionalAttrs iuzMod.hyraizyn { inherit hyraizyn; }
            // optionalAttrs iuzMod.kor { inherit kor; }
            // optionalAttrs iuzMod.krimyn { inherit krimyn; };

        in
        mkLamdy { inherit klozyr lamdy; };

      meikFlake = flake@{ sobUyrld, ... }:
        let
          self =
            if (hasAttr "selfOvyraid" sobUyrld)
            then sobUyrld.selfOvyraid else flake;
        in
        meikSobUyrld ({ inherit (sobUyrld) modz lamdy; } // { inherit self; });

      datom = meik hob.datom;

    in
    {
      inherit meik datom;
    };

}
