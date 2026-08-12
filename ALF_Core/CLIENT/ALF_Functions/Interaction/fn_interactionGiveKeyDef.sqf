// ALF_fnc_interactionGiveKeyDef = {
// Fonction pour donner définitivement les clés d'un véhicule via le menu d'interaction
// Utilise le menu Y avec l'onglet clés et le bouton GiveKeydef (id 123499)

private _targetUnit = param [0, objNull, [objNull]];

if (isNull _targetUnit) exitWith {["Erreur", "Aucune personne visée", "warning"] spawn ALF_fnc_doMsg;};
if (!(_targetUnit isKindOf "Man")) exitWith {["Erreur", "Vous devez viser une personne", "warning"] spawn ALF_fnc_doMsg;};
if (!isPlayer _targetUnit) exitWith {["Erreur", "La cible doit être un joueur", "warning"] spawn ALF_fnc_doMsg;};
if (!alive _targetUnit) exitWith {["Erreur", "La personne visée n'est pas vivante", "warning"] spawn ALF_fnc_doMsg;};
if (_targetUnit isEqualTo player) exitWith {["Erreur", "Vous ne pouvez pas vous donner une clé à vous-même", "warning"] spawn ALF_fnc_doMsg;};

// Stocker la personne visée dans une variable globale pour que fn_keyGiveDef puisse l'utiliser
ALF_Interaction_Target_Unit = _targetUnit;

// Ouvrir le menu Y directement sur l'onglet clés (ymenu = 1)
uiNamespace setVariable ["ymenu", 1];

if (!dialog) then {
    createDialog "ymenu_dialog";
};

// Appeler le menu Y pour afficher l'onglet clés
[] call ALF_fnc_menuY;

// Le bouton GiveKeydef (id 123499) sera rendu visible automatiquement par fn_menuY
// Il appelle déjà ALF_fnc_keyGiveDef qui va maintenant utiliser ALF_Interaction_Target_Unit
// };

