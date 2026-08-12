// ALF_Server_fnc_queryRequest = {
params [
["_uid","",[""]],
["_ownerID",objNull,[objNull]]
];
if(_uid isEqualTo "" || {isNull _ownerID}) exitWith {};

diag_log format ["uid tell : %1",_uid];

private _q1 = format["SELECT playerid, name, cash, adminlevel, isPremium, coplevel, mediclevel, licenses, gear, stats, alive, position, firstspawn, playtime, adn, face, permis, axa, axabank, axacount, permis_time, duredon, publique, xp, axaprocount, bracelet, bracelettime, jail, jailtime, jailcoffre, penit, isValidate, groupeSanguin, medical, job_time, ordonnance_time, ordonnance_medoc FROM players WHERE playerid='%1'",_uid];
private _data = [_q1,2] call ALF_Server_fnc_asyncCall;

diag_log str(_data);
if(_data isEqualType "" OR {_data isEqualTo []}) exitWith {[] remoteExecCall ["SOCK_fnc_noBDD",_ownerID];};
diag_log "uid tell3";

[format["UPDATE players SET lastPlayed='0' WHERE playerid='%1'",_uid],1] call ALF_Server_fnc_asyncCall;

_data set[2,([_data # 2] call ALF_Server_fnc_numberSafe)];
_data set[3,([_data # 3] call ALF_Server_fnc_numberSafe)];
_data set[4,([_data # 4,1] call ALF_Server_fnc_bool)];
_data set[5,([_data # 5] call ALF_Server_fnc_numberSafe)];
_data set[6,([_data # 6] call ALF_Server_fnc_numberSafe)];

private _new = [(_data # 7)] call ALF_Server_fnc_mresToArray;
if(_new isEqualType "") then {_new = call compile format["%1", _new];};
_data set[7,_new];

_old = _data # 7;
for "_i" from 0 to (count _old)-1 do 
{
	_conv = _old # _i;
	_old set[_i,[_conv # 0, ([_conv # 1,1] call ALF_Server_fnc_bool)]];
};

_data set[7,_old];

_data set[8,(_data # 8)];

_new = [(_data # 9)] call ALF_Server_fnc_mresToArray;
if(_new isEqualType "") then {_new = call compile format["%1", _new];};
_data set[9,_new];
if (count _new > 3) then {_ownerID setDamage (_new # 3);};

_data set[10,([_data # 10,1] call ALF_Server_fnc_bool)];

_new = [(_data # 11)] call ALF_Server_fnc_mresToArray;
if(_new isEqualType "") then {_new = call compile format["%1", _new];};
_data set[11,_new];

_data set[12,([_data # 12,1] call ALF_Server_fnc_bool)];
_data set[13,([_data # 13] call ALF_Server_fnc_numberSafe)];
_data set[14,([_data # 14] call ALF_Server_fnc_numberSafe)];
_data set[15,([_data # 15] call ALF_Server_fnc_numberSafe)];
_data set[16,([_data # 16] call ALF_Server_fnc_numberSafe)];
_data set[17,([_data # 17] call ALF_Server_fnc_numberSafe)];
_data set[18,([_data # 18] call ALF_Server_fnc_numberSafe)];
_data set[19,([_data # 19] call ALF_Server_fnc_numberSafe)];
_data set[20,([_data # 20] call ALF_Server_fnc_numberSafe)];
_data set[21,([_data # 21] call ALF_Server_fnc_numberSafe)];
_data set[22,([_data # 22] call ALF_Server_fnc_numberSafe)];

_new = [(_data # 23)] call ALF_Server_fnc_mresToArray;
if(_new isEqualType "") then {_new = call compile format["%1", _new];};
_data set[23,_new];

_data set[24,([_data # 24] call ALF_Server_fnc_numberSafe)];
_data set[25,([_data # 25,1] call ALF_Server_fnc_bool)];
_data set[26,([_data # 26] call ALF_Server_fnc_numberSafe)];
_data set[27,([_data # 27,1] call ALF_Server_fnc_bool)];
_data set[28,([_data # 28] call ALF_Server_fnc_numberSafe)];
_data set[29,([_data # 29] call ALF_Server_fnc_numberSafe)];
_data set[30,([_data # 30] call ALF_Server_fnc_numberSafe)];

_new = [(_data # 33)] call ALF_Server_fnc_mresToArray;
if(_new isEqualType "") then {_new = call compile format["%1", _new];};
_data set[33,_new];

_data set[34,([_data # 34] call ALF_Server_fnc_numberSafe)];
_data set[35,([_data # 35] call ALF_Server_fnc_numberSafe)];
_data set[36,([_data # 36] call ALF_Server_fnc_numberSafe)];

private _q2 = format ["SELECT number, contacts, time FROM phone WHERE playerid='%1'",_uid];
private _qr2 = [_q2,2] call ALF_Server_fnc_asyncCall;
diag_log str(_qr2);
if(count _qr2 > 0) then {
_conv = [(_qr2 # 1)] call ALF_Server_fnc_mresToArray;
if(_conv isEqualType "") then {_conv = call compile format["%1", _conv];};
_data pushback ([([_qr2 # 2] call ALF_Server_fnc_numberSafe),(_qr2 # 0),_conv]);
_ownerID setVariable ["phoneNumber",(_qr2 # 0),true];
} else 
{
	_data pushback [];
};


_q3 = format ["SELECT numacc, livreta, laactive, livretb, lbactive, livretc, lcactive, activecb FROM bank WHERE playerid='%1'",_uid];
_qr3 = [_q3,2] call ALF_Server_fnc_asyncCall;
diag_log str(_qr3);
if(count _qr3 > 0) then {
_qr3 set[1,([_qr3 # 1] call ALF_Server_fnc_numberSafe)];
_qr3 set[2,([_qr3 # 2,1] call ALF_Server_fnc_bool)];
_qr3 set[3,([_qr3 # 3] call ALF_Server_fnc_numberSafe)];
_qr3 set[4,([_qr3 # 4,1] call ALF_Server_fnc_bool)];
_qr3 set[5,([_qr3 # 5] call ALF_Server_fnc_numberSafe)];
_qr3 set[6,([_qr3 # 6,1] call ALF_Server_fnc_bool)];
_qr3 set[7,([_qr3 # 7] call ALF_Server_fnc_numberSafe)];
_data pushback _qr3;
} else 
{
	_data pushback [];
};

_q5 = format["SELECT secteur, siret, membres, tel FROM business WHERE active='1' AND membres LIKE '%2%1%2'",_uid,"%"];
_qr5 = [_q5,2] call ALF_Server_fnc_asyncCall;
if (count _qr5 > 0) then 
{
	private _new = [(_qr5 # 2)] call ALF_Server_fnc_mresToArray;
	if(_new isEqualType "") then {_new = call compile format["%1", _new];};
	if (isNil "_new" || {!(_new isEqualType [])}) then {
		diag_log format["[ERREUR] fn_queryRequest: membres business corrompus pour uid=%1, siret=%2 - input: %3", _uid, _qr5 # 1, _qr5 # 2];
		_new = [];
	};
	_qr5 set[2,_new];
	_data pushback _qr5;
} else 
{
	_data pushback [];
};

_data pushBack ([_uid] call ALF_Server_fnc_fetchKeys);
_data pushBack ([_qr5,_data # 5,_data # 6] call ALF_Server_fnc_fetchMarkers);

diag_log "uid tell4";
diag_log format["%1",_ownerID];
if !(isNull _ownerID) then {[_data] remoteExec ["SOCK_fnc_requestReceived",_ownerID];};
// };