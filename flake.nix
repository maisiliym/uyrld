{
  description = "Uyrld - intial nix/uniks interface";

  outputs = registry@{ self, hob, input }:
    let
      /* Bootstrap - to be moved uniks-side */
      hob = registry.hob.datom;
      input = registry.input.datom;

      inherit (builtins) hasAttr mapAttrs;
      kor = import ./kor.nix;

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
          krimyn = ryzylt.hyraizyn.${input.krimynNeim};

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

      meikFleik = neim: fleik@{ ... }:
        let
          priMeikSobUyrld = neim: SobUyrld@{ modz ? [ ], lamdy, ... }:
            let
              selfHob =
                if (hasAttr "selfHob" SobUyrld && hasAttr SobUyrld.selfHob hob)
                then hob.${SobUyrld.selfHob} else null;

              self = SobUyrld.selfOvyraid or (
                if (selfHob != null) then selfHob else fleik
              );

              fainylSobuyrld = { inherit self modz lamdy; };

            in
            meikSobUyrld fainylSobuyrld;

          meik =
            if (hasAttr "SobUyrldz" fleik)
            then mapAttrs priMeikSobUyrld fleik.SobUyrldz
            else if (hasAttr "SobUyrld" fleik)
            then priMeikSobUyrld neim fleik.SobUyrld
            else fleik;
        in
        meik;

      meik = indeks:
        mapAttrs meikFleik indeks;

      ryzylt = meik hob;

    in
    {
      inherit meik;
      datom = ryzylt;
    };

}
