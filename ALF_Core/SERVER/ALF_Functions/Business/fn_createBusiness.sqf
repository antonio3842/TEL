// ALF_Server_fnc_createBusiness = {
private _uid = _this # 0;
private  _pos = _this # 1;
private _name = _this # 2;
private _secteur = _this # 3;
private _capital = _this # 4;
private _unit = _this # 5;
private _classname = _this # 6;

if (isNil "_uid" OR {isNil "_pos" OR {isNil "_name" OR {isNil "_secteur" OR {isNil "_capital"}}}}) exitWith {};

private _nom_Ent = [format["SELECT name FROM business WHERE owner='%1'",getPlayerUID _unit],2] call ALF_Server_fnc_asyncCall;

if (_nom_Ent isnotequalto []) exitwith {["Entreprise", "Vous avez déjà un projet d'entreprise ou possédez déjà une entreprise.", "warning"] remoteExec ["ALF_fnc_doMsg",_unit];};

private _siret = [100000,999999] call BIS_fnc_randomInt;
_siret = [_siret] call ALF_Server_fnc_numberSafe;
private _siretf = format["732%1",_siret];

private _count = ([format["SELECT COUNT(*) FROM business WHERE siret='%1'",_siretf],2] call ALF_Server_fnc_asyncCall) # 0;
while {_count > 0} do 
{
	_siret = [100000,999999] call BIS_fnc_randomInt;
	_siret = [_siret] call ALF_Server_fnc_numberSafe;
	_siretf = format["732%1",_siret];

	_count = ([format["SELECT COUNT(*) FROM business WHERE siret='%1'",_siretf],2] call ALF_Server_fnc_asyncCall) # 0;

	sleep 0.1
};

private _count = ([format["SELECT COUNT(*) FROM business WHERE pos='%1'",_pos],2] call ALF_Server_fnc_asyncCall) # 0;
if (_count > 0) exitWith {["Entreprise", "Un dossier pour ce bâtiment a déjà été déposé.", "warning"] remoteExec ["ALF_fnc_doMsg",_unit];};

private _membres = [[name _unit,_uid,4]];
_capital = [_capital] call ALF_Server_fnc_numberSafe;

[format["INSERT INTO business (owner, pos, name, siret, capital, secteur, membres, level, active,Type_Bat) VALUES ('%1','%2','%3','%4','%5','%6','%7','0','0','%8')",_uid,_pos,str _name,_siretf,_capital,_secteur,str _membres,_classname],1] call ALF_Server_fnc_asyncCall;
["Entreprise", "Le dossier a bien été envoyé.", "success"] remoteExec ["ALF_fnc_doMsg",_unit];
// };