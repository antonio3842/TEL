// MRPV2_fnc_MRP_Tel_Divers_Son_Arret_Appel = {
[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Son;

private _MRP_Appel_Etat = player getvariable ["MRP_Appel_Etat",""];
if (_MRP_Appel_Etat isequalto "Arret tentative") exitwith {playSoundUI ["MRP_Telephone_Tonalite_Appel",0.2,1,FALSE,1.5];};

[] spawn
{
	playSoundUI ["MRP_Telephone_Tonalite_Appel",0.2,1,FALSE,1.5];

	sleep 0.5;

	playSoundUI ["MRP_Telephone_Tonalite_Appel",0.2,1,FALSE,1.5];
};

TRUE
// };