// MRPV2_fnc_Vehicule_Creation_Plaque = {
private _lettres = ["A","B","C","D","E","F","G","H","J","K","L","M","N","P","Q","R","S","T","V"];
private _chiffres = ["0","1","2","3","4","5","6","7","8","9"];

private _pl1 = format ["%1", selectRandom _lettres];
private _pl2 = format ["%1", selectRandom _lettres];
private _ps1 = format ["%1", "-"];
private _pn1 = format ["%1", selectRandom _chiffres];
private _pn2 = format ["%1", selectRandom _chiffres];
private _pn3 = format ["%1", selectRandom _chiffres];
private _ps2 = format ["%1", "-"];
private _pl3 = format ["%1", selectRandom _lettres];
private _pl4 = format ["%1", selectRandom _lettres];

private _plaque_Finale = [_pl1, _pl2, _ps1, _pn1, _pn2, _pn3, _ps2, _pl3, _pl4] joinString "";
_plaque_Finale
// };