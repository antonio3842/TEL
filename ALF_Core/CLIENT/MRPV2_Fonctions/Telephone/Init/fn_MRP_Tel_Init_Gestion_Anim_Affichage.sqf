// MRPV2_fnc_MRP_Tel_Init_Gestion_Anim_Affichage = {
if ("reload" in gestureState player) exitwith {};
if !(isnull objectparent player) exitwith {};


private _joueur_Pas_En_Anime = (count ((gestureState player splitstring "_") select {count _x > 20})) < 2;
if (_joueur_Pas_En_Anime AND {!isnil {MRP_Telephone} AND {!isObjectHidden player}}) then
{
	// Gestion affichage téléphone entre 1ere et 3eme personne
	if (tolower cameraView isequalto "internal" AND {!isobjecthidden MRP_Telephone }) exitwith
	{
		MRP_Telephone hideobject true;
	};

	if (tolower cameraView isequalto "external" AND {isobjecthidden MRP_Telephone AND {isObjectHidden player}}) then
	{
		MRP_Telephone hideobject false;
	};
};

private _joueur_Sans_Telephone = isnil {MRP_Telephone};

private _MRP_Appel_Etat = player getvariable ["MRP_Appel_Etat",""];
private _appel_En_Cours = _MRP_Appel_Etat in ["Appel en cours","Tentative appel expéditeur","Appel CA en cours"];
if (_appel_En_Cours) exitwith
{
	if !(isnil {MRP_Telephone_Anim_En_Cours}) exitwith {};

	if (_joueur_Sans_Telephone) then
	{
		[] call MRPV2_fnc_MRP_Tel_Init_Crea_Et_AttachTo;
	} else
	{
		private _joueur_Pas_En_Anime = (count ((gestureState player splitstring "_") select {count _x > 20})) < 2;

		if (_joueur_Pas_En_Anime) exitwith
		{
			private _joueur_Pas_Tel_A_Oreille = gestureState player isNotEqualTo "mrp_telephone_a_oreille_gauche";
			if (_joueur_Pas_Tel_A_Oreille) then
			{
				MRP_Telephone_Anim_En_Cours = true;

				[{
					player playActionNow "mrp_telephone_a_oreille_gauche";
					// [player,"mrp_telephone_a_oreille_gauche"] remoteexec ["playActionNow",0];

					[{
						tolower (gestureState player) isequalto "mrp_telephone_a_oreille_gauche"
					},
					{
						MRP_Telephone_Anim_En_Cours = nil;
					},[],10,{}] call CBA_fnc_waitUntilAndExecute;
				},[],0.5] call CBA_fnc_waitAndExecute;
			};
		};
	};
};

private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
private _tel_Fermer = isnull _Telephone_Base;
if (_tel_Fermer) then
{
	if (gestureState player in tolower str ["mrp_telephone_a_oreille_gauche","MRP_Telephone_En_Main_Gauche"]) then
	{
		player playActionNow "gestureNod";
		[{player playActionNow "gestureNod";}] call CBA_fnc_execNextFrame;
	};

	if !(isnil {MRP_Telephone}) then
	{
		deleteVehicle MRP_Telephone;
		MRP_Telephone = nil;
	};

	if !(isnil {MRP_Telephone_Anim_En_Cours}) then {MRP_Telephone_Anim_En_Cours = nil;};
} else
{
	// joueur na pas d'objet telephone en main et est non armé on lui crée le tel
	if (_joueur_Sans_Telephone) exitwith
	{
		[] call MRPV2_fnc_MRP_Tel_Init_Crea_Et_AttachTo;
	};

	if (!_joueur_Sans_Telephone) then
	{
		if (gestureState player isnotEqualTo "mrp_telephone_en_main_gauche") then
		{
			player playActionNow "MRP_Telephone_En_Main_Gauche";
			[{player playActionNow "MRP_Telephone_En_Main_Gauche";}] call CBA_fnc_execNextFrame;
		};
	}
};

TRUE
// };