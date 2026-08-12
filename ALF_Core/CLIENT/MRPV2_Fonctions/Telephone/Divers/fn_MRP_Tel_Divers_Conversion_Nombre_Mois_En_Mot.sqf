private _mois = param [0,0];
private _mois_Entier = param [3,FALSE];


[] call
{
	if (_mois isEqualTo "01") exitwith {_mois = "jan."};
	if (_mois isEqualTo "02") exitwith {_mois = "fév."};
	if (_mois isEqualTo "03") exitwith {_mois = "mar."};
	if (_mois isEqualTo "04") exitwith {_mois = "avr."};
	if (_mois isEqualTo "05") exitwith {_mois = "mai"};
	if (_mois isEqualTo "06") exitwith {_mois = "juin"};
	if (_mois isEqualTo "07") exitwith {_mois = "juil."};
	if (_mois isEqualTo "08") exitwith {_mois = "aoû"};
	if (_mois isEqualTo "09") exitwith {_mois = "sep."};
	if (_mois isEqualTo "10") exitwith {_mois = "oct."};
	if (_mois isEqualTo "11") exitwith {_mois = "nov."};
	if (_mois isEqualTo "12") then {_mois = "déc."};
};

_mois