private _permission_Joueur = param [0,""];


private _type_Appli = "";

if (_permission_Joueur isequalto "GN") then
{
	_type_Appli = "PCStorm";
};

if (_permission_Joueur isequalto "SP") then
{
	_type_Appli = "CODIS";
};

if (_permission_Joueur isequalto "AP") then
{
	_type_Appli = "DSPOM";
};

_type_Appli