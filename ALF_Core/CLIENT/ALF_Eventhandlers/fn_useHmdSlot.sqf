/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
private _hmd = hmd player;

if (!(_hmd in murshun_cigs_cigsArray) || {player getVariable ["murshun_cigs_cigLitUp", false]}) exitWith {};

[player] spawn murshun_cigs_fnc_start_cig_your;
