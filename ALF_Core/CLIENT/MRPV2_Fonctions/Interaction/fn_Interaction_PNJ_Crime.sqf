// MRPV2_fnc_Interaction_PNJ_Crime = {
private _objCurseur = toLowerANSI str cursorObject;
private _liste_Actions = createhashmap;

[] call 
{
	if (toLowerANSI "MRPV2_PNJ_CRIME_DEALER" in _objCurseur) exitwith
	{	
		private _GN_En_Service = (((groups civilian) select {groupId _x isEqualto "Gendarmerie"}) # 0);

		if (!isnil {_GN_En_Service} AND {count (units _GN_En_Service) < 3 AND {life_gendarme_service}}) exitwith {closeDialog 2;["Mec suspect", "J'ai rien à te dire mec !", "danger", false] spawn alf_fnc_doMsg;};
		if (isnil {_GN_En_Service} OR {count (units _GN_En_Service) < 3}) exitwith {closeDialog 2;["Dealer", "Désolé, j’ai encore trop de stock à écouler, je ne prévois pas de rachat pour le moment !", "danger", false] spawn alf_fnc_doMsg;};

		if (life_gendarme_service) then 
		{
			private _texte = "Questionner";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 2;
				private _dealer = cursorObject;
				if (isNull _dealer) exitWith {
					systemChat "❌ Aucun dealer ciblé";
				};
				uiNamespace setVariable ["current_dealer", _dealer];

				[] spawn ALF_fnc_copQuestionDealer;
			};

			
			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];
		};
		
		private _texte = "Vente de drogue";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			//private _heure_Serveur = systemTime # 3;
			//if ((_heure_Serveur < 21) AND {_heure_Serveur >= 0}) exitwith 
			//{
			//	["Dealer", "Vous avez l'impression qu'on vous observe, vaut mieux remettre ca à dans la soirée", "warning", false] spawn alf_fnc_doMsg;
			//};
			
			[nil,nil,nil,"vente_drogues"] call ALF_fnc_itemsVentedealer;

			if (random(100) < 45) then {
			private _ville_Proche = "Zone inconnue";
			private _locs = nearestLocations [position player, ["NameLocal","NameVillage","NameCity","NameCityCapital"], 1000];
			if (count _locs > 0) then {_ville_Proche = text (_locs # 0);};
			["Crime", format["Une personne vient d'effectuer une transaction illégale dans une zone près de %1.", _ville_Proche]] remoteExecCall ["ALF_Server_fnc_doCopCallWL", 2];
			};
		};
		

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];

		private _texte = "Vente illégale";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			//private _heure_Serveur = systemTime # 3;
			//if ((_heure_Serveur < 21) AND {_heure_Serveur >= 0}) exitwith 
			//{
			//	["Dealer", "Vous avez l'impression qu'on vous observe, vaut mieux remettre ca à dans la soirée", "warning", false] spawn alf_fnc_doMsg;
			//};
			
			[nil,nil,nil,"vdealer"] call ALF_fnc_weaponShopMenu;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];

		private _texte = "Gofast";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			call ALF_fnc_gofastGerant;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};

	if (toLowerANSI "MRPV2_PNJ_CRIME_BRICO" in _objCurseur) exitwith
	{	
		private _GN_En_Service = (((groups civilian) select {groupId _x isEqualto "Gendarmerie"}) # 0);

		if (!isnil {_GN_En_Service} AND {count (units _GN_En_Service) < 0 AND {life_gendarme_service}}) exitwith {closeDialog 2;["Mec suspect", "J'ai rien a te dire mec !", "danger", false] spawn alf_fnc_doMsg;};
		if (isnil {_GN_En_Service} OR {count (units _GN_En_Service) < 0}) exitwith {closeDialog 2;["Dealer", "C'est trop risqué en ce moment mec !", "danger", false] spawn alf_fnc_doMsg;};

		if (life_gendarme_service) then 
		{
			private _texte = "Questionner";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				[nil,nil,nil,"vente_drogues"] call ALF_fnc_itemsVenteMenu;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];		
		};

		private _texte = "Changer ma plaque";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			[] call ALF_fnc_changerPlaque;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];		
	};

	if (toLowerANSI "MRPV2_PNJ_CRIME_CAGOULE" in _objCurseur) exitwith
	{	
		private _GN_En_Service = (((groups civilian) select {groupId _x isEqualto "Gendarmerie"}) # 0);


		private _texte = "Magasin de cagoule";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			[nil, nil, nil, "guetteur"] spawn ALF_fnc_clothingMenu;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};

	if (toLowerANSI "MRPV2_PNJ_CRIME_VENDEUR" in _objCurseur) exitwith
	{	
		private _GN_En_Service = (((groups civilian) select {groupId _x isEqualto "Gendarmerie"}) # 0);


		private _texte = "Magasin Illégal";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			[nil, nil, nil, "blackmarket"] spawn ALF_fnc_weaponShopMenu;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};

	if (toLowerANSI "MRPV2_Shop_Criminel" in _objCurseur) exitwith
	{	
		private _GN_En_Service = (((groups civilian) select {groupId _x isEqualto "Gendarmerie"}) # 0);


		private _texte = "Magasin Criminel";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			[nil, nil, nil, "mag_criminel"] spawn ALF_fnc_weaponShopMenu;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};

	if (toLowerANSI "MRPV2_PNJ_CRIME_RECELEUR" in _objCurseur) exitwith
	{	
		private _GN_En_Service = (((groups civilian) select {groupId _x isEqualto "Gendarmerie"}) # 0);

		if (!isnil {_GN_En_Service} AND {count (units _GN_En_Service) <= 6 AND {life_gendarme_service}}) exitwith {closeDialog 2;["Mec suspect", "J'ai besoin de rien pour le moment gros !", "danger", false] spawn alf_fnc_doMsg;};
		if (isnil {_GN_En_Service} OR {count (units _GN_En_Service) <= 6}) exitwith {closeDialog 2;["Receleur", "Désolé, j'ai plus de place dans mon hangar pour des véhicules supplémentaires !", "danger", false] spawn alf_fnc_doMsg;};
		
		private _texte = "Receleur de véhicule";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;	
			[] call ALF_fnc_receleurGetVehicle;
		};
		

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];

		
		private _texte = "Donner le véhicule";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;	
			[] call ALF_fnc_receleurPutVehicle;
		};
			

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};
};

