// MRPV2_fnc_Interaction_Citerne_Station_Essence = {
if !(dialog) then {createDialog "interactionSystem";};

private _affichage = findDisplay 25799;
private _liste_Boutons = [];

for "_i" from 0 to 11 do 
{
    private _bouton = _affichage displayCtrl (25802 + _i);
    _bouton ctrlShow FALSE;
    _liste_Boutons pushBack _bouton;
};

[player,clientOwner] remoteExec ['MRPV2_Server_fnc_Littrage_Citerne_Vers_Client',2];

private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
_bouton ctrlShow TRUE;
_bouton ctrlSetText "Voir le littrage";
_bouton ctrlAddEventHandler ["buttonClick", 
{closeDialog 2;
   [player,clientOwner] remoteExec ['MRPV2_Server_fnc_Littrage_Citerne_Vers_Client',2];
   [] call ALF_fnc_Citerne_Littrage_Appel;
}];

if ("ALF_Barile_Station" in magazines player) then 
{
    private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
    _bouton ctrlShow TRUE;
    _bouton ctrlSetText "Vider le bidon d'essence traité";
    _bouton ctrlAddEventHandler ["buttonClick", 
    {closeDialog 2;
        [player,clientOwner] remoteExec ['MRPV2_Server_fnc_Littrage_Citerne_Vers_Client',2];
        ["Remplissage"] call ALF_fnc_Citerne_Littrage_Appel;
    }];
};
// };