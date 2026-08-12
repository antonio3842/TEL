// ALF_fnc_buyForfait = {
private _tel = param [0,-1];
private _mode = param [1,-1];
if(_tel isEqualTo -1 OR {_mode isEqualTo -1}) exitWith {};

private _uid = getPlayerUID player;
private _price = 0;
private _offre = "";

switch (_tel) do 
{
	case 1 : 
	{
		switch (_mode) do 
		{
			case 1 : {_price = 50;};
			case 2 : {_price = 125;};
			case 3 : {_price = 320;};
			case 4 : {_price = 700;};
		};

		private _exit = false;
		
	if (_price > life_cash) then
		{
			private _handle = [_price,false] call ALF_fnc_handleCB;
			if (!_handle) then {
				[_uid,_mode,player] remoteExecCall ["ALF_Server_fnc_buyForfait",2];
			} else {
				_exit = true;
			};
		} else
		{
			private _action = [format["Voulez-vous acheter cette offre pour %1€. La somme sera prélevé en liquide.",_price],"Orange","OUI","NON"] call BIS_fnc_guiMessage;
			if (!_action) exitWith {};

			if (life_cash >= _price) then 
			{
				life_cash = life_cash - _price;
				[_uid,_mode,player] remoteExec ["ALF_Server_fnc_buyForfait",2];
			} else 
			{
				["Orange", "Vous n'avez pas assez de liquide.", "danger", false] spawn ALF_fnc_doMsg;
			};			
		};

		if (_exit) exitWith {["Orange", "Vous n'avez pas les fonds pour un forfait.", "danger", false] spawn ALF_fnc_doMsg;};			
	};
	case 2 : 
	{
		if !(life_donor) exitWith {["Orange", "Cette option n'est disponible que pour les membres donateurs.", "danger", false] spawn ALF_fnc_doMsg;};
		private _action = ["Voulez-vous résilier votre forfait? Votre numéro et vos contacts seront définitivement effacés.","Orange","OUI","NON"] call BIS_fnc_guiMessage;
		if (!_action) exitWith {};

		if (life_cash >= 999) then 
		{
			life_cash = life_cash - 999;
			ALF_Forfait = -1;
			[_uid,player] remoteExec ["ALF_Server_fnc_removeForfait",2];
		} else 
		{
			["Orange", "Vous n'avez pas assez de liquide.", "danger", false] spawn ALF_fnc_doMsg;
		};
	};
};
// };
