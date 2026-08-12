// MRPV2_fnc_MRP_Tel_Menu_SMS_Action_Envois = {
private _message = param [0,""];
private _date = param [1,[]];
private _numero_Expediteur = param [2,""];
private _numero_Destinataire = param [3,""];


_numero_Destinataire = _numero_Destinataire regexreplace [" ",""];
playsound "MRP_Telephone_Message_Envoyer";

private _joueur_Destinataire = (allplayers select {(_x getvariable ["phoneNumber",""]) isEqualTo (_numero_Destinataire)}) # 0;

if !(isnull _joueur_Destinataire) then
{
	[_message,_date,_numero_Expediteur] remoteExec ["MRPV2_fnc_MRP_Tel_Menu_SMS_Action_Reception",_joueur_Destinataire];
};

["SMS",_numero_Destinataire] call MRPV2_fnc_MRP_Tel_Menu_SMS_Gestion_Nombre_SMS;

TRUE
// };