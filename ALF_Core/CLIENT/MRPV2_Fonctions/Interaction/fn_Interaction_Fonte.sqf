// MRPV2_fnc_Interaction_Fonte = {

if (isnull (findDisplay 25799)) then { createDialog "interactionSystem"; };

private _affichage = findDisplay 25799;
private _liste_Boutons = [];
private _objet = cursorObject;

for "_i" from 0 to 11 do 
{
    private _bouton = _affichage displayCtrl (25802 + _i);
    _bouton ctrlShow FALSE;
    _liste_Boutons pushBack _bouton;
};

if (typeof _objet isequalto "Land_fonte_3") exitwith 
{
    if !("ALF_Pierre_cui_small" in magazines player) exitwith 
    {closeDialog 2;
        ["FONTE", "Vous devez avoir du minerai de cuivre sur vous.", "warning"] spawn ALF_fnc_doMsg;
    };
    if (_objet animationPhase "end" isNotEqualTo 0) exitwith 
    {closeDialog 2;
        ["FONTE", "La machine n'a pas terminé son cycle.", "warning"] spawn ALF_fnc_doMsg;
    };
    if (_objet animationPhase "door" isNotEqualTo 0) exitwith 
    {closeDialog 2;
        ["FONTE", "La porte de la machine doit être fermé.", "warning"] spawn ALF_fnc_doMsg;
    };

    private _bouton_Remplir = _liste_Boutons # 0;
    _bouton_Remplir ctrlShow TRUE;
    _bouton_Remplir ctrlSetText "Fondre le cuivre";
    _bouton_Remplir ctrlAddEventHandler ["buttonClick", 
    {closeDialog 2;
        [player,cursorObject] remoteExec ["ALF_Server_fnc_fonderieCuivre",2];
    }];
};

if (typeof _objet isequalto "Land_fonte_2") exitwith 
{
    if !("ALF_pierre_fer_small" in magazines player) exitwith 
    {closeDialog 2;
        ["FONTE", "Vous devez avoir du minerai de fer sur vous.", "warning"] spawn ALF_fnc_doMsg;
    };
    if (_objet animationPhase "end" isNotEqualTo 0) exitwith 
    {closeDialog 2;
        ["FONTE", "La machine n'a pas terminé son cycle.", "warning"] spawn ALF_fnc_doMsg;
    };
    if (_objet animationPhase "door" isNotEqualTo 0) exitwith 
    {closeDialog 2;
        ["FONTE", "La porte de la machine doit être fermé.", "warning"] spawn ALF_fnc_doMsg;
    };

    private _bouton_Remplir = _liste_Boutons # 0;
    _bouton_Remplir ctrlShow TRUE;
    _bouton_Remplir ctrlSetText "Fondre le fer";
    _bouton_Remplir ctrlAddEventHandler ["buttonClick", 
    {closeDialog 2;
        [player,cursorObject] remoteExec ["ALF_Server_fnc_fonderieFer",2];
    }];
};

if (typeof _objet isequalto "Land_fonte") exitwith 
{
    if !("ALF_Pepite_Or" in magazines player) exitwith 
    {closeDialog 2;
        ["FONTE", "Vous devez avoir du minerai d'or sur vous.", "warning"] spawn ALF_fnc_doMsg;
    };
    if (_objet animationPhase "end" isNotEqualTo 0) exitwith 
    {closeDialog 2;
        ["FONTE", "La machine n'a pas terminé son cycle.", "warning"] spawn ALF_fnc_doMsg;
    };
    if (_objet animationPhase "door" isNotEqualTo 0) exitwith 
    {closeDialog 2;
        ["FONTE", "La porte de la machine doit être fermé.", "warning"] spawn ALF_fnc_doMsg;
    };

    private _bouton_Remplir = _liste_Boutons # 0;
    _bouton_Remplir ctrlShow TRUE;
    _bouton_Remplir ctrlSetText "Fondre l'or";
    _bouton_Remplir ctrlAddEventHandler ["buttonClick", 
    {closeDialog 2;
        [player,cursorObject] remoteExec ["ALF_Server_fnc_fonderieOr",2];
    }];
};
// };