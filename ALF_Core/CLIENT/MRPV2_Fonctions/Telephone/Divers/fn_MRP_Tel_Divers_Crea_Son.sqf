// MRPV2_fnc_MRP_Tel_Divers_Crea_Son = {
private _objet_Ancre = param [0,objnull];
private _position_Attachto = param [1,[0,0,0.2],[[],""]];


MRP_Telephone_Source_Son = "#particlesource" createVehicle [0,0,0];
MRP_Telephone_Source_Son attachto [_objet_Ancre,_position_Attachto];

TRUE
// };