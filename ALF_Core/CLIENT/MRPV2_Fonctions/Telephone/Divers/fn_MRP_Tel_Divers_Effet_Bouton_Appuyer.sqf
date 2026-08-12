// MRPV2_fnc_MRP_Tel_Divers_Effet_Bouton_Appuyer = {
private _ctrlButton = param [0,controlNull];
private _temps_inactif = param [1,0.1];


if !(isnil {MRP_Telephone_Effet_Bouton_Actif}) exitwith {};

MRP_Telephone_Effet_Bouton_Actif = TRUE;
_ctrlButton ctrlenable FALSE;
private _ctrlButton_Pos = ctrlposition _ctrlButton;

private _temps_inactif = 0.1;
private _pos_X = _ctrlButton_Pos # 0;
private _pos_Y = _ctrlButton_Pos # 1;
private _largeur = _ctrlButton_Pos # 2;
private _hauteur = _ctrlButton_Pos # 3;
// private _effet_Decalage = 0.005;
private _effet_Decalage = 0.01;

_ctrlButton ctrlSetPositionX _pos_X + (_effet_Decalage/2);
_ctrlButton ctrlSetPositionY _pos_Y + (_effet_Decalage/2);
_ctrlButton ctrlSetPositionW _largeur - _effet_Decalage;
_ctrlButton ctrlSetPositionH _hauteur - _effet_Decalage;
_ctrlButton ctrlCommit _temps_inactif;

sleep _temps_inactif;

_ctrlButton ctrlSetPositionX _pos_X;
_ctrlButton ctrlSetPositionY _pos_Y;
_ctrlButton ctrlSetPositionW _largeur;
_ctrlButton ctrlSetPositionH _hauteur;
_ctrlButton ctrlCommit _temps_inactif;

sleep _temps_inactif;

_ctrlButton ctrlenable TRUE;
MRP_Telephone_Effet_Bouton_Actif = NIL;

TRUE
// };