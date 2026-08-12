// ALF_fnc_loadGear = {
private _liste_Equipement = param [0,[]]; 
diag_log format ["%1 : fn_loadGear pour %3 called with %2", time, _liste_Equipement,player];

player setUnitLoadout (configFile >> "EmptyLoadout");

player action ["SwitchWeapon", player, player, 0];
player playMoveNow "amovpercmstpsnonwnondnon";
player switchMove "amovpercmstpsnonwnondnon";

if (_liste_Equipement isEqualTo []) then 
{
	if (!isnil {License_Femme} AND {License_Femme}) then 
    {
        player forceaddUniform (selectRandom ["ALF_CHAW3_D6","EF_FEM_3_9_2K","EF_FEM_4_2SG2","EF_FEM_4_72ADR","EF_FEM_3_3OD"]);
    } else 
    {
        player forceaddUniform (selectRandom ["U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_stripped","U_C_Poloshirt_tricolour","U_C_Poloshirt_salmon","U_C_Poloshirt_redwhite","U_C_Commoner1_1"]);
    };

	[{uniform player isNotEqualTo ""},
	{
		player addMagazine "ALF_identite";
		player addMagazine "ALF_Permis";
		player linkItem "ItemMap";
	}] call CBA_fnc_waitUntilAndExecute;
} else 
{
	private _equipement_Joueur_Profile = profileNamespace getVariable ["MRPV2_Inventaire_Joueur_Profile",[]];
	if (_equipement_Joueur_Profile isNotEqualTo [] AND {_equipement_Joueur_Profile isEqualTo _liste_Equipement}) then 
	{
		player setUnitLoadout _equipement_Joueur_Profile;
	} else 
	{
		player setUnitLoadout _liste_Equipement;
	};	

	[_liste_Equipement] spawn 
	{params ["_liste_Equipement"];
		if (isSwitchingWeapon player) then 
		{
			waitUntil {!isSwitchingWeapon player};
		};

		player setUnitLoadout _liste_Equipement;

		sleep 0.3; 

		if (getUnitLoadout player isNotEqualTo _liste_Equipement) then {player setUnitLoadout _liste_Equipement;};
	};
};

LIFE_maxWeight = if (backpack player isEqualTo "") then 
{
	getNumber (missionConfigFile >> "Life_Settings" >> "total_maxWeight")
} else 
{
	getNumber (missionConfigFile >> "Life_Settings" >> "total_maxWeight") + round(getNumber(configFile >> "CfgVehicles" >> (backpack player) >> "maximumload") / 4)
};
// };