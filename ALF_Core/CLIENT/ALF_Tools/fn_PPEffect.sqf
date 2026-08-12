/*
    GET YOUR PATH
    Code written by Association law 1901 "GET YOUR PATH" (RNA W252007073)
    Statement from the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403
    @Copyright GET YOUR PATH (https://www.getyourpath.fr)
    YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
    More informations : https://www.bistudio.com/community/game-content-usage-rules
    Contact : kainnon@getyourpath.fr
*/
private _effect = param [0, "DynamicBlur"];
private _value = param [1, []];
private _priority = switch (_effect) do {
	case ("DynamicBlur"): {
		400;
	};
	case ("FilmGrain"): {
		2000;
	};
	default{
		400
	};
};
while {
	_effect = ppEffectCreate ["DynamicBlur", _priority];
	_effect < 0
} do {
	_priority = _priority + 1;
};
_effect ppEffectEnable true;
_effect ppEffectAdjust _value;
_effect ppEffectCommit 0;
_effect;