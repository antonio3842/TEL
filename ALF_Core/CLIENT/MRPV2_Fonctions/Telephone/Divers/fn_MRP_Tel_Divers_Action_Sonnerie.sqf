// MRPV2_fnc_MRP_Tel_Divers_Action_Sonnerie = {
private _joueur = param [0,objNull];
private _heure_Depart = param [1,0];
private _numero_Speciale = param [2,""];


private _MRP_Appel_Etat = player getvariable ["MRP_Appel_Etat",""];
if (_MRP_Appel_Etat isequalto "Arret tentative") exitwith {};

private _nombre_Tonaliter_Necessaire = 6;

// On decale de 0.3 seconde pour que la sonnerie ne se déclenche pas directement
if (isnil {MRP_Compteur_Tonaliter} AND {time > _heure_Depart + 0.3}) then {MRP_Compteur_Tonaliter = 0;};

private _temps_Pour_Tonalite = _heure_Depart + (MRP_Compteur_Tonaliter * 4);

if (time >= _temps_Pour_Tonalite) then
{
	MRP_Compteur_Tonaliter = MRP_Compteur_Tonaliter + 1;
	
	if (_MRP_Appel_Etat isequalto "Tentative appel destinataire") then {_nombre_Tonaliter_Necessaire = 5;};

	if (MRP_Compteur_Tonaliter isnotEqualTo _nombre_Tonaliter_Necessaire) then
	{
		if (_MRP_Appel_Etat isequalto "Tentative appel expéditeur") exitwith
		{
			// Apres deux sonnerie on passe au script de recherche du joueur appelé
			if (MRP_Compteur_Tonaliter isEqualTo 2) then {[] call MRPV2_fnc_MRP_Tel_Menu_Appel_Tentative_Expediteur;};

			playSound ["MRP_Telephone_Tonalite_Appel",2,0.1];
		};

		if (_MRP_Appel_Etat isequalto "Tentative appel destinataire") then
		{
			private _telephone_Configuration =  profileNamespace getvariable ["MRP_Telephone_Configuration",[]];
			private _mode_Silencieux = _telephone_Configuration # 1;
			private _sonnerie = _telephone_Configuration # 4;

			if !(_mode_Silencieux) then
			{
				if (isnil {MRP_Telephone_Source_Son}) then {[player] call MRPV2_fnc_MRP_Tel_Divers_Crea_Son;};

				if !(isnil {MRP_Telephone_Source_Son}) then
				{
					[MRP_Telephone_Source_Son,"MRP_Telephone_Sonnerie_" + _sonnerie] remoteExec ["ALF_fnc_say3D",playableUnits];
				};
			};

			playsound "MRP_Telephone_Son_Vibreur";
		};
	};
};

private _compteur_Tonaliter_Atteint_Max = MRP_Compteur_Tonaliter isEqualTo _nombre_Tonaliter_Necessaire;
if (_compteur_Tonaliter_Atteint_Max) then
{
	player setvariable ["MRP_Appel_Etat","Arret tentative"];

	// Si joueur atteint 6 sonnerie on sait que c'est l'expediteur (le destinataire ne va qu'a 5)
	if (MRP_Compteur_Tonaliter isequalto 6) then
	{
		[2] call MRPV2_fnc_MRP_Tel_Menu_Historique_Gestion_Histo;
		[] call MRPV2_fnc_MRP_Tel_Divers_Crea_Liste_Nombre_Appel;
	} else
	{
		[0] call MRPV2_fnc_MRP_Tel_Menu_Historique_Gestion_Histo;
	};
};

TRUE
// };