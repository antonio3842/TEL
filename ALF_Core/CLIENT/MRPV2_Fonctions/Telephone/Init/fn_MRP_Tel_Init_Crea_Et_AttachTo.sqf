// MRPV2_fnc_MRP_Tel_Init_Crea_Et_AttachTo = {
if !(isnil {MRP_Telephone}) exitwith {};
if !(isnull objectparent player) exitwith {};

if (isnil {MRP_Telephone}) then
{
	private _liste_tel = attachedObjects player select {"neogend" in tolower typeof _x OR {"iphone" in tolower typeof _x}};	
	if (_liste_tel isnotequalto []) then {{deletevehicle _x} foreach _liste_tel;}
};

private _type_Telephone = ["Land_MRP_Neogend","Land_MRP_Iphone_12"] select ("Iphone" in str assignedItems player);
MRP_Telephone = _type_Telephone createVehicle [0,0,0];

private _tel_Est_Negogend = (tolower (typeof MRP_Telephone)) find "neogend" isNotEqualto -1;
if (_tel_Est_Negogend) then
{
	MRP_Telephone attachTo [player,[0.03,0.03,0.06],"lefthand",true];
	[MRP_Telephone,[120,10,-100]] call MRPV2_fnc_SetPitchBankYaw;
} else
{
	MRP_Telephone attachTo [player,[0.037,0.05,-0.045],"lefthand",true]; 
	[MRP_Telephone,[-120,-5,80]] call MRPV2_fnc_SetPitchBankYaw;
};

TRUE
// };