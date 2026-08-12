// [{
  // MRPV2_fnc_Interaction_PNJ_Divers = {    
private _objCurseur = toLowerANSI str cursorObject;
private _liste_Actions = createHashMap;

[] call 
{
  if (toLowerANSI "MRPV2_PNJ_Axa" in _objCurseur) exitwith
  {
    private _texte = "Macif";
    private _texte_tooltype = "";
    private _action = 
    {closeDialog 0;
        [cursorobject,player,"Massif Assurance","menu_axa"] spawn ALF_fnc_menuAxa;
    };

    _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["",_liste_Sous_Actions];
  };

  if (toLowerANSI "MRPV2_PNJ_Annonce_Bfm" in _objCurseur) exitwith
  {
    private _texte = "Publier une annonce (850€)";
    private _texte_tooltype = "";
    private _action = 
    {closeDialog 0;
        [cursorobject,player,"Publier une annonce (850€)","annonce_bfm"] spawn ALF_fnc_annonceBFM;
    };

    _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["",_liste_Sous_Actions]; 
  };

  if (toLowerANSI "MRPV2_PNJ_Banque" in _objCurseur) exitwith
  {
    COMMENT "Si le joueur n'est pas armé ou a une arme non autorisée quand il braque la banque";
    private _pas_Armer = currentWeapon player isequalto "";
    private _a_Pas_Bonne_Arme = (currentWeapon player in 
    [
      "ALF_Peinture_Black","ALF_Peinture_Green","ALF_Pancarte_Dormir","ALF_Pancarte_Amour","ALF_Pancarte_Manje","ALF_Pancarte_Incompetants",
      "ALF_Pancarte_NikLaGN","ALF_Pancarte_Banque","ALF_Pancarte_Climat","ALF_Pancarte_Corruption","ALF_Pancarte_Impots","ALF_Pancarte_Vener",
      "ALF_sifflet","ALF_Batte","ALF_Hache","ALF_Faux","ALF_Camera","ALF_Flash_Light"
    ]);
    private _deja_Braque = cursorObject getVariable ["ALF_alreadyBraq", false];
    
    // Si le braquage n'a pas encore été fait et que le joueur n'est pas armé correctement, fermer le dialogue
    if (!_deja_Braque AND {_pas_Armer OR {_a_Pas_Bonne_Arme}}) exitWith {closeDialog 2;};

    // Action pour braquer l'employé (seulement si le braquage n'a pas encore été fait et que le joueur est armé)
    if (!_deja_Braque AND {!_pas_Armer AND {!_a_Pas_Bonne_Arme}}) then
    {
      private _texte = "Braquer l'employé";
      private _texte_tooltype = "";
      private _action = 
      {closeDialog 0;
          [] spawn ALF_fnc_braquageAgence;
      };

      _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
      _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
      _liste_Actions set ["",_liste_Sous_Actions];
    };

    // Action pour consulter la somme volée (si le braquage a déjà été fait) - Seulement pour les gendarmes
    if (_deja_Braque AND {life_copLevel > 0}) then
    {
      private _texte = "Consulter la somme volée";
      private _texte_tooltype = "";
      private _action = 
      {closeDialog 0;
          private _pnj = cursorObject;
          private _montant = _pnj getVariable ["ALF_braquageAmount", 0];
          if (_montant > 0) then
          {
              ["Banque", format["La somme volée lors du braquage était de %1 €", [_montant] call ALF_fnc_numberText], "info", false] spawn ALF_fnc_doMsg;
          } else
          {
              ["Banque", "Aucune information disponible sur le braquage.", "warning", false] spawn ALF_fnc_doMsg;
          };
      };

      _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
      _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
      _liste_Actions set ["",_liste_Sous_Actions];
    };
  };

  // Permis camion
  // if (toLowerANSI "MRPV2_PNJ_Permis_Camion" in _objCurseur) exitwith
  // {
  //   private _texte = "Passer le Permis C";
  //   private _texte_tooltype = "";
  //   private _action = 
  //   {closeDialog 0;
  //       [cursorobject,player,"Passer le Permis C","permis_camion"] spawn ALF_fnc_permisTruck;
  //   };

  //   _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
  //   _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
  //   _liste_Actions set ["",_liste_Sous_Actions]; 
  // };

  if (toLowerANSI "MRPV2_PNJ_Permis_Voiture" in _objCurseur) exitWith
  {
    private _texte = "Passer permis voiture";
    private _texte_tooltype = "";
    private _action = 
    {closeDialog 0;
        [cursorobject,player,"Passer le Permis","permis_voiture"] spawn ALF_fnc_permisCar;
    };

    _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["",_liste_Sous_Actions]; 

    private _texte = "Passer permis moto";
    private _texte_tooltype = "";
    private _action = 
    {closeDialog 0;
        [] call ALF_fnc_permisMoto;
    };

    _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["",_liste_Sous_Actions]; 

    if !(license_boat) then 
      {
        private _texte = "Acheter le Permis bateau";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
          [] spawn ALF_fnc_buyShipLicense;
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];
      };

    private _texte = "Stage de récup. de points";
    private _texte_tooltype = "";
    private _action = 
    {closeDialog 0;
        [] call ALF_fnc_stagePermis;
    };

    _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["",_liste_Sous_Actions];     
  };

  if (toLowerANSI "MRPV2_PNJ_Aeroport" in _objCurseur) exitwith
      {
        private _texte = "Magasin d'hélicoptère";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            ["civ_heli"] call ALF_fnc_vehicleShopMenuV2;
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];

        private _texte = "Magasin d'avions";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            ["Aerien"] call ALF_fnc_vehicleShopMenuV2;
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];

        private _texte = "Magasin de parachutes";
        private _texte_tooltype = "";
        private _action =
        {closeDialog 0;
            [nil, nil, nil, "aeroport_parachute"] spawn ALF_fnc_clothingMenu;
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];

        private _texte = "Mon garage aérien ";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            ["vehicles", "Air", player] remoteExecCall ["MRPV2_Server_fnc_Vehicule_Garage_Exporter_BDD", 2];
            createDialog "Life_impound_menu";
            disableSerialization;
            ctrlSetText [2802, "Chargement..."];
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];

        private _texte = "Ranger mon hélicoptère";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            ["air","Civil"] call MRPV2_fnc_Vehicule_Garage_Ranger;
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];
      };

  if (toLowerANSI "MRPV2_PNJ_Fourriere" in _objCurseur) exitWith
  {
    private _texte = "Garage de fourrière";
    private _texte_tooltype = "";
    private _action = 
    {closeDialog 0;
      [player] remoteExecCall ["ALF_Server_fnc_getVehiclesLock", 2];
      createDialog "Life_impound_menuv3";
      disableSerialization;
      ctrlSetText [2802, "Chargement..."];
    };

    _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["",_liste_Sous_Actions];  

    if ((!isnil {b_Depanneur} AND {!b_Depanneur}) AND (!isnil {b_18} AND {!b_18})) exitwith {};

    private _texte = "Mettre en fourrière";
    private _texte_tooltype = "";
    private _action = 
    {closeDialog 0;
      [player,0] call MRPV2_fnc_Vehicule_Fourriere_Entrer;
    };

    _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["",_liste_Sous_Actions];  

    private _texte = "Mettre en fourrière (2H)";
    private _texte_tooltype = "";
    private _action = 
    {closeDialog 0;
      [player,2] call MRPV2_fnc_Vehicule_Fourriere_Entrer;
    };

    _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["",_liste_Sous_Actions];

    private _texte = "Mettre en fourrière (24H)";
    private _texte_tooltype = "";
    private _action = 
    {closeDialog 0;
      [player,24] call MRPV2_fnc_Vehicule_Fourriere_Entrer;
    };

    _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["",_liste_Sous_Actions];

    private _texte = "Mettre en fourrière (48H)";
    private _texte_tooltype = "";
    private _action = 
    {closeDialog 0;
      [player,48] call MRPV2_fnc_Vehicule_Fourriere_Entrer;
    };

    _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["",_liste_Sous_Actions];
  };

  if (toLowerANSI "MRPV2_PNJ_Casse" in _objCurseur) exitWith
  {
    private _texte = "Mettre à la casse";
    private _texte_tooltype = "";
    private _action = 
    {closeDialog 0;
      [] call MRPV2_fnc_Vehicule_Casse;
    };

    _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
    _liste_Actions set ["",_liste_Sous_Actions];
  };

  // Prefecture
  if (toLowerANSI "MRPV2_PNJ_Pref" in _objCurseur) exitwith
  {
    private _pref = nearestObjects [player, ["Land_MRP_Prefecture2"], 20] # 0;
    private _info_Ent = _pref getVariable ["business",[]];
    if !(isnil {_pref}) then 
    {
      if !("ALF_identite" in (magazines player)) then 
      {
        private _texte = "Récupérer votre CNI";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
          [] call ALF_fnc_recupIDcard;
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];
      };

      if !("ALF_Permis" in (magazines player)) then 
      {
        private _texte = "Récupérer votre Permis de conduire";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
          [] call ALF_fnc_recupPermis;
        };
  
        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];
      };

      if (license_driver) then 
      {
        private _texte = "Vérifier mes points";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
          [] spawn ALF_fnc_checkPermis;
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];
      };

      if !(license_moto) then 
      {
        private _texte = "Acheter le Permis Moto";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
          [] spawn ALF_fnc_permisMoto;
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];
      };

      if !(license_boat) then 
      {
        private _texte = "Acheter le Permis bateau";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
          [] spawn ALF_fnc_buyShipLicense;
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];
      };

      if (life_publique > 0 AND {b_13}) then 
      {
        private _texte = "Fin de service";
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
          [] call ALF_fnc_PubliqueService; [player] joinSilent (createGroup civilian);
        };

        if !(life_publique_service) then 
        {
          _texte ="Début de service";
          _action =
          {closeDialog 2; 
            [] call ALF_fnc_PubliqueService;

            private _groupe_Ent_Existe = ((groups civilian) select {groupId _x isEqualto "Préfecture"}) isnotequalto [];
            if (_groupe_Ent_Existe) then
            {
              private _groupe = ((groups civilian) select {groupId _x isEqualto "Préfecture"}) # 0;
              [player] joinSilent _groupe;
            } else 
            {
              private _groupe = createGroup civilian;
              _groupe setGroupIdGlobal ["Préfecture"];
              [player] joinSilent _groupe;
            };
          };
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];

        private _texte = "Vêtements (Prefecture)";
			  private _texte_tooltype = "";
			  private _action = 
			  {closeDialog 0;
				  [nil,nil,nil,"b_13"] spawn ALF_fnc_clothingMenu;
			  };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];

        private _texte = "Marché (Prefecture)";
		    private _texte_tooltype = "";
		    private _action = 
		    {closeDialog 0;
			  [cursorobject,player,"Prefecture","pref"] call ALF_fnc_weaponShopMenu;
		    };

		    _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		    _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		    _liste_Actions set ["",_liste_Sous_Actions];

                private _uid = getPlayerUID player;
        private _joueur_Est_Gerant = ((_info_Ent # 5) select {
          (_x # 1) isEqualTo _uid AND {(_x # 2) in [3,4]}
        }) isNotEqualTo [];

              //private _joueur_Est_Gerant = ((_info_Ent # 5) select {getPlayerUID player isequalto (_x # 1) AND {4 isequalto (_x # 2)}}) isNotequalto [];  
              if (_joueur_Est_Gerant) then 
              {
                  private _texte1 = "Gestion de l'entreprise";
                  private _texte_tooltype1 = "Gérer l'entreprise";
                  private _action1 = 
                  {
                      closeDialog 0;
                      private _pref = (nearestObjects [player, ["Land_MRP_Prefecture2"], 20]) # 0;
                      [_pref] spawn alf_fnc_menuBusiness;
                  };
                  _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
                  _liste_Sous_Actions pushback [_texte1,_texte_tooltype1,_action1];
                  _liste_Actions set ["",_liste_Sous_Actions];
              };

      }; 
    };	
  };
  // fin Prefecture

  // Tribunal
  if (toLowerANSI "MRPV2_PNJ_Tribunal" in _objCurseur) exitwith
  {
    if (life_publique > 0 AND {b_23}) then 
    {
      private _texte = "Fin de service";
      private _texte_tooltype = "";
      private _action = 
      {closeDialog 0;
        [] call ALF_fnc_PubliqueService; [player] joinSilent (createGroup civilian);
      };

      if !(life_publique_service) then 
      {
        _texte ="Début de service";
        _action =
        {closeDialog 2; 
          [] call ALF_fnc_PubliqueService;

          private _groupe_Ent_Existe = ((groups civilian) select {groupId _x isEqualto "Tribunal"}) isnotequalto [];
          if (_groupe_Ent_Existe) then
          {
            private _groupe = ((groups civilian) select {groupId _x isEqualto "Tribunal"}) # 0;
            [player] joinSilent _groupe;
          } else 
          {
            private _groupe = createGroup civilian;
            _groupe setGroupIdGlobal ["Tribunal"];
            [player] joinSilent _groupe;
          };
        };
      };

      _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
      _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
      _liste_Actions set ["",_liste_Sous_Actions];

      private _texte = "Vêtements (Tribunal)";
      private _texte_tooltype = "";
      private _action = 
      {closeDialog 0;
        [nil,nil,nil,"b_23"] spawn ALF_fnc_clothingMenu;
      };

      _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
      _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
      _liste_Actions set ["",_liste_Sous_Actions];

      private _texte = "Marché (Tribunal)";
      private _texte_tooltype = "";
      private _action = 
      {closeDialog 0;
      [cursorobject,player,"Tribunal","tribunal"] call ALF_fnc_weaponShopMenu;
      };

      _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
      _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
      _liste_Actions set ["",_liste_Sous_Actions];

    }; 	
  };

  // Wiki Tropic
  if (toLowerANSI "MRPV2_PNJ_Wiki_Tropic" in _objCurseur) exitwith
  {
    if !(b_2) then 
    {
      closeDialog 2;
        ["ENTREPRISE", "Vous devez faire partie de l'entreprise pour utiliser ces services.", "warning"] spawn ALF_fnc_doMsg;
    } else {
      // Shop 2
      private _texte = "Shop Wiki Tropic";
      private _texte_tooltype = "";
      private _action = 
      {closeDialog 0;
      [cursorobject,player,"Magasin 2","b_2"] call ALF_fnc_weaponShopMenu;
      };

      _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
      _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
      _liste_Actions set ["",_liste_Sous_Actions];
    }; 	
  };

  if (tolowerANSI "Vetement" in _objCurseur) exitwith
	{
    private _texte = "Vêtements";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
		  [nil,nil,nil,"Bruce"] spawn ALF_fnc_clothingMenu;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];

		if (!isnil {License_Femme}) then 
		{
			private _texte = "Vêtements (Femme)";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				[nil,nil,nil,"Women"] spawn ALF_fnc_clothingMenu;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];
		};

		private _texte = "Vêtements (Chasseur)";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			[nil,nil,nil,"Chasseur"] spawn ALF_fnc_clothingMenu;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};

  // Vetement VIP
  if (toLowerANSI "MRPV2_PNJ_Ventement_VIP" in _objCurseur) exitWith
{
    if !(life_donOR) then
    {
        closeDialog 2;
        ["VETEMENT VIP", "Vous devez être un donateur pour utiliser ces services.", "warning"] spawn ALF_fnc_doMsg;
    } else {
        private _texte = "Vêtements VIP";
        private _texte_tooltype = "";
        private _action =
        {
            closeDialog 0;
            [nil,nil,nil,"premium"] spawn ALF_fnc_clothingMenu;
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];
    };
};
  

	if (tolowerANSI "Superette_Station" in _objCurseur) exitwith
	{
		private _est_armer = currentWeapon player isnotequalto "";
		private _a_Bonne_Arme = !(currentWeapon player in 
		[
			"ALF_Peinture_Black","ALF_Peinture_Green","ALF_Pancarte_Dormir","ALF_Pancarte_Amour","ALF_Pancarte_Manje","ALF_Pancarte_Incompetants",
			"ALF_Pancarte_NikLaGN","ALF_Pancarte_Banque","ALF_Pancarte_Climat","ALF_Pancarte_Corruption","ALF_Pancarte_Impots","ALF_Pancarte_Vener",
			"ALF_sifflet","ALF_Batte","ALF_Hache","ALF_Faux","ALF_Camera","ALF_Flash_Light"
		]);

		if (_est_armer AND {_a_Bonne_Arme}) then
		{
			private _texte = "Braquage de supérette";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				[cursorObject] spawn ALF_fnc_braquageStation;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];		
		};
	};	

	if (tolowerANSI "MRPV2_PNJ_Ikea" in _objCurseur) exitwith
	{
		private _texte = "Magasin Ikea";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			[cursorobject,player,"Magasin Ikea","ikea"] call ALF_fnc_weaponShopMenu;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];

		private _texte = "Revendeur de planche";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			[nil,nil,nil,"vente_planche"] call ALF_fnc_itemsVenteMenu;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};

	if (tolowerANSI "MRPV2_PNJ_Orange" in _objCurseur) exitwith
	{
		private _texte = "Forfait";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			["Orange","Connexion avec le service client d'Orange.","warning", false] spawn ALF_fnc_doMsg;
			[] call ALF_fnc_menuForfait;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];

		private _texte = "Magasin";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			[nil,nil,nil,"orange"] call ALF_fnc_weaponShopMenu;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};

  // PNJ France Travail
  // Variable éditeur : MRPV2_PNJ_France_Travail (ou MRPV2_PNJ_Emploi_France_Travail)
  if (toLowerANSI "MRPV2_PNJ_France_Travail" in _objCurseur || {toLowerANSI "MRPV2_PNJ_Emploi_France_Travail" in _objCurseur}) exitwith
  {
    if (isNil "license_eboueur" || {!license_eboueur}) then {
      private _texteEboueur = "Acheter la licence Eboueur";
      private _texte_tooltypeEboueur = "";
      private _actionEboueur = { closeDialog 0; [] spawn ALF_fnc_buyEboueurLicense; };
      _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
      _liste_Sous_Actions pushback [_texteEboueur,_texte_tooltypeEboueur,_actionEboueur];
      _liste_Actions set ["",_liste_Sous_Actions];
    };

    if (isNil "license_ambulancier" || {!license_ambulancier}) then {
      private _texteAmbu = "Acheter la licence Ambulancier";
      private _texte_tooltypeAmbu = "";
      private _actionAmbu = { closeDialog 0; [] spawn ALF_fnc_buyAmbulancierLicense; };
      _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
      _liste_Sous_Actions pushback [_texteAmbu,_texte_tooltypeAmbu,_actionAmbu];
      _liste_Actions set ["",_liste_Sous_Actions];
    };

    if (isNil "license_enedis" || {!license_enedis}) then {
      private _texteEnedis = "Acheter la licence Enedis";
      private _texte_tooltypeEnedis = "";
      private _actionEnedis = { closeDialog 0; [] spawn ALF_fnc_buyEnedisLicense; };
      _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
      _liste_Sous_Actions pushback [_texteEnedis,_texte_tooltypeEnedis,_actionEnedis];
      _liste_Actions set ["",_liste_Sous_Actions];
    };

    if (isNil "license_taxi" || {!license_taxi}) then {
      private _texteTaxi = "Acheter la licence Taxi";
      private _texte_tooltypeTaxi = "";
      private _actionTaxi = { closeDialog 0; [] spawn ALF_fnc_buyTaxiLicense; };
      _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
      _liste_Sous_Actions pushback [_texteTaxi,_texte_tooltypeTaxi,_actionTaxi];
      _liste_Actions set ["",_liste_Sous_Actions];
    };

    if (isNil "license_busjob" || {!license_busjob}) then {
      private _texteBus = "Acheter la licence Chauffeur de Bus";
      private _texte_tooltypeBus = "";
      private _actionBus = { closeDialog 0; [] spawn ALF_fnc_buyBusjobLicense; };
      _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
      _liste_Sous_Actions pushback [_texteBus,_texte_tooltypeBus,_actionBus];
      _liste_Actions set ["",_liste_Sous_Actions];
    };
  };
  // // ********* Tabac *********
  // // Sechage de tabac
  // if (tolowerANSI "Sechage_tabac" in _objCurseur) exitwith
	// {
	// 	private _texte = "Sechage du tabac";
	// 	private _texte_tooltype = "";
	// 	private _action = 
	// 	{
  //     closeDialog 2;
	// 		[player,[["ALF_Tabac",1]],[["ALF_Tabac_Seche",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
	// 	};

	// 	_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
	// 	_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
	// 	_liste_Actions set ["",_liste_Sous_Actions];
	// };

  // // ********* Confection cigarettes *********
  // if (tolowerANSI "Confection_tabac" in _objCurseur) exitwith
	// {
		
	// 	private _texte = "Confection de cigarettes";
	// 	private _texte_tooltype = "";
	// 	private _action = 
	// 	{
  //     closeDialog 2;
	// 		[player,[["ALF_Tabac_Seche",5]],[["murshun_cigs_cig0",1]],10] spawn MRPV2_fnc_Traitement_Artisanat;
	// 	};

	// 	_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
	// 	_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
	// 	_liste_Actions set ["",_liste_Sous_Actions];
	// };

};

_liste_Actions
// };
// }] remoteExec ['call',0,true];