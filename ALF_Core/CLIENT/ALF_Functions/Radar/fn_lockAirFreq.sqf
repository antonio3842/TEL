/*
  File: fn_lockAirFreq.sqf
  Author: ALF Core Assistant

  Description:
  Force la radio TFAR du joueur sur la fréquence 123.450
  tant qu'il est dans un véhicule de classe "Air" (hélico, avion...).
  Si le joueur n’est ni policier ni médecin, la fréquence est verrouillée.
  Quand il sort, tout redevient normal.
*/
/*
  Force la radio sur 123450 tant que le joueur est dans un véhicule isKindOf "Air".
  Version alignée sur votre logique de connexion (fréquence 6 chiffres, vars ALF_iPhone_Freq, iPhoneRadioFreq).
*/

if (!hasInterface) exitWith {};
if (!isNil "ALF_airFreqThread") exitWith {};

ALF_airFreqThread = [] spawn {
  private _freqNum = 123450;     // <-- format 6 chiffres (ex: "123450"), comme dans vos scripts
  private _locked  = false;

  while {true} do {
    uiSleep 0.75;

    private _veh = vehicle player;
    private _inAir = (_veh != player) && { _veh isKindOf "Air" };

    // Exemptions : FDO / SAMU
    private _isCop   = (missionNamespace getVariable ["life_copLevel",0]) > 0;
    private _isMedic = (missionNamespace getVariable ["life_medicLevel",0]) > 0;

    private _mustLock = _inAir && {!_isCop} && {!_isMedic};

    if (_mustLock) then {
      // --- "Allumer" la radio selon votre principe ---
      // (on ne touche pas à vos contrôles UI ni aux verifs de forfait ici)
      life_radio_connected = true;
      player setVariable ["tf_unable_to_use_radio", false];

      // Stockage côté framework (comme dans vos connecteurs)
      ALF_iPhone_Freq = _freqNum;
      player setVariable ["iPhoneRadioFreq", _freqNum];

      // Radio TFAR active (si présente)
      private _radio = call TFAR_fnc_activeSwRadio;
      if (!isNil "_radio") then {
        // Ecrase toutes les fréquences SW (1..8) -> verrouillage strict
        for "_ch" from 1 to 8 do {
          [_radio, _ch, _freqNum] call TFAR_fnc_SetChannelFrequency;
        };
      };

      if (!_locked) then {
        player setVariable ["ALF_airFreqLocked", true];
        ["INFO","Fréquence aérienne imposée : 123.450","info"] spawn ALF_fnc_doMsg;
        _locked = true;
      };
    } else {
      if (_locked) then {
        player setVariable ["ALF_airFreqLocked", false];
        ["INFO","Vous avez quitté l’aéronef : fréquence déverrouillée.","success"] spawn ALF_fnc_doMsg;
        _locked = false;
      };
    };
  };
};
