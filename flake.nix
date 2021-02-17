{
  description = "Uyrld - intial nix/uniks interface";

  outputs = registry@{ self, kor, lib, hob, hyraizyn }:
    let
      /* Bootstrap - to be moved uniks-side */
      kor = registry.kor.datom;
      lib = registry.lib.datom;
      hob = registry.hob.datom;
      hyraizyn = registry.hyraizyn.datom;
      krimyn = registry.hyraizyn.krimyn;

      inherit (builtins) hasAttr mapAttrs;

      meikSobUyrld = sobUyrld@{ lamdy, modz, self }:
        let
          inherit (builtins) getAttr;
          inherit (kor) mkLamdy optionalAttrs elem genAttrs;

          Modz = [
            "kor"
            "lib"
            "pkgs"
            "mozPkgs"
            "hob"
            "pkdjz"
            "hyraizyn"
            "krimyn"
            "uyrld"
          ];

          iuzMod = genAttrs Modz (n: (elem n modz));

          klozyr = optionalAttrs iuzMod.kor { inherit kor; }
            // optionalAttrs iuzMod.lib { inherit lib; }
            // optionalAttrs iuzMod.pkgs uyrld.pkgs
            // optionalAttrs iuzMod.mozPkgs uyrld.mozPkgs
            // optionalAttrs iuzMod.hob { inherit hob; }
            // optionalAttrs iuzMod.pkdjz { inherit (uyrld) pkdjz; }
            // optionalAttrs iuzMod.hyraizyn { inherit hyraizyn; }
            // optionalAttrs iuzMod.krimyn { inherit krimyn; }
            // optionalAttrs iuzMod.uyrld uyrld
            // { inherit self; };

        in
        mkLamdy { inherit klozyr lamdy; };

      meikFleik = neim: fleik@{ ... }:
        let
          priMeikSobUyrld = sobUyrld@{ modz ? [ ], lamdy, ... }:
            let
              izSelfHob = hasAttr "selfHob" sobUyrld &&
                hasAttr sobUyrld.selfHob hob;
              self =
                if izSelfHob then hob.${sobUyrld.selfHob}
                else sobUyrld.selfOvyraid or fleik;
              fainylSobuyrld = { inherit self modz lamdy; };
            in
            meikSobUyrld fainylSobuyrld;

          meik =
            if (hasAttr "SobUyrldz" fleik)
            then mapAttrs (n: su: priMeikSobUyrld su) fleik.SobUyrldz
            else if (hasAttr "sobUyrld" fleik)
            then priMeikSobUyrld fleik.sobUyrld
            else fleik;
        in
        meik;

      meik = indeks:
        mapAttrs meikFleik indeks;

      uyrld = meik hob;

    in
    {
      inherit meik;
      datom = uyrld;
    };

}
