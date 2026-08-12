/* Copyright 2023 - Association Get Your Path. All rights reserved */
_documentType = param [0,"",[""]];
if (_documentType isEqualTo "") exitWith {};

_returnClass = [["Documents", "types_documents", _documentType]] call ALFTools_Client_Config_fnc_isClass;
if !(_returnClass) exitWith {["Erreur",format["Le document %1 n'existe pas, veuillez contacter les admins.",_documentType],"warning"] spawn ALF_fnc_doMsg; false;};
  
((toLower _documentType) in (player getVariable ["documents_list",[]]));
