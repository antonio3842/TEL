/*
    GET YOUR PATH
    Code written by Association law 1901 "GET YOUR PATH" (RNA W252007073)
    Statement from the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403
    @Copyright GET YOUR PATH (https://www.getyourpath.fr)
    YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
    More informations : https://www.bistudio.com/community/game-content-usage-rules
    Contact : kainnon@getyourpath.fr
*/
if (ALF_Stress > 100) exitWith {ALF_Stress = 100;};
if (ALF_Stress < 0) exitWith {ALF_Stress = 0;};
profileNamespace setVariable ["alf_stress",ALF_Stress];