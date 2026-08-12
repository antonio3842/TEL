#include "\ALF_Client\script_macros.hpp"

/*
Spawn d'une barre de chargement puis delete de l'objet
*/

	private _upp = "Récupération de l'objet";
	life_action_inUse = true;
	
	//Setup our progress bar.
	disableSerialization;
	5 cutRsc ["life_progress","PLAIN"];
	private _ui = GVAR_UINS "life_progress";
	private _progress = _ui displayCtrl 38201;
	private _pgText = _ui displayCtrl 38202;
	_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
	_progress progressSetPosition 0.01;
	private _cP = 0.01;
	for "_i" from 0 to 1 step 0 do {
		if(animationState player != "AinvPknlMstpSnonWnonDnon_medic_1") then {
			player switchMove "AinvPknlMstpSnonWnonDnon_medic_1";
			player playMoveNow "AinvPknlMstpSnonWnonDnon_medic_1";
		};
		sleep 0.2;
		_cP = _cP + 0.1;
		_progress progressSetPosition _cP;
		_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
		if(_cP >= 1) exitWith {};
		if(!alive player) exitWith {};
		if(player != vehicle player) exitWith {};
		if(life_interrupted) exitWith {};
	};
	life_action_inUse = false;
	5 cutText ["","PLAIN"];
	player playActionNow "stop";
	
	//Verification du bon procédé.
	if !(alive player) exitWith {};
	if (player != vehicle player) exitWith {};
	if (life_interrupted) exitWith {life_interrupted = false; titleText["Rammassage annulé.","PLAIN"];};
	deleteVehicle (missionNamespace getVariable ["MRP_dirObj_currentWreck", [objNull, false]]);
	missionNamespace setVariable ["MRP_dirObj_currentWreck", [objNull, false], true];
	private _nom_Marqueur = "DirObj_marker";
	private _targetPlayers = (allPlayers select { _x getVariable ['b_18', false] });
	_targetPlayers pushBackUnique player;
	[FALSE, _nom_Marqueur] remoteExec ['MRPV2_fnc_Marqueur_Gestion', _targetPlayers];
