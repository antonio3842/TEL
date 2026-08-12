/*
    File: fn_eboueur_addPosition.sqf
    Author: MRP
    Description: Helper pour récupérer position
    
    OPTIMISATIONS BOHEMIA APPLIQUÉES:
    - Variables déclarées directement
*/

private _pos = getPosATL player;
copyToClipboard format ["    [%1, %2, %3],", round (_pos select 0), round (_pos select 1), _pos select 2];
systemChat format ["Position copiée: [%1, %2, %3]", round (_pos select 0), round (_pos select 1), _pos select 2];
hint "Position copiée!\nCollez-la dans MRP_EBOUEUR_POSITIONS_POUBELLES";