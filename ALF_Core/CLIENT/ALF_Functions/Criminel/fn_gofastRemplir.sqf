if ((lbCurSel 1000) isEqualTo -1) exitWith {
	["Dealer", "Veuillez choisir un véhicule à remplir !", false] spawn alf_fnc_doMsg;
};
_select = lbData[1000,lbCurSel 1000];
_vehicle = vehiclesdealer select (parseNumber _select);

if !(isNull (missionNamespace getVariable ["alf_gofast",objNull])) exitWith {["Dealer", "Je bosse déjà avec quelqu'un là ! Attends un peu"] spawn BIS_fnc_showSubtitle;};

if ((missionNamespace getVariable ["alf_gofast",objNull]) isEqualTo player) exitWith {
	["Dealer", "Tu t'fou de ma gueule ? Je t'ai déjà donné une destination !"] spawn BIS_fnc_showSubtitle;
};

_item = "O2_Item_Weed_Bale";

if !(_vehicle canAdd _item) exitWith {
	["Dealer", "Wesh tu t'fou de ma gueule ? J'ai même pas la place de foutre la came dans la gova..."] spawn BIS_fnc_showSubtitle;
};

timetocharge = round (30 + random 30);
["Dealer", "J'suis en train de charger la came frérot, aide-moi au lieu de me regarder."] spawn BIS_fnc_showSubtitle;
["Crime", format["Un véhicule de type %1 serait en train de faire un gofast", getText(configFile >> "CfgVehicles" >> typeOf _vehicle>> "displayName")]] remoteExecCall ["ALF_Server_fnc_doCopCall", 2];
missionNamespace setVariable ["alf_gofast",player,true];

5 cutRsc ["life_progress","PLAIN"];
private _ui = uiNameSpace getVariable "life_progress";
private _progress = _ui displayCtrl 38201;
private _pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["Chargement de la résine de cannabis dans le véhicule (1%1)...","%"];
_progress progressSetPosition 0.01;


private _cP = 0.01;
private _quitter = false;

for "_i" from 0 to 1 step 0 do
{
	sleep (timetocharge/100);
	_cP = _cP + 0.01;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["Chargement de la résine de cannabis dans le véhicule (%1%2)...",round(_cP * 100),"%"];

	if (_cP >= 1) exitWith {};
	if !(alive player) exitWith {};
	if (life_interrupted) exitWith {};
	if (!isnull objectParent player) exitWith {};
	if ((player distance _vehicle) > 15) exitWith {_quitter=true};
};

5 cutText ["","PLAIN"];

if (!alive player OR {_quitter OR {!isnull objectParent player OR {life_interrupted}}}) exitWith 
{
	life_interrupted = false; 
	titleText["Chargement annulé.","PLAIN"];
	missionNamespace setVariable ["alf_gofast",objNull,true];
};

_dialogue = getText (missionConfigFile >> "gofast" >> "gofast_gerant" >> "loaded");
["Dealer", "J'ai fait de mon max pour caler le plus de résine."] spawn BIS_fnc_showSubtitle; 

_vehicle addMagazineCargoGlobal [_item, 1];
vehicletocharge = _vehicle;
[] spawn ALF_fnc_gofastAssignRevendeur;


missionNamespace setVariable ["alf_gofast_cooldown",time,true];