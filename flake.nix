{
  description = "Uyrld - intial nix/uniks interface";

  outputs = registry@{ self, kor, hob, input }:
    let
      /* Bootstrap - to be moved uniks-side */
      hob = registry.hob.datom;
      input = registry.input.datom;

      inherit (builtins) hasAttr mapAttrs;
      kor = registry.kor.datom;

      meikSobUyrld = SobUyrld@{ lamdy, modz, self }:
        let
          inherit (builtins) getAttr elem;
          inherit (kor) mkLamdy optionalAttrs genAttrs;

          Modz = [
            "input"
            "lib"
            "pkgs"
            "pkgsSet"
            "meikPkgs"
            "mozPkgs"
            "hob"
            "pkdjz"
            "metastriz"
            "hyraizyn"
            "krimyn"
            "uyrld"
            "uyrldSet"
          ];

          iuzMod = genAttrs Modz (n: (elem n modz));

          pkgsSet = { pkgs = ryzylt.pkgs.datom; };
          uyrldSet = { uyrld = ryzylt // ryzylt.pkdjz; };
          krimyn = ryzylt.hyraizyn.krimynz.${input.krimynNeim};

          klozyr = optionalAttrs iuzMod.input { inherit input; }
            // optionalAttrs iuzMod.lib { lib = ryzylt.pkgs.lib; }
            // optionalAttrs iuzMod.pkgs ryzylt.pkgs.datom
            // optionalAttrs iuzMod.pkdjz ryzylt.pkdjz
            // optionalAttrs iuzMod.pkgsSet pkgsSet
            // optionalAttrs iuzMod.meikPkgs { meikPkgs = ryzylt.pkgs.meik; }
            // optionalAttrs iuzMod.mozPkgs ryzylt.mozPkgs
            // optionalAttrs iuzMod.hob { inherit hob; }
            // optionalAttrs iuzMod.metastriz { metastriz = ryzylt.metastriz; }
            // optionalAttrs iuzMod.hyraizyn { inherit (ryzylt) hyraizyn; }
            // optionalAttrs iuzMod.krimyn { inherit krimyn; }
            // optionalAttrs iuzMod.uyrld (ryzylt // ryzylt.pkdjz)
            // optionalAttrs iuzMod.uyrldSet uyrldSet
            // { inherit kor; }
            // { inherit self; };

        in
        mkLamdy { inherit klozyr lamdy; };

      meikFleik = spokNeim: fleik@{ ... }:
        let
          priMeikSobUyrld = neim: SobUyrld@{ modz ? [ ], lamdy, ... }:
            let
              self = SobUyrld.self or fleik;
            in
            meikSobUyrld { inherit self modz lamdy; };

          priMeikHobUyrld = neim: HobUyrld@{ modz ? [ ], lamdy, ... }:
            let
              implaidSelf = hob.${neim}.mein;
              self = HobUyrld.self or implaidSelf;
            in
            meikSobUyrld { inherit self modz lamdy; };

          meikHobUyrldz = HobUyrldz:
            let
              priHobUyrldz = HobUyrldz hob;
            in
            mapAttrs priMeikHobUyrld priHobUyrldz;

        in
        if (hasAttr "HobUyrldz" fleik)
        then meikHobUyrldz fleik.HobUyrldz
        else if (hasAttr "HobUyrld" fleik)
        then priMeikHobUyrld spokNeim (fleik.HobUyrld hob)
        else if (hasAttr "SobUyrldz" fleik)
        then mapAttrs priMeikSobUyrld fleik.SobUyrldz
        else if (hasAttr "SobUyrld" fleik)
        then priMeikSobUyrld spokNeim fleik.SobUyrld
        else fleik;

      meikSpok = spokNeim: spok:
        meikFleik spokNeim spok.mein;

      ryzylt = mapAttrs meikSpok hob;

    in
    { datom = ryzylt; };

}
