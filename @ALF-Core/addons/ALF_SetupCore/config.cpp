/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/
class CfgPatches 
{
  class ALF_SetupCore 
  {
    fileName = "ALF_SetupCore.pbo";
    author[] = {"Get Your Path"};
    units[] = {};
    weapons[] = {};
    requiredVersion = 1.0;
    requiredAddons[] = {"A3_UI_F"};
  };
};

class CfgFunctions 
{
  class ALF_Core_Init 
  {
    class Init 
    {
      file="\ALF_SetupCore";
      class preInit {preInit=1;};
      class loadFunctions {};
      class postInit {postInit=1;};
    };
  };
};

class Cfg_Server {Serveur_Command_MDP = "MRPV2_Serv_656";};

/*-- Includes --*/
#include "\ALF_Core\SERVER\ALF_Config\Config_Master.hpp"
#include "\ALF_Core\SERVER\Function.hpp"
#include "\ALF_Core\CLIENT\Function.hpp"
#include "\ALF_Core\CfgRemoteExec.hpp"

class ALF_ConfigClient_Core {
	#include "\ALF_Core\SERVER\ALF_Client_Config\ALF_Config_ClientMaster.hpp"
};
