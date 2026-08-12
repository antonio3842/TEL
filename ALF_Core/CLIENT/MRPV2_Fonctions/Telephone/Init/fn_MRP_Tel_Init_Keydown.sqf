// MRPV2_fnc_MRP_Tel_Init_Keydown = {
// private _key = param [0,0];


private _Telephone_Base = uiNamespace getVariable ["MRP_Telephone_Base",displayNull];
if (_Telephone_Base isequalto displayNull) then
{
	if (assignedItems player select {"MRP_Item_Iphone_12" in _x OR {"MRP_Item_Neogend" in _x}} isEqualto []) exitwith {};
	if (lifeState player in ["INCAPACITATED","DEAD"]) exitwith {};

	[] spawn MRPV2_fnc_MRP_Tel_Init_Ouverture;
} else
{
	closeDialog 2;
	closeDialog 0;
};
// NE PAS METTRE DE TRUE SINON CA BLOQUE TOUT
// };