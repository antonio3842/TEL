// MRPV2_fnc_Marqueur_Gestion ={
private _creer = param [0,TRUE];
private _nom = param [1,""];
private _pos = param [2,[0,0,0]];
private _forme = param [3,""];
private _taille = param [4,[1,1]];
private _couleur = param [5,""];
private _texte = param [6,""];
private _type = param [7,""];

if (_creer) then 
{
	private _marqueur = createMarkerLocal [_nom, _pos];
	_marqueur setMarkerShapeLocal _forme;
	_marqueur setMarkerSizeLocal _taille;
	_marqueur setMarkerColorLocal _couleur;
	_marqueur setMarkerTextLocal _texte;
	_marqueur setMarkerTypeLocal _type;
} else
{
	deleteMarkerLocal _nom;
};
// };