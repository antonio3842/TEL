/*
    GET YOUR PATH
    Code written by Association law 1901 "GET YOUR PATH" (RNA W252007073)
    Statement from the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403
    @Copyright GET YOUR PATH (https://www.getyourpath.fr)
    YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
    More informations : https://www.bistudio.com/community/game-content-usage-rules
    Contact : kainnon@getyourpath.fr

	Return : New item className
*/

class ALF_Config_SmartMarker {

    ALF_ConfigToClient_Patern[] = {
        {"defaultCursorType", "ARRAY"},
        {"cursorType", "ARRAY"},
        {"bigPopup", "STRING"},
        {"smallPopup", "STRING"},
        {"dataPath", "STRING"},
        {"ANY", "CLASS", {
            {"isSmallPopup", "NUMBER"},
            {"isSpecific", "NUMBER"},
            {"title", "STRING"},
            {"color", "ARRAY"},
            {"type", "STRING"},
            {"hours", "STRING"},
            {"description", "STRING"},
            {"masterType", "STRING"},
            {"mastertypeIcon", "STRING"},
            {"owner", "STRING"},
            {"buissinessName", "STRING"}
        }}
    };


    defaultCursorType[] = {"Track", "Track"};
    cursorType[] = {"Track", "3DENSelectWidgetZ"};
    bigPopup = "ALF_SmartMarker";
    smallPopup = "ALF_SmartMarker_Small";
    dataPath = "\ALF_UI\Data\SmartMarker";

    class champ_pomme {
        isSmallPopup = 0;

        isSpecific = 0;
        title = "Champ de pomme";
        color[] = {1,1,1,1};
        type = "Lieu public";
        hours = "24h/24h";

        /* -- Only if big popup -- */
        description = "Champ de pomme public. Ici vous pouvez les récolter pour ensuite les revendre ou les mangers";
        masterType = "Administration publique";
        mastertypeIcon = "SmartMarker_MT_Public.paa";
        owner = "Pas de propriétaire";

        /* -- Only if is buissiness -- */
        buissinessName = "";
    };

    class champ_peche:champ_pomme {
        isSmallPopup = 1;
        title = "Champ de pêche";
        description = "Champ de pêche public. Ici vous pouvez les récolter pour ensuite les revendre ou les mangers";
    };
};