_liste_Actions
// };


/*
//MRPV2_fnc_Interaction_PNJ_Crime = {
private _objCurseur = toLowerANSI str cursorObject;
private _liste_Actions = createhashmap;

[] call 
{
	if (toLowerANSI "MRPV2_PNJ_CRIME_DEALER" in _objCurseur) exitwith
	{	
		if (life_gendarme_service) then 
		{
			private _texte = "Questionner";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 2;
				[] spawn ALF_fnc_copQuestionDealer;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];
		};
		
		private _texte = "Vente de drogue";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			[nil,nil,nil,"vente_drogues"] call ALF_fnc_itemsVentedealer;

			private _ville_Proche = "Zone inconnue";
			private _locs = nearestLocations [position player, ["NameLocal","NameVillage","NameCity","NameCityCapital"], 1000];
			if (count _locs > 0) then {_ville_Proche = text (_locs # 0);};
			["Crime", format["Une personne vient d'effectuer une transaction illégale dans une zone près de %1.", _ville_Proche]] remoteExecCall ["ALF_Server_fnc_doCopCall", 2];
		};
		

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];

		private _texte = "Vente illégale";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			[nil,nil,nil,"vdealer"] call ALF_fnc_weaponShopMenu;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};

	if (toLowerANSI "MRPV2_PNJ_CRIME_BRICO" in _objCurseur) exitwith
	{	
		private _GN_En_Service = (((groups civilian) select {groupId _x isEqualto "Gendarmerie"}) # 0);

		if (!isnil {_GN_En_Service} AND {count (units _GN_En_Service) <= 3 AND {life_gendarme_service}}) exitwith {closeDialog 2;["Mec suspect", "J'ai rien a te dire mec !", "danger", false] spawn alf_fnc_doMsg;};
		if (isnil {_GN_En_Service} OR {count (units _GN_En_Service) <= 3}) exitwith {closeDialog 2;["Dealer", "C'est trop risqué en ce moment mec !", "danger", false] spawn alf_fnc_doMsg;};

		if (life_gendarme_service) then 
		{
			private _texte = "Questionner";
			private _texte_tooltype = "";
			private _action = 
			{closeDialog 0;
				[nil,nil,nil,"vente_drogues"] call ALF_fnc_itemsVenteMenu;
			};

			_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
			_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
			_liste_Actions set ["",_liste_Sous_Actions];		
		};

		private _texte = "Changer ma plaque";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			[] call ALF_fnc_changerPlaque;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];		
	};

	if (toLowerANSI "MRPV2_PNJ_CRIME_CAGOULE" in _objCurseur) exitwith
	{	
		private _GN_En_Service = (((groups civilian) select {groupId _x isEqualto "Gendarmerie"}) # 0);


		private _texte = "Magasin de cagoule";
		private _texte_tooltype = "";
		private _action = 
		{closeDialog 0;
			[nil, nil, nil, "guetteur"] spawn ALF_fnc_clothingMenu;
		};

		_liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
		_liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
		_liste_Actions set ["",_liste_Sous_Actions];
	};
};

_liste_Actions
//};
*/
