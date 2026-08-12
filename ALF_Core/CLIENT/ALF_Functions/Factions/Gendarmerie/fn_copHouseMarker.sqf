#include "\ALF_Client\script_macros.hpp"
/*
File: fn_copHouseMarker.sqf
Author: ALF Team
*/
params [
	["_house",objNull,[objNull]],
	["_uid","",[""]]
];
if (isNull _house) exitWith {};

// Vérifier si le joueur est propriétaire
private _playerUID = getPlayerUID player;
private _isOwner = (_uid isNotEqualTo "" && {_uid isEqualTo _playerUID});

// Vérifier si le joueur est b_6 (entreprise de sécurité)
// b_6 doit être défini ET être true
private _isB6 = false;
if (!(isNil "b_6")) then {
	_isB6 = b_6;
};

// Si _uid est vide, seul b_6 peut recevoir la notification
// Si _uid n'est pas vide, le propriétaire OU b_6 peuvent recevoir
if(!_isOwner && {!_isB6}) exitWith {};

// Afficher le message approprié
if(_isB6) then {
	["Intrusion Maison","L'alarme d'une maison vient de se déclencher. Un marker est disponible sur la carte.","warning"] spawn ALF_fnc_doMsg;
} else {
	["Intrusion Maison","L'alarme de votre maison vient de se déclencher. Un marker est disponible sur la carte.","warning"] spawn ALF_fnc_doMsg;
};

private _posHouse = getPos _house;
private _marker = createMarkerLocal [format ["house_braquage_%1",_posHouse],_posHouse];
_marker setMarkerTextLocal "Braquage en cours..";
_marker setMarkerColorLocal "ColorRed";
_marker setMarkerTypeLocal "loc_Lighthouse";

[_marker] spawn {
	_marker = _this select 0;
	sleep 300;
	deleteMarkerLocal _marker;	
};
