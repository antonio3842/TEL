/*
	File: fn_taxi_showInfoMetier.sqf
	Client — tutoriel métier taxi (popup PNJ).
*/
private _msg = "
1. Prenez votre service et récupérez votre taxi.<br/><br/>
2. <t color='#FFCC00'>Rouler pour gagner</t> : en conduisant votre taxi, vous êtes payé tous les <t color='#FFCC00'>2 km</t> (y compris pendant une course client). Le montant augmente avec le nombre d'habitants sur l'île.<br/><br/>
3. <t color='#FFCC00'>Missions clients</t> : environ toutes les <t color='#FFCC00'>10 minutes</t>, une mission apparaît sur la carte. Allez chercher le client (zone jaune, arrêt <t color='#FFCC00'>3 secondes</t>), puis déposez-le à destination (zone verte, arrêt 3 secondes). La récompense augmente avec le nombre d'habitants sur l'île.<br/><br/>
4. <t color='#FFCC00'>Courses pour les habitants</t> : transportez les clients de l'île d'un point à un autre pour compléter votre activité en fixant vos tarifs.<br/><br/>
5. Rangez votre taxi avant de terminer votre service.
";

[
	parseText _msg,
	"Métier taxi — Informations",
	"OK",
	"",
	false
] call BIS_fnc_guiMessage;
