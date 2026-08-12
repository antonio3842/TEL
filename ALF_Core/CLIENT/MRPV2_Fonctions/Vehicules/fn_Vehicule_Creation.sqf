// MRPV2_fnc_Vehicule_Creation = { 
private _className = param [0,""]; 
private _magasin = param [1,""]; 
private _joueur = param [2,objnull]; 
private _plaque = param [3,""]; 



if ("" in [_className,_magasin]) exitWith  
{
   ["INFO", "Erreur lors de la sortie du véhicule.", "danger"] remoteExec ["ALF_fnc_doMsg",_joueur]; 
   closeDialog 0;
   objNull
};

private _positions_Disponibles = [];
private _dir_Position = 0;
private _vehicule = objNull;
private _quitter = false;
private _position_Final = [];

_vehicule_Temp = createVehicle [_className, [0,0,500 random 500], [], 0, "CAN_COLLIDE"]; 
_vehicule_Temp allowDamage FALSE;

private _bbox = boundingBoxreal [_vehicule_Temp,"firegeometry"];
private _taille_X = abs (_bbox # 0 # 2);
private _taille_Y = abs (_bbox # 1 # 2);
private _rayon_Detection = _taille_X + _taille_Y;

deletevehicle _vehicule_Temp;

comment "CAS SPECIAUX";
if (_magasin isEqualTo "Residence_A") exitWith {
   _vehicule = [_magasin,_joueur,_plaque,_rayon_Detection max 2.50,_className] call MRPV2_fnc_Vehicule_Creation_Maison;
   _vehicule
};
if (_magasin in ["MaisonContemporaine","MaisonMitoyenne","LandHouse"]) exitWith  
{
   _vehicule = [_magasin,_joueur,_plaque,_rayon_Detection max 2.50] call MRPV2_fnc_Vehicule_Creation_Maison;
   _vehicule  
};

[] call  
{ 
   if ("Fourrière" in _magasin) exitwith  
   {
      private _ligne_Sortis_Fourriere = (("MRP_ligneparking_reserve" allObjects 0) select {player distance _x < 50}) # 0;
      if (isnil {_ligne_Sortis_Fourriere}) exitwith 
      {
         ["FOURRIERE", "La zone de sortie de la fourrière n'est pas disponible.", "warning"] spawn ALF_fnc_doMsg;        
         _quitter = true;
      };

      private _objets_Proches = _ligne_Sortis_Fourriere nearEntities [["Car","air","tank"],_rayon_Detection max 2.50];
      if (_objets_Proches isequalto []) then 
      {
         _position_Final = getposatl _ligne_Sortis_Fourriere;
         _dir_Position = getDir _ligne_Sortis_Fourriere + 180;
      } else 
      {
         _quitter = true;
      };
   };

   if ("heli" in _magasin OR {"garage" in _magasin AND {!isnil {life_garage_sp} AND {"heli" in life_garage_sp}}}) exitwith  
   {
      if (_magasin in ["pompier_heli","cop_heli","heli_Service"]) then  
      {
         _positions_Disponibles = nearestObjects [_joueur,["Land_HeliPad","Land_HelipadCircle_F","Land_HelipadSquare_F"],50];
      } else 
      {
         _positions_Disponibles = ((nearestTerrainObjects [_joueur, [], 70]) select {typeof _x isequalto "Land_HelipadCivil_F"}); 
      }; 
 
      if (_positions_Disponibles isEqualTo []) then  
      {  
         ["INFO", "Aucun helipad trouvé.", "warning"] spawn ALF_fnc_doMsg; 
         closeDialog 0;
         _quitter = true;
      };
   };

Comment "Partie spéciale concessionnaire";
   if (_magasin in ["Civil Achat"]) exitwith  
   { 
      if (_className isKindOf "ship") exitwith 
      {
         private _liste_Marqueurs_Bateau = (allMapMarkers select {"ship_g" in _x AND {markerpos _x distance player < 50}}); 
         {
            private _marqueur_Bateau = _x;
            private _liste_Objets_Proches = markerpos _marqueur_Bateau nearEntities [["Car","air","tank","ship"],5];

            if (_liste_Objets_Proches isequalto []) exitwith
            {
               _position_Final = markerpos _marqueur_Bateau;
               _dir_Position = markerdir _marqueur_Bateau; 
               _pos_Trouver = true;
            };
         } foreach _liste_Marqueurs_Bateau;
      };

            if (_className isKindOf "air") exitwith 
            {               
               private _liste_Marqueurs_Avia = (allMapMarkers select {"heli_g" in _x AND {markerpos _x distance player < 50}}); 
               {
                  private _marqueur_Avia = _x;
                  private _liste_Objets_Proches = markerpos _marqueur_Avia nearEntities [["Car","air","tank","ship"],5];

                  if (_liste_Objets_Proches isequalto []) exitwith
                  {
                     _position_Final = markerpos _marqueur_Avia;
                     _dir_Position = markerdir _marqueur_Avia; 
                     _pos_Trouver = true;
                  };
               } foreach _liste_Marqueurs_Avia; 
            };

      private _liste_Concessionnaires = ["camion", "bmw", "audi", "ALF_Scooter", "moto", "peugeot", "renault", "luxe"];
      private _liste_Concessionnaires = nearestObjects [_joueur, ["Land_MRP_Concessionnaire"], 30]; 
      private _concessionnaire = _liste_Concessionnaires # 0;

      if !(isnil {_concessionnaire}) exitwith 
      {
         private _isB33 = false;
         private _bizData = _concessionnaire getVariable ["business", []];
         if (count _bizData >= 5) then {
            private _secteur = _bizData # 4;
            if (typeName _secteur == "STRING") then {
               _secteur = parseNumber _secteur;
            };
            _isB33 = (_secteur == 33);
         };

         if (_isB33) then {
            private _classNameLower = toLower _className;
            private _isCamion = ((_classNameLower find "actros") >= 0) || ((_classNameLower find "daf") >= 0) || ((_classNameLower find "premium") >= 0);
            
            private _objets_Proches = [];
            if (_isCamion) then {
               private _pos_Camion = [6787.4,7356.6,-0.023983];
               _objets_Proches = _pos_Camion nearEntities [["Car","air","tank"],_rayon_Detection max 2.50];
               if (_objets_Proches isequalto []) then {
                  _position_Final = _pos_Camion;
                  _dir_Position = 296.605;
               };
            } else {
               private _pos_Voiture = [6790.7,7355.51,0.00406933];
               _objets_Proches = _pos_Voiture nearEntities [["Car","air","tank"],_rayon_Detection max 2.50];
               if (_objets_Proches isequalto []) then {
                  _position_Final = _pos_Voiture;
                  _dir_Position = 296.605;
               };
            };            

            if (_position_Final isEqualTo []) then {
               private _longueur_veh = (abs (_bbox # 0 # 1)) + (abs (_bbox # 1 # 1));

               if (_longueur_veh < 6.2) then 
               {
                  {
                     private _pos = _x;
                     
                     private _objets_Proches = _pos nearEntities [["Car","air","tank"],_rayon_Detection max 2.50];
                     if (_objets_Proches isequalto []) exitwith 
                     {
                        _position_Final = _pos; 
                        _dir_Position = getDir _concessionnaire;
                     };
                  } foreach 
                  [
                     (_concessionnaire getRelPos [1.5,90]), 
                     (_concessionnaire getRelPos [-14,90])
                  ];
               } else 
               {
                  {
                     private _pos = _x;
                     
                     private _objets_Proches = _pos nearEntities [["Car","air","tank"],_rayon_Detection max 2.50];
                     if (_objets_Proches isequalto []) exitwith 
                     {
                        _position_Final = _pos; 
                        _dir_Position = getDir _concessionnaire;
                     };
                  } foreach 
                  [
                     (_concessionnaire getRelPos [16,5]), 
                     (_concessionnaire getRelPos [-21,140])
                  ];
               };
            };
         } else {
            private _longueur_veh = (abs (_bbox # 0 # 1)) + (abs (_bbox # 1 # 1));

            if (_longueur_veh < 6.2) then 
            {
               {
                  private _pos = _x;
                  
                  private _objets_Proches = _pos nearEntities [["Car","air","tank"],_rayon_Detection max 2.50];
                  if (_objets_Proches isequalto []) exitwith 
                  {
                     _position_Final = _pos; 
                     _dir_Position = getDir _concessionnaire;
                  };
               } foreach 
               [
                  (_concessionnaire getRelPos [1.5,90]), 
                  (_concessionnaire getRelPos [-14,90])
               ];
            } else 
            {
               {
                  private _pos = _x;
                  
                  private _objets_Proches = _pos nearEntities [["Car","air","tank"],_rayon_Detection max 2.50];
                  if (_objets_Proches isequalto []) exitwith 
                  {
                     _position_Final = _pos; 
                     _dir_Position = getDir _concessionnaire;
                  };
               } foreach 
               [
                  (_concessionnaire getRelPos [16,5]), 
                  (_concessionnaire getRelPos [-21,140])
               ];
            };
         };
      };

      private _liste_Concessionnaires_Marques = nearestObjects [_joueur, [], 30] select {"Land_consses_" in str _x};
      private _concessionnaire_Marque = _liste_Concessionnaires_Marques # 0;

      if !(isnil {_concessionnaire_Marque}) then 
      {
         private _pos = _concessionnaire_Marque getRelPos [15,26];
         private _objets_Proches = _pos nearEntities [["Car","air","tank","ship"],_rayon_Detection max 2.50];

         if (_objets_Proches isequalto []) then 
         {
            _position_Final = _pos; 
            _dir_Position = (getDir _concessionnaire_Marque) + 90;

            _concessionnaire_Marque animate ["door_4",1];
            _concessionnaire_Marque animate ["door_5",1];

            [
               {
                  allplayers select {(_this # 0) distance _x < 20} isequalto [] AND 
                  {(nearestObjects [(_this # 01), ["car"], 5]) isequalto []}
               },
               {
                  (_this # 0) animate ["door_4",0];
                  (_this # 0) animate ["door_5",0];
               },
               [_concessionnaire_Marque,_pos],
               600,
               {
                  (_this # 0) animate ["door_4",0];
                  (_this # 0) animate ["door_5",0];
               }
            ] call CBA_fnc_waitUntilAndExecute;
         };
      }; 
   };

   // --- Garage Secteur 13 (Préfecture) ---
   if (_magasin in ["Secteur13_Garage"]) then {
      private _pos_Trouver = false;
      private _marqueur_Spawn = "car_pref";
      
      if (_marqueur_Spawn in allMapMarkers) then {
         private _pos_Marqueur = getMarkerPos _marqueur_Spawn;
         private _objets_Proches = _pos_Marqueur nearEntities [["Car","Air","Tank"],_rayon_Detection max 2.50];
         
         if (_objets_Proches isEqualTo []) then {
            _position_Final = _pos_Marqueur;
            _dir_Position = markerDir _marqueur_Spawn;
            _pos_Trouver = true;
         };
      } else {
         ["INFO", "Le marker car_pref n'existe pas sur la carte.", "warning"] spawn ALF_fnc_doMsg;
      };
      
      if (!_pos_Trouver) then {
         ["INFO", "Aucun emplacement disponible au garage Préfecture.", "warning"] spawn ALF_fnc_doMsg;
         closeDialog 0;
         _quitter = true;
      };
   };

   // --- Garage Secteur 23 (Tribunal) ---
   if (_magasin in ["Secteur23_Garage"]) then {
      private _pos_Trouver = false;
      private _marqueur_Spawn = "car_trib";
      
      if (_marqueur_Spawn in allMapMarkers) then {
         private _pos_Marqueur = getMarkerPos _marqueur_Spawn;
         private _objets_Proches = _pos_Marqueur nearEntities [["Car","Air","Tank"],_rayon_Detection max 2.50];
         
         if (_objets_Proches isEqualTo []) then {
            _position_Final = _pos_Marqueur;
            _dir_Position = markerDir _marqueur_Spawn;
            _pos_Trouver = true;
         };
      } else {
         ["INFO", "Le marker car_trib n'existe pas sur la carte.", "warning"] spawn ALF_fnc_doMsg;
      };
      
      if (!_pos_Trouver) then {
         ["INFO", "Aucun emplacement disponible au garage Tribunal.", "warning"] spawn ALF_fnc_doMsg;
         closeDialog 0;
         _quitter = true;
      };
   };

   if (_magasin in ["GN Garage","GN Achat","SP Garage","SP Achat","AP Garage","AP Achat","Civil Garage"]) then  
   {
      private _pos_Trouver = false; 
      private _place_Est_Vide = false;
      [] call  
      {
         private _longueur_veh = (abs (_bbox # 0 # 1)) + (abs (_bbox # 1 # 1));

         [] call
         {  
            if (_magasin in ["GN Garage","GN Achat"] AND {_longueur_veh < 6}) exitWith
            {
               _garage_Disponibles = (nearestTerrainObjects [_joueur, [], 30]) select {typeof _x isequalto "Land_mrp_garage"};
               private _garage = _garage_Disponibles # 0;

               {
                  private _pos = (_garage getRelPos (_x # 0));
                  private _objets_Proches = _pos nearEntities [["Car","Air","tank"],_rayon_Detection max 2.50];
                  if (_objets_Proches isequalto []) exitWith
                  {
                     _position_Final = _pos;
                     _garage animateSource [_x # 1,3.1];
                     _dir_Position = (getdir _garage) + 180;
                     _pos_Trouver = true;
                  };
               } forEach [
                  [[-8,80],"gar_1_5_source"],
                  [[-4,70],"gar_2_5_source"],
                  [[-1,0],"gar_3_5_source"],
                  [[-4,-70],"gar_4_5_source"],
                  [[-8,-80],"gar_5_5_source"]
               ];
            };
            if (_className isKindOf "ship") exitwith 
            {               
               private _liste_Marqueurs_Bateau = (allMapMarkers select {"ship_gn" in _x AND {markerpos _x distance player < 50}}); 
               {
                  private _marqueur_Bateau = _x;
                  private _liste_Objets_Proches = markerpos _marqueur_Bateau nearEntities [["Car","air","tank","ship"],5];

                  if (_liste_Objets_Proches isequalto []) exitwith
                  {
                     _position_Final = markerpos _marqueur_Bateau;
                     _dir_Position = markerdir _marqueur_Bateau; 
                     _pos_Trouver = true;
                  };
               } foreach _liste_Marqueurs_Bateau; 
            };
            if (_pos_Trouver) exitwith {};

            comment "Forcer le spawn uniquement sur le marker ap_car_spawn";
            if (_magasin in ["AP Garage","AP Achat"] AND {_longueur_veh < 6}) exitWith
            {
               _garage_Disponibles = (nearestTerrainObjects [_joueur, [], 30]) select {typeof _x isequalto "Land_mrp_garage"};
               private _garage = _garage_Disponibles # 0;

               {
                  private _pos = (_garage getRelPos (_x # 0));
                  private _objets_Proches = _pos nearEntities [["Car","Air","tank"],_rayon_Detection max 2.50];
                  if (_objets_Proches isequalto []) exitWith
                  {
                     _position_Final = _pos;
                     _garage animateSource [_x # 1,3.1];
                     _dir_Position = (getdir _garage) + 180;
                     _pos_Trouver = true;
                  };
               } forEach [
                  [[-8,80],"gar_1_5_source"],
                  [[-4,70],"gar_2_5_source"],
                  [[-1,0],"gar_3_5_source"],
                  [[-4,-70],"gar_4_5_source"],
                  [[-8,-80],"gar_5_5_source"]
               ];
            };
            if (_pos_Trouver) exitwith {};


            if (_magasin in ["SP Garage","SP Achat"] AND {_longueur_veh < 9}) then 
            {
               _garage_Disponibles = (nearestTerrainObjects [_joueur, [], 30]) select {typeof _x isequalto "Land_Remise_MRP"};

               private _garage = _garage_Disponibles # 0;

               {
                  private _pos = (_garage getRelPos (_x # 0));
                  private _objets_Proches = _pos nearEntities [["Car","air","tank"],_rayon_Detection max 2.50];

                  if (_objets_Proches isequalto []) exitwith 
                  {
                     _position_Final = _pos;
                     _garage animatesource [_x # 1,3];
                     _dir_Position = (getdir _garage) + 180;
                     _pos_Trouver = true;
                  };
               } foreach 
               [
                  [[16.5,-259],"gdoor_5_source"],
                  [[9,-260],"gdoor_4_source"],
                  [[-2,-40],"gdoor_3_source"],
                  [[-7,70],"gdoor_2_source"]
               ]; 
            };
         };

         if (_magasin in ["Civil Garage"]) then 
         {
            if (_className isKindOf "ship") exitwith 
            {               
               private _liste_Marqueurs_Bateau = (allMapMarkers select {"ship_g" in _x AND {markerpos _x distance player < 50}}); 
               {
                  private _marqueur_Bateau = _x;
                  private _liste_Objets_Proches = markerpos _marqueur_Bateau nearEntities [["Car","air","tank","ship"],5];

                  if (_liste_Objets_Proches isequalto []) exitwith
                  {
                     _position_Final = markerpos _marqueur_Bateau;
                     _dir_Position = markerdir _marqueur_Bateau; 
                     _pos_Trouver = true;
                  };
               } foreach _liste_Marqueurs_Bateau; 
            };

            if (_className isKindOf "air") exitwith 
            {               
               private _liste_Marqueurs_Avia = (allMapMarkers select {"heli_g" in _x AND {markerpos _x distance player < 50}}); 
               {
                  private _marqueur_Avia = _x;
                  private _liste_Objets_Proches = markerpos _marqueur_Avia nearEntities [["Car","air","tank","ship"],5];

                  if (_liste_Objets_Proches isequalto []) exitwith
                  {
                     _position_Final = markerpos _marqueur_Avia;
                     _dir_Position = markerdir _marqueur_Avia; 
                     _pos_Trouver = true;
                  };
               } foreach _liste_Marqueurs_Avia; 
            };

            if (cursorObject in life_vehicles) then 
            {
               _positions_Disponibles = [cursorObject]; 
            } else 
            {
               _positions_Disponibles = (nearestTerrainObjects [_joueur, [], 70]) select {typeof _x isequalto "Land_i_Garage_V1_F"}; 
            };

            {
               private _garage = _x;
               private _objets_Proches = _garage nearEntities [["Car","air","tank","ship"],_rayon_Detection max 2.50];
               if (_objets_Proches isequalto []) exitwith 
               {
                  _position_Final = getposatl _garage;
                  _dir_Position = (getdir _garage) - (if (typeOf _garage isEqualTo "Land_Garage") then {180} else {90});
                  _pos_Trouver = true;
               };
            } foreach _positions_Disponibles;
         };
         if (_pos_Trouver) exitwith {};

         comment "spawn gn ship";
         if (_magasin in ["Civil Garage"]) then 
         {
            if (_className isKindOf "shipp") exitwith 
            {               
               private _liste_Marqueurs_Bateau = (allMapMarkers select {"ship_gn" in _x AND {markerpos _x distance player < 50}}); 
               {
                  private _marqueur_Bateau = _x;
                  private _liste_Objets_Proches = markerpos _marqueur_Bateau nearEntities [["Car","air","tank","ship"],5];

                  if (_liste_Objets_Proches isequalto []) exitwith
                  {
                     _position_Final = markerpos _marqueur_Bateau;
                     _dir_Position = markerdir _marqueur_Bateau; 
                     _pos_Trouver = true;
                  };
               } foreach _liste_Marqueurs_Bateau; 
            };

            if (cursorObject in life_vehicles) then 
            {
               _positions_Disponibles = [cursorObject]; 
            } else 
            {
               _positions_Disponibles = (nearestTerrainObjects [_joueur, [], 70]) select {typeof _x isequalto "Land_i_Garage_V1_F"}; 
            };

            {
               private _garage = _x;
               private _objets_Proches = _garage nearEntities [["Car","air","tank","ship"],_rayon_Detection max 2.50];
               if (_objets_Proches isequalto []) exitwith 
               {
                  _position_Final = getposatl _garage;
                  _dir_Position = (getdir _garage) - (if (typeOf _garage isEqualTo "Land_Garage") then {180} else {90});
                  _pos_Trouver = true;
               };
            } foreach _positions_Disponibles;
         };
         if (_pos_Trouver) exitwith {};

         private _liste_vehicules_heli = [
            "V_ALF_EC135_Gendarmerie",
            "MRP_AS350_GENDARMERIE",
            "EC135GNlu_MRPV2",
            "V_ALF_PW207_Pompier",
            "V_ALF_EC135_Pompier"
         ];

         if (_className in _liste_vehicules_heli) exitWith 
         {
            private _helipads = (nearestTerrainObjects [_joueur, [], 70]) select 
            {
               typeof _x in ["Land_HelipadCircle_F", "Land_HelipadSquare_F"];
            };

            if (_helipads isNotEqualTo []) then 
            {
               private _pad = _helipads # 0;
               _position_Final = getPosATL _pad;
               _dir_Position = getDir _pad;
               _pos_Trouver = true;
            } else 
            {
               systemChat format ["[ERREUR] Aucun helipad GN trouvé pour hélico %1", _className];
            };
         };

         _positions_Disponibles = (nearestTerrainObjects [_joueur, [], 45]) select {(tolower "mrp_ligneparking")  in str _x AND {damage _x < 1}};
         _positions_Disponibles append ((nearestObjects [_joueur, [tolower "MRP_ligneparking"], 45]) select {damage _x < 1});

         if (_positions_Disponibles isNotEqualTo []) then  
         {
            {
               private _place_Parking = _x;
               private _bb_Place_Parking = boundingBoxReal _place_Parking;
               private _bb_Place_Parking_X = abs (_bb_Place_Parking # 0 # 0);
               private _bb_Place_Parking_Y = abs (_bb_Place_Parking # 0 # 1);
               private _objets_Proches = _place_Parking nearEntities [["Car","air","tank"],10];
               private _sur_Place_Parking = FALSE;

               {
                  _sur_Place_Parking = _x inArea [getposatl _place_Parking, _bb_Place_Parking_X, _bb_Place_Parking_Y, getdir _place_Parking, false];
                  if (_sur_Place_Parking) exitwith {};
               } foreach _objets_Proches;
               
               if !(_sur_Place_Parking) exitwith 
               {
                  _position_Final = _place_Parking getRelPos [1.5,180]; 
                  _dir_Position = (getdir _place_Parking)  + 180; 
                  _pos_Trouver = true;
               };
            } foreach _positions_Disponibles;
         };
      };
      if (_pos_Trouver) exitwith {};

      ["INFO", "Aucun garage ni place de parking n'est disponible.", "warning"] spawn ALF_fnc_doMsg;        
      _quitter = true;
   }; 
};
if (_quitter) exitWith {closeDialog 0; _vehicule}; 

{
   private _obj = _x;

   if (count _x > 1) then {_obj = _x # 0;};

   if (_objets_Proches isEqualTo []) exitWith  
   { 
      if ("garage_v1" in toLower str (_positions_Disponibles # 0)) exitwith  
      {
         _position_Final = _obj getRelPos [0.3,0];
      };      
      if (_magasin in ["civ_heli","heli_Service"]) exitwith  
      {
         _position_Final = getposatl _obj vectorAdd [-1,0,0.2];
         _dir_Position = getDir _obj; 
      };
   };      
} forEach []; 

if (_position_Final isEqualTo []) exitWith  
{
   ["INFO", "Espace insuffisant pour livrer le véhicule, vous le trouverez dans un garage.", "warning"] spawn ALF_fnc_doMsg;  
   closeDialog 0; 
   _vehicule 
};

_vehicule = createVehicle [_className, [0,0,500 random 500], [], 0, "CAN_COLLIDE"]; 
_vehicule allowDamage FALSE;

if (_className isKindOf "ship") then
{
   _vehicule setPosASLW (_position_Final vectoradd [0,0,0.1]);
} else
{
   _vehicule setPosATL (_position_Final vectoradd [0,0,0.1]);
};
_vehicule setDir _dir_Position;
_vehicule setVariable ["plate", _plaque, true];

if ( (_className isEqualTo "EC135GNlu") OR {(typeOf _vehicule) isEqualTo "EC135GNlu"} ) then {
    clearItemCargoGlobal _vehicule;
    clearMagazineCargoGlobal _vehicule;
    clearWeaponCargoGlobal _vehicule;
    clearBackpackCargoGlobal _vehicule;
    };

[_vehicule] spawn {sleep 2; (_this # 0) allowDamage TRUE;};
[_vehicule,TRUE] remoteExec ["lockInventory",0,true];

life_vehicles pushBack _vehicule;
 
[_vehicule,true] remoteExecCall ["enableDynamicSimulation",2];

private _info_Pos_BDD = [getposatl _vehicule,getdir _vehicule];

[_vehicule,getplayeruid player,_plaque,_magasin,_info_Pos_BDD] remoteExecCall ["MRPV2_Server_fnc_Vehicule_Configurations",2];

private _liste_Concessionnaires_Marques = nearestObjects [_joueur, [], 30] select {"Land_consses_" in str _x};
private _concessionnaire_Marque = _liste_Concessionnaires_Marques # 0;

if !(isnil {_concessionnaire_Marque}) then 
{
   [] spawn 
   {
      titleText["Votre véhicule vous attend dans le garage à la porte sur votre droite.","PLAIN"];

      sleep 10;

      titleText["","PLAIN"];
   };
};
 
_vehicule
// };