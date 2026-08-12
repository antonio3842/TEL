// ALF_Server_fnc_updateStation = {
params [
	["_litre", -1],
	["_station", objNull],
	["_joueur", objNull],
	["_pos_Station", [0,0,0]]
];

if (_litre isEqualTo -1) exitWith {};

if (isnull _station) then {_station = nearestObject [_pos_Station, "plp_up_PropaneTankA"];};

// NorX Aengell : Code rajouté pour detecter la citerne la plus proche et ses infos, a voir plus tard si moyen de mieux faire
private _pos_Citerne = getPosATL _station;  
private _id_Citerne = 0;  
private _litre_Citerne = 0;  

private _donnees_Citerne = ["SELECT id,pos,litre FROM station", 2, true] call ALF_Server_fnc_asyncCall;
private _citerne_BDD_Proche = _donnees_Citerne select {_pos_Citerne distance (parseSimpleArray (_x # 1)) < 100};

if (_citerne_BDD_Proche isEqualTo []) then 
{
	[_station,_joueur] call MRPV2_Server_fnc_Littrage_Creation_Citerne_BDD;
	_donnees_Citerne = ["SELECT id,pos,litre FROM station", 2, true] call ALF_Server_fnc_asyncCall;    
};

{
	private _pos_BDD = parseSimpleArray (_x # 1);  

	if ((_pos_BDD distance2D _pos_Citerne) < 50) exitWith  
	{
		_id_Citerne = _x # 0;
		_litre_Citerne = _x # 2;
	};  
} forEach _donnees_Citerne;

private _litreUpdate = round (_litre_Citerne + _litre) max 0 min 3000;

[format["UPDATE station SET litre='%1' WHERE id='%2'",_litreUpdate,_id_Citerne],1] call ALF_Server_fnc_asyncCall;
// };