/*
	File: fn_insureVehicles.sqf
	Author: ALF Team
*/
params[
	["_m",-1,[0]],
	["_vid",-1,[0]],
	["_pid","",[""]],
	["_unit",objNull,[objNull]]
];
if(_m isEqualTo -1 OR {_vid isEqualTo -1} OR {_pid isEqualTo ""} OR {isNull _unit}) exitWith {};

switch (_m) do {
	case 0 : {
		[format["UPDATE vehicles SET insure='0' WHERE pid='%1' AND id='%2'",_pid,_vid],1] call ALF_Server_fnc_asyncCall;
		["Assurance","Vous avez résilié l'assurance de votre véhicule.","success",false] remoteExec ["ALF_fnc_doMsg",_unit];
	};
	case 1 : {
		[format["UPDATE vehicles SET insure='1' WHERE pid='%1' AND id='%2'",_pid,_vid],1] call ALF_Server_fnc_asyncCall;
		["Assurance","Vous avez assuré votre véhicule, vous êtes en règle.","success",false] remoteExec ["ALF_fnc_doMsg",_unit];
	};
	case 2 : {
		[format["UPDATE vehicles SET insure='0' WHERE pid='%1' AND id='%2'",_pid,_vid],1] call ALF_Server_fnc_asyncCall;
		["Assurance","Vous avez résilié l'assurance pro de votre véhicule.","success",false] remoteExec ["ALF_fnc_doMsg",_unit];
	};
	case 3 : {
		[format["UPDATE vehicles SET insure='2' WHERE pid='%1' AND id='%2'",_pid,_vid],1] call ALF_Server_fnc_asyncCall;
		["Assurance","Vous avez assuré votre véhicule professionnel, vous êtes en règle.","success",false] remoteExec ["ALF_fnc_doMsg",_unit];
	};
	case 4 : {
		[format["UPDATE vehicles SET insure='3' WHERE id='%1'",_vid],1] call ALF_Server_fnc_asyncCall;
		["Assurance","Vous avez assuré votre véhicule d'entreprise, vous êtes en règle.","success",false] remoteExec ["ALF_fnc_doMsg",_unit];
	};
	case 5 : {
		[format["UPDATE vehicles SET insure='0' WHERE id='%1'",_vid],1] call ALF_Server_fnc_asyncCall;
		["Assurance","Vous avez résilié l'assurance de votre véhicule d'entreprise.","success",false] remoteExec ["ALF_fnc_doMsg",_unit];
	};
};
