params [["_player",player]];

_myCompanySTR = "CIV";
if ((player getVariable ["isEmployed",""] isNotEqualTo "") && b_enService) then 
{
_myCompanySTR = "ENT";
};
if (life_gendarme_service) then 
{
_myCompanySTR = "GN";
};
if (life_pompier_service) then 
{
_myCompanySTR = "SP";
};
if (life_penit_service) then 
{
_myCompanySTR = "AP";
};


_myCompanySTR