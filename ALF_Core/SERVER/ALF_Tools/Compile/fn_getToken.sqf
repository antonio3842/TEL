/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
if !(isServer) exitWith {};

private _v = params[
	["_scriptToken", "", [""]]
];

if !(_v) exitWith {};
if (isNil "ALF_SecretNumber") exitWith {};

private _i = [];
{
	_i pushBack (sqrt (_x - ALF_SecretNumber));
}forEach (toArray _scriptToken);

toString _i;
