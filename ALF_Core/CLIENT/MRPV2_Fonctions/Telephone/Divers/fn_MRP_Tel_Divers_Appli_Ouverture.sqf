// MRPV2_fnc_MRP_Tel_Divers_Appli_Ouverture = {
private _ctrl = param [0,controlNull];


private _texte_Appli = _ctrl getvariable ["_appli",""];
if (tolowerANSI _texte_Appli isequalto "mail") exitwith {};

[] call MRPV2_fnc_MRP_Tel_Divers_Suppr_Ecran;

if (tolowerANSI _texte_Appli isequalto "bloc_note") exitwith {[] call MRPV2_fnc_MRP_Tel_Menu_Bloc_Crea;};
if (tolowerANSI _texte_Appli in ["pcstorm","codis","dspom"]) exitwith {[] call MRPV2_fnc_MRP_Tel_Menu_Dispatch_Crea;};
if (tolowerANSI _texte_Appli in ["corg","centre_appel","cta","ap"]) exitwith {[] call MRPV2_fnc_MRP_Tel_Menu_CA_Crea;};
if (tolowerANSI _texte_Appli isequalto "annuaire") exitwith {[] call MRPV2_fnc_MRP_Tel_Menu_Annuaire_Crea;};
if (tolowerANSI _texte_Appli isequalto "radio") exitwith {[] call MRPV2_fnc_MRP_Tel_Menu_Radio_Crea;};
if (tolowerANSI _texte_Appli isequalto "taxi") exitwith {[] call MRPV2_fnc_MRP_Tel_Menu_Taxi_Crea;};
if (tolowerANSI _texte_Appli isequalto "taj") exitwith {[] call MRPV2_fnc_MRP_Tel_Menu_TAJ_Crea;};
if (tolowerANSI _texte_Appli isequalto "siv") exitwith {[] call MRPV2_fnc_MRP_Tel_Menu_SIV_Crea;};
if (tolowerANSI _texte_Appli isequalto "fpr") exitwith {[] call MRPV2_fnc_MRP_Tel_Menu_FPR_Crea;};

TRUE
// };