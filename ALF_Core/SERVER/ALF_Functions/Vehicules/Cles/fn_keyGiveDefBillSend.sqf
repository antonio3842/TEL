/*
	File: fn_keyGiveDefBillSend.sqf
	Author: ALF Dev Team
	Description: Stocke temporairement les données de facture et envoie la notification au receveur
*/
params [
	["_receiverUID", "", [""]],
	["_vehicleID", "", [""]],
	["_senderID", "", [""]],
	["_vehicleIndex", -1, [0]],
	["_name", "", [""]],
	["_amount", 0, [0]]
];

diag_log format ["[DEBUG] fn_keyGiveDefBillSend - Réception: receiverUID=%1, vehicleID=%2, senderID=%3, amount=%4", _receiverUID, _vehicleID, _senderID, _amount];

// Trouver le joueur receveur
private _receiver = objNull;
{
	if (getPlayerUID _x isEqualTo _receiverUID) exitWith {
		_receiver = _x;
	};
} forEach allPlayers;

if (isNull _receiver) exitWith {
	diag_log format ["[DEBUG] fn_keyGiveDefBillSend - ERREUR: Receveur non trouvé pour UID %1", _receiverUID];
};

// Récupérer les objets à partir des netIds
private _vehicle = objectFromNetId _vehicleID;
private _sender = objectFromNetId _senderID;

if (isNull _vehicle || isNull _sender) exitWith {
	diag_log format ["[DEBUG] fn_keyGiveDefBillSend - ERREUR: Véhicule ou sender null - vehicle=%1, sender=%2", _vehicle, _sender];
};

// Envoyer la notification au receveur avec toutes les données nécessaires
[1, _amount, _vehicleID, _senderID, _vehicleIndex, _name] remoteExec ["ALF_fnc_keyGiveDefBill", _receiver];

diag_log format ["[DEBUG] fn_keyGiveDefBillSend - Notification envoyée au receveur %1", name _receiver];

