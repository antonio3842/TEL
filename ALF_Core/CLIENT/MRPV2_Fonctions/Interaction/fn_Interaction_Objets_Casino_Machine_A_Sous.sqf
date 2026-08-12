/*
MRPV2_fnc_Interaction_Objets_Casino_Machine_A_Sous = {
private _obj = param [0,objnull];

// ['_obj aggrer' + str(_obj)] remoteExec ['systemchat',0]; // PERF FIX: Debug désactivé
private _liste_Actions = createHashMap;
// ['wwww'] remoteExec ['systemchat',0]; // PERF FIX: Debug désactivé
if (_obj getvariable ["machine_Dispo",TRUE]) then 
{
    private _argent_Machine_Sou = _obj getVariable ["money",0];
    _obj setVariable ["_obj",_obj];
    if (player getVariable ["isemployed",""] isNotequalto "732586454") then 
    {
        private _texte = (["Allumer la machine","Eteindre la machine"] select (_obj getVariable ["isOn",false]));
        private _texte_tooltype = "";
        private _action = 
        {closeDialog 0;
            private _obj = (_this # 0) getVariable ["_obj",objnull];
// ['gggg'] remoteExec ['systemchat',0]; // PERF FIX: Debug désactivé
// ['_this # 0 ' + str(_this # 0)] remoteExec ['systemchat',0]; // PERF FIX: Debug désactivé
            [_obj] spawn
            {params ["_obj"];
                player playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";
// ['cvvvv'] remoteExec ['systemchat',0]; // PERF FIX: Debug désactivé
                sleep 0.5;
// ['_obj ' + str(_obj)] remoteExec ['systemchat',0]; // PERF FIX: Debug désactivé
                _obj setVariable ["isOn",!(_obj getVariable ["isOn",false]),true];
                private _allumer = [1,0] select (_obj animationPhase "light");
                _obj animate ["light",_allumer,true];

                if (_allumer isequalto 1) then
                {
                    playSound3D ["ALF_Client2\sounds\suspens.ogg", _obj, false, (_obj getrelpos [0,0]) vectoradd [0,0,8], 4, 1.5, 25,0.65];

                    {
                        _obj animate [_x,9.955,20];  
                    } foreach ["Rouleau_1","Rouleau_2","Rouleau_3"];
                } else
                {
                    playSound3D ["ALF_Client2\sounds\suspens.ogg", _obj, false, (_obj getrelpos [0,0]) vectoradd [0,0,8], 4, 0.5, 25,0.65];
                };            
            };   
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];        

        if (_argent_Machine_Sou > 0) then 
        {
            private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
            _bouton ctrlShow TRUE;
            _bouton ctrlSetText format ["Récupérer l'argent (%1€)",_argent_Machine_Sou tofixed 0];
            _bouton setVariable ["_obj",_obj];
            _bouton ctrlAddEventHandler ["buttonClick",
            {closeDialog 2;
                private _obj = (_this # 0) getVariable ["_obj",objnull];

                [_obj] spawn 
                {params ["_obj"];
                    player playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";
                    
                    sleep 0.5;

                    private _argent_Machine_Sou = _obj getVariable ["money",0];
                    life_cash = life_cash + _argent_Machine_Sou;
                    _obj setVariable ["money",0,true];

                    playSound3D ["ALF_Client2\sounds\coin_drop.ogg", _obj, false,(_obj getrelpos [-0.2,0]) vectoradd [0,0,8], 4, 0.8, 50,0.65];

                    ["CASINO",format ["Vous avez récupéré %1€ en liquide",_argent_Machine_Sou],"success"] spawn ALF_fnc_doMsg;
                };
            }];
        };
    };

    if ((_obj animationPhase "Piece") isequalto 1) then 
    {
        private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
        _bouton ctrlShow TRUE;
        _bouton ctrlSetText "Récupérer vos gains";
        _bouton setVariable ["_obj",_obj];
        _bouton ctrlAddEventHandler ["buttonClick", 
        {closeDialog 2;
            private _obj = (_this # 0) getVariable ["_obj",objnull];

            [_obj] spawn 
            {params ["_obj"];
                player playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";
                _obj setvariable ["machine_Dispo",nil,true];

                private _gain = _obj getvariable ["gains",0];
                _obj setvariable ["gains",nil,true];

                uiSleep 0.5;

                life_cash = life_cash + _gain;
                
                _obj animate ["Piece", 0];
                _obj animate ["Jeclignote",0];

                playSound3D ["ALF_Client2\sounds\coin_drop.ogg", _obj, false,(_obj getrelpos [-0.2,0]) vectoradd [0,0,8], 4, 0.8, 50,0.65];
                ["CASINO",format ["Vous avez récupéré %1€ en liquide",_gain],"success"] spawn ALF_fnc_doMsg;

                if (_gain isequalto 500000) then
                {
                    private _liste_Joueurs_Proches = (allPlayers select {alive _x AND {_x distance player < 10}}) append {name _x};
                    [name player,getPlayerUID player,"CASINO",format ["a récupéré 500 000€ au casino. Proches 10m : %1",_liste_Joueurs_Proches]] remoteExec ["ALF_Server_fnc_logIt",2];
                };
            };
        }];
    }, 

    if (_obj getVariable ["isOn",TRUE] AND {_obj animationPhase "Piece" isequalto 0 AND {_obj getvariable ["machine_Dispo",TRUE]}}) then 
    {
        {
            if (life_cash >= _x) then 
            {
                private _bouton = (_liste_Boutons select {!ctrlShown _x}) # 0;
                _bouton ctrlShow TRUE;
                _bouton ctrlSetText "Jouer pour " + str _x + " €";
                _bouton setVariable ["_mise",_x];
                _bouton setVariable ["_obj",_obj];
                _bouton ctrlAddEventHandler ["buttonClick", 
                {closeDialog 2;
                    private _obj = (_this # 0) getVariable ["_obj",objnull];
                    private _mise = (_this # 0) getVariable ["_mise",10];

                    [_obj,_mise] call alf_fnc_playMachineSlot;
                    player playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";
                }];
            };
        } foreach [10,100,1000,10000,100000];
    };  
} else
{
    ["CASINO","Un tirage est en cours !","warning"] spawn ALF_fnc_doMsg;
};      

_liste_Actions
};
*/

