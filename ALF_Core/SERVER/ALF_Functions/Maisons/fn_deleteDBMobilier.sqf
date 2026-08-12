// ALF_Server_fnc_deleteDBmobilier = {
params [
	["_mobilier",objNull,[objNull]],
	["_house",objNull,[objNull]],
	["_uid","",[""]]
];
if (isNull _mobilier) exitWith {};

// Pour les appartements: si la maison reçue n'a pas de house_owner, chercher une maison proche appartenant au joueur
private _owner = (_house getVariable ["house_owner", []]);
private _business = (_house getVariable ["business", []]);
if (count _owner == 0 AND {count _business == 0}) then {
	private _nearHouses = nearestObjects [getPosATL _mobilier, ["House", "House_F"], 20];
	{
		private _houseOwner = _x getVariable ["house_owner", []];
		if (count _houseOwner > 0 AND {(_houseOwner # 0) isEqualTo _uid}) exitWith {
			_house = _x;
		};
	} forEach _nearHouses;
};

// Vérification propriétaire (même logique que addMobilier)
// Si _uid est vide, on skip le check (cas des cops qui peuvent détruire sans être propriétaire)
private _exit = false;
if (_uid isNotEqualTo "") then {
	if ((typeOf _house) in ["Land_ALF_Entreprise"]) then {
		private _ownerBiz = (_house getVariable ["business", [""]]) # 0;
		if (_uid isNotEqualTo _ownerBiz) then {
			private _ownerHouse = (_house getVariable ["house_owner", [""]]) # 0;
			if (_uid isNotEqualTo _ownerHouse) exitWith { _exit = true; };
		};
	} else {
		private _ownerHouse = (_house getVariable ["house_owner", [""]]) # 0;
		if (_uid isNotEqualTo _ownerHouse) exitWith { _exit = true; };
	};
};

if (_exit) exitWith {
	["ERREUR", "Vous n'êtes pas le propriétaire.", "danger"] remoteExec ["ALF_fnc_doMsg", remoteExecutedOwner];
};

private _mobilierID = (_mobilier getVariable ["mobilier_data",["",-1,"",objNull,"",false]]) select 1;

if (_mobilierID isEqualTo -1) exitWith {deleteVehicle _mobilier;};

private _query = format["DELETE FROM mobiliers WHERE id='%1'",_mobilierID];
[_query,1] call ALF_Server_fnc_asyncCall;

private _mobiliers = _house getVariable ["mobiliers",[]];

{
	if (_x isEqualTo _mobilier) then {_mobiliers deleteAt _forEachIndex;};
} forEach _mobiliers;
_house setVariable ["mobiliers",_mobiliers];

deleteVehicle _mobilier;
// };