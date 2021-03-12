{
  description = "Uyrld - intial nix/uniks interface";

  outputs = registry@{ self, kor, hob, input }:
    let
      /* Bootstrap - to be moved uniks-side */
      hob = registry.hob.datom;
      input = registry.input.datom;

      inherit (builtins) hasAttr mapAttrs;
      kor = registry.kor.datom;

      pkdjz = uyrld.pkdjz;
      pkgs = pkdjz.meikPkgs { };
      krimyn = uyrld.hyraizyn.krimynz.${input.krimynNeim};

      meikSobUyrld = SobUyrld@{ lamdy, modz, self }:
        let
          inherit (builtins) getAttr elem;
          inherit (kor) mkLamdy optionalAttrs genAttrs;

          Modz = [
            "input"
            "lib"
            "pkgs"
            "pkgsSet"
            "hob"
            "pkdjz"
            "uyrld"
            "uyrldSet"
            "metastriz"
            "hyraizyn"
            "krimyn"
          ];

          iuzMod = genAttrs Modz (n: (elem n modz));

          /* Warning: sets shadowing */
          klozyr = optionalAttrs iuzMod.pkgs pkgs
            // optionalAttrs iuzMod.uyrld uyrld
            // optionalAttrs iuzMod.pkdjz pkdjz
            // optionalAttrs iuzMod.input { inherit input; }
            // optionalAttrs iuzMod.hob { inherit hob; }
            // optionalAttrs iuzMod.lib { inherit (pkdjz) lib; }
            // optionalAttrs iuzMod.pkgsSet { inherit pkgs; }
            // optionalAttrs iuzMod.uyrldSet { inherit uyrld; }
            // optionalAttrs iuzMod.metastriz { inherit (uyrld) metastriz; }
            // optionalAttrs iuzMod.hyraizyn { inherit (uyrld) hyraizyn; }
            // optionalAttrs iuzMod.krimyn { inherit krimyn; }
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

      uyrld = mapAttrs meikSpok hob;

    in
    { datom = uyrld // { inherit pkgs; }; };

}
