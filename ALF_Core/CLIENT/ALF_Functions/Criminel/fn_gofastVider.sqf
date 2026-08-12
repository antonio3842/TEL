if ((lbCurSel 1000) isEqualTo -1) exitWith {
	["Gofast", "Veuillez choisir un véhicule à vider !", false] spawn alf_fnc_doMsg
};
_select = lbData[1000, lbCurSel 1000];
_vehicle = vehiclesrevendeur select (parseNumber _select);

closeDialog 0;
_isdeloading = _vehicle getVariable ["alf_gofast_isDeloading", false];
if (_isdeloading) exitWith {
	["Gofast", "Quelqu'un décharge déjà !"] spawn BIS_fnc_showSubtitle;
};
_vehicle setVariable ["alf_gofast_isDeloading", true, true];

5 cutRsc ["life_progress", "PLAIN"];
private _ui = uiNameSpace getVariable "life_progress";
private _progress = _ui displayCtrl 38201;
private _pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["Déchargement de la résine de cannabis du véhicule (1%1)...", "%"];
_progress progressSetPosition 0.01;
_time = time;
_prix = alf_gofast_prixfinal;
private _cP = 0.01;
private _quitter = false;

for "_i" from 0 to 1 step 0 do
{
	sleep (timetocharge/100);
	_cP = _cP + 0.01;
	_progress progressSetPosition _cP;
	_pgText ctrlSetText format["Déchargement de la résine de cannabis du véhicule (%1%2)...", round(_cP * 100), "%"];

	if (_cP >= 1) exitWith {};
	if !(alive player) exitWith {};
	if (life_interrupted) exitWith {};
	if (!isnull objectParent player) exitWith {};
	if ((player distance _vehicle) > 15) exitWith {_quitter=true};
};

5 cutText ["", "PLAIN"];

if (!alive player or {
	_quitter or {
		!isNull objectParent player or {
			life_interrupted
		}
	}
}) exitWith
{
	life_interrupted = false;
	titleText["Déchargement annulé.", "PLAIN"];
	_vehicle setVariable ["alf_gofast_isDeloading", false, true];
};

_item = "O2_Item_Weed_Bale";
_vehicle setVariable ["alf_gofast_isDeloading", false, true];
_objets = (magazineCargo (_vehicle));

_chargementitem = _item in _objets;


if (_chargementitem) then {
	_difference = _time - alf_gofast_time_started;

	if (_difference >= alf_gofast_time) then {
		["Gofast", format["Frérot t'a pris un peu de temps, j'suis obligé de te payer moins cher. Tiens, voilà tes %1€.", _prix]] spawn BIS_fnc_showSubtitle;
	} else {
		["Gofast", format["Putain t'as tracé comme un taré ! Voici tes %1€.", _prix]] spawn BIS_fnc_showSubtitle;
	};

	life_cash = life_cash + _prix;
	[0] spawn SOCK_fnc_updatePartial;
} else {
	["Gofast", "Mec, ya même pas ce que le dealer t'a donné, tu te fous de ma gueule ? allez bouge de là"] spawn BIS_fnc_showSubtitle;
};
_vehicle addMagazineCargo [_item, -1];
player setVariable ["alf_gofast_haveColis", false, true];
player removeSimpleTask alf_gofast_task;
(player getVariable["ALF_GoFastHouse", objNull]) setVariable ['Gofast_Colis','',true];
missionNamespace setVariable ["alf_gofast",objNull,true];