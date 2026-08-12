// Fichier : fn_Citerne_Littrage_Appel.sqf  
// Auteurs  : NorX Aengell & ARMA 3 Script GPT  
// Fonction : ALF_fnc_Citerne_Littrage_Appel  
// Description : Vérifie la quantité de liquide dans une citerne de station-service et affiche l'information au joueur.  
// ALF_fnc_Citerne_Littrage_Appel = {
private _action = param [0, ""];

[  
    {  
        player getVariable ["MRPV2_Station_Citerne_Littrage",[]] isNotEqualTo [];  
    },  
    {params ["_action","_citerne"];
        private _donnees_Citerne = player getVariable ["MRPV2_Station_Citerne_Littrage",[]];  

        if (isNull _citerne) exitWith  
        {  
            ["CITERNE", "Aucune citerne n'a été trouvée.", "warning"] spawn ALF_fnc_doMsg;  
            player setVariable ["MRPV2_Station_Citerne_Littrage", nil];  
        };  

        private _pos_Citerne = getPosATL _citerne; 
        private _citerne_Trouvee = false;  
        private _id_Citerne = 0;  
        private _litre_Citerne = 0;  

        { 
            private _pos_BDD = parsesimplearray (_x # 0);

            if ((_pos_BDD distance2D _pos_Citerne) < 50) exitWith  
            {
                _litre_Citerne = _x # 1;  
                private _liquide_Citerne = [_litre_Citerne] call ALF_fnc_nombre_Formatte;  

                if (_action isNotEqualTo "Remplissage") then  
                {  
                    ["CITERNE", format ["La citerne contient %1L sur 3 000L.", _liquide_Citerne], "info"] spawn ALF_fnc_doMsg;  
                };  

                _citerne_Trouvee = true;  
            };  
        } forEach _donnees_Citerne;  

        player setVariable ["MRPV2_Station_Citerne_Littrage", nil];  

        if !(_citerne_Trouvee) then  
        {  
            [_citerne] remoteExec ["MRPV2_Server_fnc_Littrage_Creation_Citerne_BDD", 2];

            if (_action isEqualTo "Remplissage") then
            {
                ["CITERNE", "La citerne est déjà remplie à 3 000L.", "warning"] spawn ALF_fnc_doMsg;  
            } else
            {
                ["CITERNE", "La citerne contient 3 000L.", "info"] spawn ALF_fnc_doMsg; 
            };
        }  
        else  
        {  
            if (_action isEqualTo "Remplissage") then  
            {
                if (_litre_Citerne >= 3000) exitWith {["CITERNE", "La citerne est déjà remplie à 3 000L.", "warning"] spawn ALF_fnc_doMsg;};

                [50,_citerne,player,getposatl _citerne] remoteExecCall ["ALF_Server_fnc_updateStation",2];

                ["ALF_Barile_Station", false] spawn ALF_fnc_handleItem;

                ["CITERNE", format ["La citerne contient maintenant %1L sur 3 000L.",_litre_Citerne + 50 min 3000], "success"] spawn ALF_fnc_doMsg; 

                private _prix_Barile = ["ALF_Barile_Station"] call ALF_fnc_returnPrice;  
                life_cash = life_cash + _prix_Barile;  
                [0] call SOCK_fnc_updatePartial;
            };  
        };  
    },
    [_action,cursorObject],2,  
    {          
        ["CITERNE", "La jauge de la citerne semble défectueuse. Revérifier et signalez-le à la préfecture si confirmé.", "warning"] spawn ALF_fnc_doMsg;
        player setVariable ["MRPV2_Station_Citerne_Littrage", nil];   
    }
] call CBA_fnc_waitUntilAndExecute;
// };