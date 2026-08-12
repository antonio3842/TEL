/*
	File: fn_soin.sqf
	Author: ALF Adam
*/

if (damage player isEqualTo 0) exitWith {["ACCEUIL", "Vous n'êtes pas blessé.", "danger"] spawn ALF_fnc_doMsg;};

private _SP_En_Service = ((groups civilian) select {groupId _x isEqualto "SP"}) isnotequalto [];
if (_SP_En_Service) then 
{
	["ACCEUIL", "Veuillez contacter les services de secours au numéro suivant : 18.", "danger"] spawn ALF_fnc_doMsg;
} else 
{
	["ACCEUIL", "Merci de patienter quelques secondes.", "danger"] spawn ALF_fnc_doMsg;

	uiSleep 5;
	
	private _pos = getPos player;
	if (_pos distance player > 3) exitWith {["ACCEUIL", "Vous avez bougé, donc les soins n'ont pas été appliqués.", "danger"] spawn ALF_fnc_doMsg;};
	
	player setDamage 0;

	titleText ["Vous êtes soigné", "PLAIN"]; [] spawn {sleep 5;titleText ["", "PLAIN"];};
	["ACCEUIL", "Faites attention à vous et bonne journée.", "info"] spawn ALF_fnc_doMsg;
};