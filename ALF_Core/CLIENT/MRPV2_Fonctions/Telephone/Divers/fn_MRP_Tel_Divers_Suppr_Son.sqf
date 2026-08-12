_son = ASLToAGL [0,0,0] nearestObject "#soundonvehicle";
deleteVehicle _son;

if !(isnil {MRP_Telephone_Source_Son}) then
{
	deletevehicle MRP_Telephone_Source_Son;
	MRP_Telephone_Source_Son = nil;
};

if !(isnil {MRP_Telephone_Liste_Sons_Repondeur}) then
{
	{
		deletevehicle _x;
	} foreach MRP_Telephone_Liste_Sons_Repondeur;

	MRP_Telephone_Liste_Sons_Repondeur = nil;
};

TRUE