// OPTIMISE: Suppression de tous les remoteExec systemchat de debug qui causaient du spam reseau
MRPV2_fnc_Interaction_Objets_Casino_Machine_A_Sous = {
private _obj = param [0,objnull];

private _liste_Actions = createHashMap;
if (_obj getvariable ["machine_Dispo",TRUE]) then 
{
    private _piecePhase = _obj animationPhase "Piece";
    private _argent_Machine_Sou = _obj getVariable ["money",0];
    _obj setVariable ["_obj",_obj];
    if (b_20) then
    {
        private _texte = (["Allumer la machine","Eteindre la machine"] select (_obj getVariable ["isOn",false]));
        private _texte_tooltype = "";
        private _action =
        {closeDialog 0;
            private _obj = life_pInact_curObject;
            [_obj] spawn
            {params ["_obj"];
                player playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";
                sleep 0.5;
                _obj setVariable ["isOn",!(_obj getVariable ["isOn",false]),true];
                private _allumer = [1,0] select (_obj animationPhase "light");
                _obj animate ["light",_allumer,true];

                if (_allumer isequalto 1) then
                {
                    playSound3D ["ALF_Client2\sounds\suspens.ogg", _obj, false, (_obj getrelpos [0,0]) vectoradd [0,0,8], 4, 1.5, 25,0.65];

                    {
                        _obj animate [_x,9.955,20];  
                    } foreach ["Rouleau_1","Rouleau_2","Rouleau_3"];
                } else
                {
                    playSound3D ["ALF_Client2\sounds\suspens.ogg", _obj, false, (_obj getrelpos [0,0]) vectoradd [0,0,8], 4, 0.5, 25,0.65];
                };            
            };   
        };

        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];
    };

    if (_piecePhase > 0.9) then 
    {
        private _texte = "Récupérer vos gains";
        private _texte_tooltype = "Récupérer vos gains";
        private _action = 
        {
            closeDialog 0;
            private _obj = life_pInact_curObject;
            [_obj] spawn
            {params ["_obj"];
                player playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";
                _obj setvariable ["machine_Dispo",nil,true];

                private _gain = _obj getvariable ["gains",0];
                _obj setvariable ["gains",nil,true];

                uiSleep 0.5;

                life_cash = life_cash + _gain;
                private _money = _obj getVariable ["money",0];
                _obj setVariable ["money", (_money - _gain) max 0, true];
                [20, _gain] remoteExec ["ALF_Server_fnc_withdrawCapitalBySecteur", 2];

                _obj animate ["Piece", 0];
                _obj animate ["Jeclignote",0];

                playSound3D ["ALF_Client2\sounds\coin_drop.ogg", _obj, false,(_obj getrelpos [-0.2,0]) vectoradd [0,0,8], 4, 0.8, 50,0.65];
                ["CASINO",format ["Vous avez récupéré %1€ en liquide",_gain],"success"] spawn ALF_fnc_doMsg;

                if (_gain isequalto 500000) then
                {
                    private _joueurs_Proches = allPlayers select {alive _x AND {_x distance _obj < 10}};
                    private _joueurs_A_Notifier = _joueurs_Proches - [player];
                    if (_joueurs_A_Notifier isNotEqualTo []) then {
                        ["CASINO",format ["%1 vient de gagner 500 000€ à la machine à sous !",name player],"warning"] remoteExec ["ALF_fnc_doMsg",_joueurs_A_Notifier];
                    };

                    private _liste_Joueurs_Proches = (_joueurs_Proches apply {name _x}) joinString ", ";
                    [name player,getPlayerUID player,"CASINO",format ["a récupéré 500 000€ au casino. Proches 10m : %1",_liste_Joueurs_Proches]] remoteExec ["ALF_Server_fnc_logIt",2];
                };
            };
        };
        _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
        _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
        _liste_Actions set ["",_liste_Sous_Actions];
    };

    if !(_obj getVariable ["isOn",false]) exitWith {
        if !(b_20) then {["CASINO","Cette machine est éteinte.","danger"] spawn ALF_fnc_doMsg;};
    };

    if (_piecePhase <= 0.9 AND {_obj getvariable ["machine_Dispo",TRUE]}) then
    {
        {
            private _mise = _x;
            private _texte = "Jouer pour " + str _mise + " €";
            private _texte_tooltype = "Jouer à la machine à sous";
            private _action = compile format ["
                closeDialog 0;
                private _obj = life_pInact_curObject;
                [_obj,%1] call alf_fnc_playMachineSlot;
                player playMove 'AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon';
            ", _mise];
            _liste_Sous_Actions = _liste_Actions getOrDefault ["",[]];
            _liste_Sous_Actions pushback [_texte,_texte_tooltype,_action];
            _liste_Actions set ["",_liste_Sous_Actions];
        } foreach [10,100,1000,10000,100000];
    };  
} else
{
    ["CASINO","Un tirage est en cours !","warning"] spawn ALF_fnc_doMsg;
};      

_liste_Actions
};

