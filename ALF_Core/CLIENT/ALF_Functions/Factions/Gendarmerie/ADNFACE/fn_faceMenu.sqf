// ALF_fnc_faceMenu = {
if(life_copLevel < 1) exitWith {["INFO","Tu n'es pas Gendarme.","warning"] spawn ALF_fnc_doMsg;};
disableSerialization;
createDialog "ALF_FACE_Dialog";

private _btn1 = (findDisplay 13500) displayCtrl 13505;
private _btn2 = (findDisplay 13500) displayCtrl 13506;
_btn1 buttonSetAction "[] call ALF_fnc_faceRecherche;";
_btn2 buttonSetAction "[] spawn ALF_fnc_faceCreate;";
// };