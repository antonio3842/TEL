/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
class Documents_Documents_List {
   idd = 4510;
   name = "Documents_Documents_List";
   movingenable = 0;
   enablesimulation = 1;
   onload = "[] spawn ALF_fnc_documentsListMenu;";
   class controlsBackground
   {
       class Fond : Life_RscPicture
       {
           idc = 4511;
           text = "";
           x = 0.286979166666667 * safezoneW + safezoneX;
           y = 0.110127826941986 * safezoneH + safezoneY;
           w = 0.4296875 * safezoneW;
           h = 0.779744346116028 * safezoneH;
       };
       class option : Life_RscPicture
       {
           idc = 4531;
           text = "";
           x = 0.6890625 * safezoneW + safezoneX;
           y = 0.31106247122525 * safezoneH + safezoneY;
           w = 0.025 * safezoneW;
           h = 0.0477085892306467 * safezoneH;
       };
   };
   class controls
   {
       class create_document : Life_RscButtonInvisible
       {
           idc = 4512;
           onbuttonclick = "closeDialog 0; createDialog ""Documents_Create_Document"";";
           x = 0.287187 * safezoneW + safezoneX;
           y = 0.668675889516655 * safezoneH + safezoneY;
           w = 0.138333833333333 * safezoneW;
           h = 0.03284763211887 * safezoneH;
       };
       class received_documents : Life_RscButtonInvisible
       {
           idc = 4513;
           text = "";
           onbuttonclick = "[(getPlayerUID player)] remoteExec [""ALF_fnc_getDocuments"",2];";
           x = 0.287187 * safezoneW + safezoneX;
           y = 0.702691113113232 * safezoneH + safezoneY;
           w = 0.069063 * safezoneW;
           h = 0.0417974434611603 * safezoneH;
       };
       class sended_documents : Life_RscButtonInvisible
       {
           idc = 4514;
           text = "";
           onbuttonclick = "[(getPlayerUID player)] remoteExec [""ALF_fnc_getMyDocuments"",2];";
           x = 0.356978666666666 * safezoneW + safezoneX;
           y = 0.702691113113232 * safezoneH + safezoneY;
           w = 0.069063 * safezoneW;
           h = 0.0417974434611603 * safezoneH;
       };
       class documents_list : Life_RscListBox
       {
           idc = 4515;
           text = "";
           sizeex = 0.035;
           onlbselchanged = "_this spawn ALF_fnc_lbChangedDocuments;";
           x = 0.296562 * safezoneW + safezoneX;
           y = 0.323171587297578 * safezoneH + safezoneY;
           w = 0.119063 * safezoneW;
           h = 0.332649950835792 * safezoneH;
       };
       class retrieve_doc : Life_RscButtonInvisible
       {
           idc = 4516;
           text = "";
           onbuttonclick = "[] spawn ALF_fnc_retrieveDocument;";
           x = 0.513020833333333 * safezoneW + safezoneX;
           y = 0.658527453792125 * safezoneH + safezoneY;
           w = 0.061666666666667 * safezoneW;
           h = 0.0375486725663715 * safezoneH;
       };
       class temp : Life_RscButtonInvisible
       {
           idc = 4517;
           text = "";
           onbuttonclick = "closeDialog 0; [] spawn ALF_fnc_showTemporaryDocument;";
           x = 0.688541666666667 * safezoneW + safezoneX;
           y = 0.307433501518238 * safezoneH + safezoneY;
           w = 0.028125 * safezoneW;
           h = 0.0525019132408432 * safezoneH;
       };
       class toTxt00 : Life_RscStructuredText
       {
           idc = 1001;
           text = "";
           x = 0.453125 * safezoneW + safezoneX;
           y = 0.468512921618013 * safezoneH + safezoneY;
           h = 0.0275319567354966 * safezoneH;
           w = 0.188541666666667 * safezoneW;
           shadow = 0;
       };
       class toTxt0 : Life_RscStructuredText
       {
           idc = 1000;
           text = "";
           x = 0.453125 * safezoneW + safezoneX;
           y = 0.432356879753122 * safezoneH + safezoneY;
           h = 0.0275319567354966 * safezoneH;
           w = 0.188541666666667 * safezoneW;
           shadow = 0;
       };
       class information : Life_RscStructuredText
       {
           idc = 4520;
           text = "";
           x = 0.453125 * safezoneW + safezoneX;
           y = 0.51 * safezoneH + safezoneY;
           h = 0.125423422728646 * safezoneH;
           w = 0.190625 * safezoneW;
           shadow = 0;
       };
       class status : Life_RscStructuredText
       {
           idc = 4521;
           text = "";
           x = 0.453125 * safezoneW + safezoneX;
           y = 0.320198346465071 * safezoneH + safezoneY;
           h = 0.0251284374779083 * safezoneH;
           w = 0.188541666666667 * safezoneW;
           shadow = 0;
       };
       class fromtxt : Life_RscStructuredText
       {
           idc = 4523;
           text = "";
           x = 0.453125 * safezoneW + safezoneX;
           y = 0.355402913544043 * safezoneH + safezoneY;
           h = 0.0275319567354966 * safezoneH;
           w = 0.188541666666667 * safezoneW;
           shadow = 0;
       };
       class send : Life_RscButtonInvisible
       {
           idc = 4524;
           text = "";
           onbuttonclick = "[] spawn ALF_fnc_sendTemporaryDocument;";
           x = 0.513020833333333 * safezoneW + safezoneX;
           y = 0.696 * safezoneH + safezoneY;
           w = 0.124479166666667 * safezoneW;
           h = 0.0375486725663715 * safezoneH;
       };
       class toTxt : Life_RscStructuredText
       {
           idc = 4525;
           text = "";
           x = 0.453125 * safezoneW + safezoneX;
           y = 0.39346190498077 * safezoneH + safezoneY;
           h = 0.0275319567354966 * safezoneH;
           w = 0.188541666666667 * safezoneW;
           shadow = 0;
       };
       class title : Life_RscStructuredText
       {
           idc = 4530;
           text = "";
           x = 0.287187 * safezoneW + safezoneX;
           y = 0.248139872602625 * safezoneH + safezoneY;
           h = 0.0618030389102196 * safezoneH;
           w = 0.431042166666667 * safezoneW;
           shadow = 0;
       };
       class delete : Life_RscButtonInvisible
       {
           idc = 1002;
           text = "";
           onbuttonclick = "[] spawn ALF_fnc_deleteConfirm;";
           x = 0.576041666666666 * safezoneW + safezoneX;
           y = 0.658527453792125 * safezoneH + safezoneY;
           w = 0.0614583333333333 * safezoneW;
           h = 0.0375486725663715 * safezoneH;
       };
   };
};
