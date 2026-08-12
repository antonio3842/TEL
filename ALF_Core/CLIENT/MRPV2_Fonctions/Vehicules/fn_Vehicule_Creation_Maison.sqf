// MRPV2_fnc_Vehicule_Creation_Maison = {
private _magasin = param [0,""]; 
private _joueur = param [1,objnull]; 
private _plaque = param [2,""]; 
private _rayon_Detection = param [3,0]; 


if (_magasin in ["MaisonContemporaine"]) exitwith  
{
   private _garage_Maison_Proche = cursorObject;
   if (isnil {_garage_Maison_Proche}) exitwith {["Maison", "La porte du garage est défectueuse, contactez les services spécialisés.", "warning"] remoteExec ["ALF_fnc_doMsg",_joueur];};

   private _pos_Detection_Veh = [];
   _pos_Detection_Veh = _garage_Maison_Proche getrelpos [7,110];

   private _objets_Proches = (entities [["man","Car","air","tank"],[]]) select {_pos_Detection_Veh distance _x < _rayon_Detection};
   if (_objets_Proches isNotequalto []) exitwith {objnull};

   ["Maison", "Le véhicule va être sortis dans votre garage.", "info"] remoteExec ["ALF_fnc_doMsg",_joueur];

   _garage_Maison_Proche animate ["Door_12",1];
   _garage_Maison_Proche animate ["Door_13",1];
   _garage_Maison_Proche animate ["Door_13_1",1];

   private _vehicule = createVehicle [_className, [0,0,500 random 500], [], 0, "CAN_COLLIDE"];
   _vehicule allowDamage FALSE; 
   _vehicule enablesimulation false;

   [{params ["_garage_Maison_Proche"];
      (_garage_Maison_Proche animationPhase "door_13_1") > 0.9
   },
   {params ["_garage_Maison_Proche","_vehicule","_UID","_plaque","_magasin","_pos_Detection_Veh"];
      _vehicule setPosATL ((_garage_Maison_Proche getrelpos [7,110]) vectoradd [0,0,0.5]); 
      _vehicule setDir (getdir _garage_Maison_Proche) + 180;
      _vehicule enablesimulation true;
      [_vehicule,true] remoteExecCall ["enableDynamicSimulation",2];      
      [_vehicule,TRUE] remoteExec ["lockInventory",0];
      life_vehicles pushBack _vehicule;

      [_vehicule] spawn {sleep 2; (_this # 0) allowDamage TRUE;};

      private _info_Pos_BDD = [getposatl _vehicule,getdir _vehicule];      
      [_vehicule,_UID,_plaque,_magasin,_info_Pos_BDD] remoteExecCall ["MRPV2_Server_fnc_Vehicule_Configurations",2]; 
   },[_garage_Maison_Proche,_vehicule,getplayeruid _joueur,_plaque,_magasin,_pos_Detection_Veh],10,
   {
      ["Maison", "La porte du garage est défectueuse, contactez les services spécialisés.", "warning"] remoteExec ["ALF_fnc_doMsg",_this # 2];
   }] call CBA_fnc_waitUntilAndExecute;

   _vehicule
};

if (_magasin in ["MaisonMitoyenne"]) exitwith  
{
   private _garage_Maison_Proche = cursorObject;
   if (isnil {_garage_Maison_Proche}) exitwith {["Maison", "La porte du garage est défectueuse, contactez les services spécialisés.", "warning"] remoteExec ["ALF_fnc_doMsg",_joueur];};

   private _pos_Detection_Veh = [];
   if (typeOf _garage_Maison_Proche isequalto "Land_ALF_MaisonMitoyenne1") then 
   {
      _pos_Detection_Veh = _garage_Maison_Proche getrelpos [7,120]; 
   } else 
   {
      _pos_Detection_Veh = _garage_Maison_Proche getrelpos [6.5,-120]; 
   };

   private _objets_Proches = (entities [["man","Car","air","tank"],[]]) select {_pos_Detection_Veh distance _x < _rayon_Detection};
   if (_objets_Proches isNotequalto []) exitwith {objnull};

   ["Maison", "Le véhicule va être sortis dans votre garage.", "info"] remoteExec ["ALF_fnc_doMsg",_joueur];

   _garage_Maison_Proche animate ["Door_15",1]; 
   _garage_Maison_Proche animate ["Door_16",1]; 
   _garage_Maison_Proche animate ["Door_16_1",1];

   private _vehicule = createVehicle [_className, [0,0,500 random 500], [], 0, "CAN_COLLIDE"];
   _vehicule allowDamage FALSE; 
   _vehicule enablesimulation false;

   [{params ["_garage_Maison_Proche"];
      (_garage_Maison_Proche animationPhase "Door_16_1") > 0.9
   },
   {params ["_garage_Maison_Proche","_vehicule","_UID","_plaque","_magasin","_pos_Detection_Veh"];
      if (typeOf _garage_Maison_Proche isequalto "Land_ALF_MaisonMitoyenne1") then 
      {
         _vehicule setPosATL (_pos_Detection_Veh vectoradd [0,0,0.5]); 
      } else 
      {
         _vehicule setPosATL (_pos_Detection_Veh vectoradd [0,0,0.5]); 
      };
      _vehicule setDir (getdir _garage_Maison_Proche) + 180;
      _vehicule enablesimulation true;
      [_vehicule,true] remoteExecCall ["enableDynamicSimulation",2]; 
      _vehicule lockInventory true;
      life_vehicles pushBack _vehicule;

      [_vehicule] spawn {sleep 2; (_this # 0) allowDamage TRUE;};

      private _info_Pos_BDD = [getposatl _vehicule,getdir _vehicule];      
      [_vehicule,_UID,_plaque,_magasin,_info_Pos_BDD] remoteExecCall ["MRPV2_Server_fnc_Vehicule_Configurations",2];
   },[_garage_Maison_Proche,_vehicule,getplayeruid _joueur,_plaque,_magasin,_pos_Detection_Veh],10,
   {
      ["Maison", "La porte du garage est défectueuse, contactez les services spécialisés.", "warning"] remoteExec ["ALF_fnc_doMsg",_this # 2];
   }] call CBA_fnc_waitUntilAndExecute;

   _vehicule
};

if (_magasin in ["Residence_A"]) exitwith  
{
   private _classNameVeh = param [4, "", [""]];
   if (_classNameVeh isEqualTo "") exitWith {objNull};

   private _garage_Maison_Proche = life_pInact_curObject;
   if (isNull _garage_Maison_Proche OR {!("Land_Residence_A" in typeof _garage_Maison_Proche)}) then {
      _garage_Maison_Proche = cursorObject;
   };
   if (isNull _garage_Maison_Proche OR {!("Land_Residence_A" in typeof _garage_Maison_Proche)}) exitwith {
      ["Maison", "La porte du garage est défectueuse, contactez les services spécialisés.", "warning"] remoteExec ["ALF_fnc_doMsg",_joueur];
      objNull
   };

   private _spawnPos = _garage_Maison_Proche modelToWorld [4.89844,-2.21545,0.1];
   private _spawnDir = (getDir _garage_Maison_Proche) + 180;

   private _objets_Proches = (entities [["man","Car","air","tank"],[]]) select {_spawnPos distance _x < _rayon_Detection};
   if (_objets_Proches isNotequalto []) exitwith {objNull};

   ["Maison", "Le véhicule va être sortis dans votre garage.", "info"] remoteExec ["ALF_fnc_doMsg",_joueur];

   private _vehicule = createVehicle [_classNameVeh, [0,0,500 random 500], [], 0, "CAN_COLLIDE"];
   _vehicule allowDamage FALSE;
   _vehicule setPosATL _spawnPos;
   _vehicule setDir _spawnDir;
   _vehicule enableSimulation true;
   [_vehicule,true] remoteExecCall ["enableDynamicSimulation",2];
   _vehicule lockInventory true;
   life_vehicles pushBack _vehicule;

   [_vehicule] spawn {sleep 2; (_this # 0) allowDamage TRUE;};

   private _info_Pos_BDD = [getPosATL _vehicule,getDir _vehicule];
   [_vehicule,getplayeruid _joueur,_plaque,_magasin,_info_Pos_BDD] remoteExecCall ["MRPV2_Server_fnc_Vehicule_Configurations",2];

   _vehicule
};

if (_magasin in ["LandHouse"]) exitwith  
{
   private _garage_Maison_Proche = cursorObject;
   if (isnil {_garage_Maison_Proche}) exitwith {["Maison", "La porte du garage est défectueuse, contactez les services spécialisés.", "warning"] remoteExec ["ALF_fnc_doMsg",_joueur];};

   private _pos_Detection_Veh = [];
   _pos_Detection_Veh = _garage_Maison_Proche getrelpos [6,130];

   private _objets_Proches = (entities [["man","Car","air","tank"],[]]) select {_pos_Detection_Veh distance _x < _rayon_Detection};
   if (_objets_Proches isNotequalto []) exitwith {objnull};

   ["Maison", "Le véhicule va être sortis dans votre garage.", "info"] remoteExec ["ALF_fnc_doMsg",_joueur];

   _garage_Maison_Proche animateSource ["Door_9_sound_source",1];

   private _vehicule = createVehicle [_className, [0,0,500 random 500], [], 0, "CAN_COLLIDE"];
   _vehicule allowDamage FALSE; 
   _vehicule enablesimulation false;

   [{params ["_garage_Maison_Proche"];
      (_garage_Maison_Proche animationsourcePhase "Door_9_sound_source") > 0.95
   },
   {params ["_garage_Maison_Proche","_vehicule","_UID","_plaque","_magasin","_pos_Detection_Veh"];
      _vehicule setPosATL ((_garage_Maison_Proche getrelpos [6,130]) vectoradd [0,0,0]); 
      _vehicule setDir (getdir _garage_Maison_Proche) + 180;
      _vehicule enablesimulation true;
      [_vehicule,true] remoteExecCall ["enableDynamicSimulation",2];      
      _vehicule lockInventory true;
      life_vehicles pushBack _vehicule;

      [_vehicule] spawn {sleep 2; (_this # 0) allowDamage TRUE;};

      private _info_Pos_BDD = [getposatl _vehicule,getdir _vehicule];      
      [_vehicule,_UID,_plaque,_magasin,_info_Pos_BDD] remoteExecCall ["MRPV2_Server_fnc_Vehicule_Configurations",2]; 
   },[_garage_Maison_Proche,_vehicule,getplayeruid _joueur,_plaque,_magasin,_pos_Detection_Veh],10,
   {
      ["Maison", "La porte du garage est défectueuse, contactez les services spécialisés.", "warning"] remoteExec ["ALF_fnc_doMsg",_this # 2];
   }] call CBA_fnc_waitUntilAndExecute;

   _vehicule
};
// };