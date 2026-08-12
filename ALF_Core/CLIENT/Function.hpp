/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/

class ALF_CLIENT_CfgFunctions 
{
	class MRPV2_Telephones
	{
    	tag="MRPV2";
    	class Appli_Annuaire 
		{
    		file = "\ALF_Core\CLIENT\MRPV2_Fonctions\Telephone\Appli_Annuaire";
    		class MRP_Tel_Menu_Annuaire_Call_API {};
    		class MRP_Tel_Menu_Annuaire_Crea {};
    		class MRP_Tel_Menu_Annuaire_Crea_Marqueur {};
    		class MRP_Tel_Menu_Annuaire_Gestion_Liste {};
    	};

		class Appli_Bloc_Note 
		{
    		file = "\ALF_Core\CLIENT\MRPV2_Fonctions\Telephone\Appli_Bloc_Note";
    		class MRP_Tel_Menu_Bloc_Crea {};
    		class MRP_Tel_Menu_Bloc_Crea_Modif {};
    		class MRP_Tel_Menu_Bloc_Crea_Nouvelle_Note {};
    		class MRP_Tel_Menu_Bloc_Gestion_Liste_Note {};
    		class MRP_Tel_Menu_Bloc_Gestion_Modif_Note {};
    		class MRP_Tel_Menu_Bloc_Lecture_Note {};
    		class MRP_Tel_Menu_Bloc_Suppr_Note {};
    	};

		class Appli_CA 
		{
    		file = "\ALF_Core\CLIENT\MRPV2_Fonctions\Telephone\Appli_CA";
			class MRP_Tel_Menu_CA_Action_Appel_Effet_Cadre {};
			class MRP_Tel_Menu_CA_Action_Appel_Variables {};
			class MRP_Tel_Menu_CA_Action_Appel {};
			class MRP_Tel_Menu_CA_Action_Arret {};
			class MRP_Tel_Menu_CA_Action_Arret_Effet_Cadre {};
			class MRP_Tel_Menu_CA_Action_Arret_Variables {};
			class MRP_Tel_Menu_CA_Action_Pause {};
			class MRP_Tel_Menu_CA_Action_Pause_Effet_Cadre {};
			class MRP_Tel_Menu_CA_Action_Pause_Variables {};
			class MRP_Tel_Menu_CA_Action_Repondeur {};
			class MRP_Tel_Menu_CA_Ajout_Cadre_Appel {};
			class MRP_Tel_Menu_CA_Crea {};
			class MRP_Tel_Menu_CA_Crea_CG_Actions {};
			class MRP_Tel_Menu_CA_Creation_Options {};
			class MRP_Tel_Menu_CA_Deplac_Cadre {};
			class MRP_Tel_Menu_CA_Gestion_Couleur_Cadre {};
			class MRP_Tel_Menu_CA_Gestion_Duree_Appel {};
			class MRP_Tel_Menu_CA_Gestion_Etat {};
			class MRP_Tel_Menu_CA_Gestion_Reception_Appel {};
			class MRP_Tel_Menu_CA_Suppr_Cadre {};
    	};

		class Appli_Dispatch 
		{
    		file = "\ALF_Core\CLIENT\MRPV2_Fonctions\Telephone\Appli_Dispatch";
			class MRP_Tel_Menu_Dispatch_Crea {};
			class MRP_Tel_Menu_Dispatch_Crea_Options {};
			class MRP_Tel_Menu_Dispatch_Gestion_Frequences {};
			class MRP_Tel_Menu_Dispatch_Gestion_Nombre_Connex_Collegue {};
			class MRP_Tel_Menu_Dispatch_Gestion_Nombre_Ope_Freq {};
			class MRP_Tel_Menu_Dispatch_Suivis_Unites {};
    	};

		class Appli_Radio 
		{
    		file = "\ALF_Core\CLIENT\MRPV2_Fonctions\Telephone\Appli_Radio";
			class MRP_Tel_Menu_Radio_Crea {};
			class MRP_Tel_Menu_Radio_Crea_Cadre_Sauvegarde_Freq {};
			class MRP_Tel_Menu_Dispatch_Gestion_Frequences {};
			class MRP_Tel_Menu_Dispatch_Gestion_Nombre_Connex_Collegue {};
			class MRP_Tel_Menu_Dispatch_Gestion_Nombre_Ope_Freq {};
			class MRP_Tel_Menu_Dispatch_Suivis_Unites {};
    	};

		class Appli_Taxi
		{
			file = "\ALF_Core\CLIENT\MRPV2_Fonctions\Telephone\Appli_Taxi";
			class MRP_Tel_Menu_Taxi_Crea {};
			class MRP_Tel_Menu_Taxi_Gestion_Statut {};
			class MRP_Tel_Menu_Taxi_Action_Appeler {};
		};

		class Divers 
		{
    		file = "\ALF_Core\CLIENT\MRPV2_Fonctions\Telephone\Divers";
			class MRP_NB_Service_Vers_TXT {};
			class MRP_Tel_Divers_Action_Sonnerie {};
			class MRP_Tel_Divers_Action_Verif_Numero_Valide {};
			class MRP_Tel_Divers_Ajout_Retour_Ligne {};
			class MRP_Tel_Divers_Anti_Spam_Bouton {};
			class MRP_Tel_Divers_Appli_Ouverture {};
			class MRP_Tel_Divers_Config_Mess_Transmission_TFAR {};
			class MRP_Tel_Divers_Connexion_TFAR {};
			class MRP_Tel_Divers_Conversion_Nombre_Jour_En_Mot {};
			class MRP_Tel_Divers_Conversion_Nombre_Mois_En_Mot {};
			class MRP_Tel_Divers_Crea_Liste_Nombre_Appel {};
			class MRP_Tel_Divers_Crea_Menu_Bas_Ecran {};
			class MRP_Tel_Divers_Crea_Son {};
			class MRP_Tel_Divers_Debut_Appel_TFAR {};
			class MRP_Tel_Divers_Desac_Raccourcis_TFAR {};
			class MRP_Tel_Divers_Effet_Bouton_Appuyer {};
			class MRP_Tel_Divers_Fin_Appel_TFAR {};
			class MRP_Tel_Divers_Fond_Prompt {};
			class MRP_Tel_Divers_Gestion_Affichage_Duree_Appel {};
			class MRP_Tel_Divers_Gestion_Couleur_Numero {};
			class MRP_Tel_Divers_Gestion_Duree_Appel {};
			class MRP_Tel_Divers_Gestion_Etat_Joueur_En_Appel {};
			class MRP_Tel_Divers_Gestion_Filtrage_Lettres {};
			class MRP_Tel_Divers_Gestion_Formatage_Numero {};
			class MRP_Tel_Divers_Gestion_Intituler {};
			class MRP_Tel_Divers_Gestion_Limite_Nombre_Charactere {};
			class MRP_Tel_Divers_Gestion_Nombre_Appel {};
			class MRP_Tel_Divers_Prise_Service_CA {};
			class MRP_Tel_Divers_Son_Arret_Appel {};
			class MRP_Tel_Divers_Sortis_Dispatch {};
			class MRP_Tel_Divers_Suppr_Ecran {};
			class MRP_Tel_Divers_Suppr_Son {};
			class MRP_Tel_Divers_Suppr_Surcouche_Appel {};
			class MRP_Tel_Divers_Type_Appli {};
			class MRP_Tel_Divers_syncSingleVar {};
    	};

		class Init 
		{
    		file = "\ALF_Core\CLIENT\MRPV2_Fonctions\Telephone\Init";
			class MRP_Tel_Init_Crea_Et_AttachTo {};
			class MRP_Tel_Init_Etat {};
			class MRP_Tel_Init_Fermeture {};
			class MRP_Tel_Init_Gestion_Anim_Affichage {};
			class MRP_Tel_Init_Heure {};
			class MRP_Tel_Init_Joueur_Conf_API_Crea {};
			class MRP_Tel_Init_Joueur_Conf_API {};
			class MRP_Tel_Init_Joueur_Conf {};
			class MRP_Tel_Init_Joueur_Histo_API_Crea {};
			class MRP_Tel_Init_Joueur_Histo_API {};
			class MRP_Tel_Init_Joueur_Histo {};
			class MRP_Tel_Init_Joueur {};
			class MRP_Tel_Init_Keydown {};
			class MRP_Tel_Init_Ouverture {};
		};

		class Menu_Appel 
		{
    		file = "\ALF_Core\CLIENT\MRPV2_Fonctions\Telephone\Menu_Appel";
			class MRP_Tel_Menu_Appel_Action_Bouton {};
			class MRP_Tel_Menu_Appel_Crea {};
			class MRP_Tel_Menu_Appel_Desti_Crea {};
			class MRP_Tel_Menu_Appel_En_Cours_Crea {};
			class MRP_Tel_Menu_Appel_Exped_Crea {};
			class MRP_Tel_Menu_Appel_Expediteur_Num_Speciaux {};
			class MRP_Tel_Menu_Appel_Gestion_Couleur_Bouton_Ajouter {};
			class MRP_Tel_Menu_Appel_Gestion_Repondeur_Service_Speciaux {};
			class MRP_Tel_Menu_Appel_Init_Variables {};
			class MRP_Tel_Menu_Appel_Tentative_Expediteur {};
			class MRP_Tel_Menu_Appel_Demande_Info_Dest {};
			class MRP_Tel_Menu_Appel_Tentative_Expediteur_Protocole_Dilemme {};
		};

		class Menu_Contact 
		{
    		file = "\ALF_Core\CLIENT\MRPV2_Fonctions\Telephone\Menu_Contact";
			class MRP_Tel_Menu_Contact_Ajout_Modif {};
			class MRP_Tel_Menu_Contact_Crea {};
			class MRP_Tel_Menu_Contact_Crea_Liste {};
			class MRP_Tel_Menu_Contact_Gestion_Bouton_OK {};
			class MRP_Tel_Menu_Contact_Lecture_Fiche {};
			class MRP_Tel_Menu_Contact_Lecture_Fiche_Gestion_Contact {};
			class MRP_Tel_Menu_Contact_Modif_Crea {};
		};

		class Menu_Historique
		{
    		file = "\ALF_Core\CLIENT\MRPV2_Fonctions\Telephone\Menu_Historique";
			class MRP_Tel_Menu_Historique_Crea {};
			class MRP_Tel_Menu_Historique_Crea_Liste {};
			class MRP_Tel_Menu_Historique_Gestion_Histo {};
		};

		class Menu_Principal
		{
    		file = "\ALF_Core\CLIENT\MRPV2_Fonctions\Telephone\Menu_Principal";
			class MRP_Tel_Menu_Principal_Action_Retour {};
			class MRP_Tel_Menu_Principal_Crea {};
			class MRP_Tel_Menu_Principal_Crea_Liste_Appli {};
			class MRP_Tel_Menu_Principal_Fond_Ecran {};
			class MRP_Tel_Menu_Principal_Mail {};
			class MRP_Tel_Menu_Principal_Mail_Call_API {};
		};

		class Menu_Reglages
		{
    		file = "\ALF_Core\CLIENT\MRPV2_Fonctions\Telephone\Menu_Reglages";
			class MRP_Tel_Menu_Reglages_Crea {};
			class MRP_Tel_Menu_Reglages_Crea_Fond {};
			class MRP_Tel_Menu_Reglages_Crea_Fond_Sonnerie {};
			class MRP_Tel_Menu_Reglages_Crea_Fond_Sonnerie_Et_Sonnerie {};
			class MRP_Tel_Menu_Reglages_Gestion_Options_Actives {};
		};

		class Menu_SMS
		{
    		file = "\ALF_Core\CLIENT\MRPV2_Fonctions\Telephone\Menu_SMS";
			class MRP_Tel_Menu_Nouveau_SMS_Action_Validation_SMS {};
			class MRP_Tel_Menu_Nouveau_SMS_Crea {};
			class MRP_Tel_Menu_Nouveau_SMS_Crea_Liste {};
			class MRP_Tel_Menu_SMS_Action_Envois {};
			class MRP_Tel_Menu_SMS_Action_Reception {};
			class MRP_Tel_Menu_SMS_Action_Supprimer {};
			class MRP_Tel_Menu_SMS_Crea {};
			class MRP_Tel_Menu_SMS_Crea_Cadre {};
			class MRP_Tel_Menu_SMS_Crea_Cadre_Date {};
			class MRP_Tel_Menu_SMS_Crea_Liste {};
			class MRP_Tel_Menu_SMS_Gestion_Date_Dernier_SMS {};
			class MRP_Tel_Menu_SMS_Gestion_Nombre_SMS {};
			class MRP_Tel_Menu_SMS_Lecture {};
			class MRP_Tel_Menu_SMS_Validation_SMS {};
		};
    };

	class MRPV2_Fonctions
	{
    	tag="MRPV2";

		class Admins 
		{
    		file = "\ALF_Core\CLIENT\MRPV2_Fonctions\Admins";
    		class Admins_Actions {};
    	};

    	class Divers
		{
    		file = "\ALF_Core\CLIENT\MRPV2_Fonctions\Divers";
    		class SetPitchBankYaw {};
    		class Marqueur_Gestion {};
    		class SOS_Depanneur_Activer {};
    		class SOS_Depanneur_Arreter {};
    		class Incendie_FX {};
    		class tempMarker {};
    	};

		class Farming 
		{
    		file = "\ALF_Core\CLIENT\MRPV2_Fonctions\Farming";
    		class Traitement_Artisanat {};
    	};	

		class Farming_Petrole 
		{
    		file = "\ALF_Core\CLIENT\MRPV2_Fonctions\Farming\Petrole";
    		class Petrole_Baril {};
    		class Petrole_Baril_Anim_Pompe {};
    		class Petrole_Baril_Anim_Tremblement {};
    		class Petrole_Baril_Crea {};
    		class Petrole_Baril_Crea_Boutons_Inter {};
    		class Petrole_Baril_Remplissage {};
    	};

		class Interactions 
		{
			file = "\ALF_Core\CLIENT\MRPV2_Fonctions\Interaction";
			class Interaction_Base {};
			class Interaction_Batiments {};
			class Interaction_Maison {};
			class Interaction_Derrick {};
			class Interaction_Distributeur {};
			class Interaction_Scanner_IRM {};

			// PNJ
			class Interaction_PNJ {};
			class Interaction_PNJ_Concessionnaire {};
			class Interaction_PNJ_Cooperative {};
			class Interaction_PNJ_Crime {};
			class Interaction_PNJ_Emplois {};
			class Interaction_PNJ_Entreprise_Joueur {};
			class Interaction_PNJ_Divers {};
			class Interaction_PNJ_Garages {};
			class Interaction_PNJ_GN {};
			class Interaction_PNJ_PM {};			
			class Interaction_PNJ_SP_Hopital {};


			class Interaction_Fauteuil_Roulant {};
			class Interaction_Fonte {};

			// Joueurs	
			class Interaction_Joueurs {};
			class Interaction_Joueurs_APPM {};			
			class Interaction_Joueurs_Civ {};			
			class Interaction_Joueurs_Ent {};			
			class Interaction_Joueurs_GN {};
			class Interaction_Joueurs_PM {};			
			class Interaction_Joueurs_SP {};
			class Interaction_Joueurs_Pref {};

			// Menu
			class Interaction_Menu_Btn_Inter_Creation {};			
			class Interaction_Menu_Btn_Inter_Suppr {};			
			class Interaction_Menu_Btn_Menu_Creation {};
			class Interaction_Menu_Creation {};	

			class Interaction_Citerne_Station_Essence {};
			class Interaction_Objets {};
			class Interaction_Objets_Casino_Machine_A_Sous {};		
			class Interaction_Objets_Transfert_De_Joueur {};
			class Interaction_Objets_Transfert_Vers_Joueur {};
			class RefreshInventoryForContainer {};
			class Interaction_Objets_BRINKS {};
			class Interaction_Tuto {};
			class Interaction_ShopIllegal {};
		};

		class Vehicules 
		{
			file = "\ALF_Core\CLIENT\MRPV2_Fonctions\Vehicules";
			class Vehicule_Achat {};			
			class Vehicule_Creation {};			
			class Vehicule_Creation_Maison {};			
			class Vehicule_Creation_Plaque {};			
			class Vehicule_Fourriere_Entrer {};			
			class Vehicule_Fourriere_Sortir {};
			class Vehicule_Casse {};			
			class Vehicule_Garage_Importer {};	
			class Vehicule_Garage_Liste {};			
			class Vehicule_Garage_Ranger {};			
			class Vehicule_Garage_Sortir {};	
			class Vehicule_Regulateur_Limiteur {};
			class Vehicule_ApplyVehicleDamage {};
			class Vehicule_ApplyVehicleDamage_Delayed {};					
		};

		class dir 
		{
			file = "\ALF_Core\CLIENT\MRPV2_Fonctions\actionsTravaille\dir";
			class reparerDir {};						
		};	
		class Diving
		{
		    file = "\ALF_Core\CLIENT\MRPV2_Fonctions\Diving";
		    class rebreatherLoop {};
			class rebreatherSetRemaining {};
			class rebreatherStation {};
		};	
		class Cambriolage
		{
		    file = "\ALF_Core\CLIENT\MRPV2_Fonctions\cambriolage";
		    class addTempMarker {}; // ALF_fnc_addTempMarker
		};

		// Ajouté par GrosPandaGéant pour MRPV2
		class Licences
		{
		    file = "\ALF_Core\CLIENT\MRPV2_Fonctions\Licences";
		    class civSetLic {};
		};


	};

	class MRPV2_Mapping
	{
		tag="MRPV2";
    	class Mapping
		{
    		file = "\ALF_Core\CLIENT\MRPV2_Mapping";
    		class loadMapping {};
			class unloadMapping {};
			class kolantaPoteaux {};
    	};
	}

	class MRPV2_Event
	{
		tag="MRPV2";
    	class Event
		{
    		file = "\ALF_Core\CLIENT\MRPV2_Event";
    		class openNoelGift {};
			class dropNoelGift {};
    	};
	}

	// rajout de fonction LIFE inexistante
	class LIFE
	{
		tag="LIFE";
    	class Divers
		{
    		file = "\ALF_Core\CLIENT\LIFE_Fonctions";
    		class broadcast {};
    		class calWeightDiff {};
    		class catchFish {};
    		class giveDiff {};
    		class handleInv {};
    		class itemWeight {};
    		class licensesRead {};
    		class searchClient {};
    	};
	}

	class Socket_Reciever 
	{
    	tag="SOCK";
    	class SQL_Socket {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Server\session";
    		class noBDD {};
    		class dataQuery {};
    		class insertPlayerInfo {};
    		class syncData {};
    		class updatePartial {};
    		class updateRequest {};
    		class requestReceived {};
    	};
    };

	class ALFCore_Tools {
		tag = "ALFTools_Client";
		class RemoteExec {
			file="\ALF_Core\CLIENT\ALF_Tools\RemoteExec";
			class receiveRemoteExec {};
			class remoteExec {};
		};

		class Config {
			cTag = "Config"; // ALFTools_Client_Config
			file="\ALF_Core\CLIENT\ALF_Tools\Config";
			class getConfig {};
			class isClass {};
		};
	};

    class ALF_System {
    	tag = "ALF";
    	class Master_Directory {
    		file = "\ALF_Core\CLIENT\ALF_Initializations";
    		class initPlayer {};
    		class setupEVH {};
    		class survival {};
    		class setupKeyBinding {};
			class setupKeyBinding_Mouvements {};
			class setupKeyBinding_Combat {};
			class setupKeyBinding_PNJ {};
			class setupKeyBinding_Vehicules {};
    		class setupKeyBinding_Objets {};
    		class setupKeyBinding_Farming {};
    		class initClient {};
			class configuration {};
            class initKeysTime {};
            class initPNJ {};
    	};

        class Tools {
            file = "\ALF_Core\CLIENT\ALF_Tools";
            class escInterupt {};
            class fetchCfgDetails {};
            class fetchDeadGear {};
            class nearUnits {};
            class numberText {};
            class setFuel {};
            class searchPosEmpty {};
            class DateToString {};
            class say3D {};
            class setVariable {};
            class accType {};
            class stripDownPlayer {};
            class nearestDoor {};
            class clearVehicleAmmo {};
            class pullOutVeh {};
            class fetchVehInfo {};
			class PPEffect {};
			class Nombre_Formatte {};
			
        };

        class Dialog_Controls {
            file = "\ALF_Core\CLIENT\ALF_Dialogs_Functions";
            class garageLBChange {};
            class garageLBChangeCopSP {};
            class garageLBChangeLock {};
            class garageLBChangePenit {};
            class impoundMenu {};
            class impoundMenuCopSP {};
            class impoundMenuLock {};
            class impoundMenuPenit {};
            class sellGarage {};
            class spawnMenu {};
            class unimpound {};
            class unimpoundCopSP {};
            class unimpoundLock {};
            class unimpoundPenit {};
            class vehicleGarage {};
        };

		class SpyGlass {
			file = "\ALF_Core\CLIENT\ALF_Functions\Server\SpyGlass";
			class initSpy {};
			class antiHackALF {};
			class startCompleteLogger {};
		};

		class Meta_Data {
			file="\ALF_Core\CLIENT\ALF_Functions\Player\MetaData";
			class inventoryMetaData {};
		};

		class SmartMarker {
			cTag = "SmartMarker";
			file="\ALF_Core\CLIENT\ALF_Functions\Player\SmartMarker";
			class handleMap {};
			class onMoving {};
			class showDescription {};
			class hideDescription {};
		};

		class Stress {
			file = "\ALF_Core\CLIENT\ALF_Functions\Player\Stress";
			class stress {};
			class stressAdd {};
			class stressRemove {};
			class stressVerify {};
		};

    	class Assurance {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Assurance";
    		class menuAxa {};
    		class btnAxa {};
    		class removeAxaCount {};
    	};

    	class Essence {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Essence";
    		class Citerne_Littrage_Appel {};
    		class pistoletEssence {};
    		class pistoletVehicule {};
            class jerryRefuel {};
            class refuelStation {};
            class refuelCar {};
    	};

    	class Anims {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Animations";
    		class ambientAnim {};
            class knockedOut {};
            class knockoutAction {};
            class tazed {};
            class tazeSound {};
            class switchMove {};
            class animate {};
            class surrender {};
            class animSync {};
            class restrain {};
            class restrainAction {};
            class restrain2Action {};
            class unrestrain {};
            class unrestrain2 {};
            class sitDown {};
            class standUp {};
    	};

        class Objects {
            file = "\ALF_Core\CLIENT\ALF_Functions\Objects";
            class depositItem {};
            class useItemAction {};
            class takeItem {};
            class dropItems {};
            class handleItem {};
            class hideObj {};
            class pushObject {};
            class receiveItem {};
            class revealObjects {};
            class packupSpikes {};
            class pickupMoney {};
            class verifCash {};
            class saisieCash {};
            class saisirThisItem {};
            class pafSmoke {};
        };

		class Traitement {
            file = "\ALF_Core\CLIENT\ALF_Functions\Traitement";
            class processAction {};
			class processImageManager {};
			class processKeyManager {};
			class processBar {};
        };

    	class FireWorks2 {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Objects\FireWorks";
    		class fireworksLaunch {};
    	};

    	class Radar {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Radar";
    		class menuRadarAerien {};
    	};

		class Rental {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Rental";
    		class openBoatRental {};
    		class openCarRental {};
    	};

    	class Barbecue {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Objects\Barbecue";
    		class poseViande {};
    		class barbecue {};
    		class recupViande {};
            class poserBBQ {};
    	};

    	class BIE {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Jobs\BIE";
    		class hasEnergy {};
    		class biePoserPc {};
    		class biePoserC4 {};
    		class bieReparer {};
			class reparerBie {};
    		class bieReparerSystem {};
    		class bieAllumer {};
    		class bieEteindre {};
			class applyLampDamage {};
			class poseGenerator {};
			class connectCable {};
			class initBIE {};
			class actionLamps {};
			class enedis_initMission {};
			class enedis_terminerService {};
			class enedis_payerJoueur {};
			class enedis_getVl {};
			class enedis_delVl {};
    	};

    	class Medical {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Medical";
    		class actionMedicalItems {};
    		class soin {};
    		class medicalItems {};
    		class deadOnBreak {};
    		class stabilize {};
    		class jesusImAlive {};
    		class menuGuardian {};
    		class medHautParleur {};
    		class transfertScanner {};
            class MedService {};
    		class handleDesease {};
    		class handleMedecine {};
    		class transfertFauteuil {};
    		class scannerSystem {};
    		class actionTransfertF {};
    		class porterMort {};
    		class voitureMort {};
    		class drapMort {};
    		class transfertLit {};
    		class genererGroupeSanguin {};
    		class testGroupeSanguin {};
    		class donDuSang {};
            class deathScreen {};
            class medicLoadout {};
            class medicMarkers {};
            class medicRequest {};
            class requestMedic {};
            class respawned {};
            class revived {};
            class revivePlayer {};
			class veto {};
    	};

    	class MedicalV2 {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Menus\medical";
    		class menuMedical1 {};
    		class menuMedical2 {};
    		class menuMedical3 {};
    		class menuComa {};
    		class menuComaClose {};
    	};

    	class Door {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Objects\Door";
    		class teleportDoor {};
    	};

    	class Casino {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Business\Casino";
    		class playMachineSlot {};
    		class returnCoins {};
    		class giveMoneyDance {};
    	};

    	class Blackjack {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Business\Casino\Blackjack";
    		class playBJ {};
    	};

    	class Combats {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Player\Combat";
    		class combat {};
    		class combatEffect {};
            class firstViewCombat {};
            class kickSystem {};
    	};

    	class DynamicObjects {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Objects\dynamicObjects";
    		class object_deploy {};
    		class object_escort {};
    		class object_packup {};
    	};

		class Documents {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Business\Documents";
    		class createDocumentConfirm {};
    		class initDocuments {};
            class documentsListMenu {};
            class resultGet {};
            class createDocumentMenu {};
            class deleteConfirm {};
            class displayDocument {};
            class lbChangedCreateDocument {};
            class lbChangedDocuments {};
            class playerHasDocument {};
    	};

    	class Event {
    		file = "\ALF_Core\CLIENT\ALF_Eventhandlers";
    		class EventHandlers_HandleDown {};
            class getInMan {};
    		class insertMarker {};
    		class insertMarkerOK {};
    		class receiveMarker {};
    		class mainMap {};
    		class useHmdSlot {};
    		class onTake {};
    		class getOutMan {};
    		class seatSwitchedMan {};
    		class mapOpen {};
            class onPlayerKilled {};
            class onPlayerRespawn {};
            class actionKeyHandler {};
            class inventoryClosed {};
            class inventoryOpened {};
            class keyHandler {};
            class createTempGNMarker {};
            class onFired {};
    	};

    	class Prison {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Prison";
    		class menuCraft {};
    		class putInCraft {};
    		class takeInCraft {};
    		class craftItem {};
    		class penitService {};
    		class penitSetLevel {};
    		class couperBarbele {};
    		class adnBarbele {};
    		class penitHautParleur {};
    		class penitSetLic {};
    		class boucleEnPrison {};
    		class menuAllPrisonnier {};
    		class poserSafe {};
    		class poserPiege {};
    	};

    	class Poker {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Business\Casino\Poker";
    		class playPoker {};
    		class recupPokerTexture {};
    	};

    	class Tags {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Objects\Tag";
    		class createTag {};
    		class tag {};
    	};

    	class Reboot {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Server\Reboot";
    		class thunderone {};
    		class thundertwo {};
    		class weathereffect {};
    	};

        class Server {
            file = "\ALF_Core\CLIENT\ALF_Functions\Server";
            class silentGearSave {};
            class loadDeadGear {};
            class loadGear {};
            class saveGear {};
        };

    	class Pompier {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Factions\Pompier";
    		class createRope {};
    		class fireNozzle {};
    		class soignerPompier {};
    		class cnpMenu {};
    		class cnpRetirer {};
    		class cnpDeposer {};
    		class updateCNPList {};
    		class createBrancard {};
    		class createWheelchair {};
    		class trainingFire {};
            class medSetLevel {};
    		class fireIsDone {};
    		class chargerBrancard {};
    		class dechargerBrancard {};
    		class takeOrgane {};
    		class giveOrgane {};
    		class giveOrdonnance {};
    		class updateRope {};
    		class serviceIncendie {};
            class createFeu {};
    	};
		class Fire_Script_V3 {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Factions\Pompier\Fire_Script_V3\functions";
    		class incendie_calculateTrajectory {};
			class incendie_initEH {};
			class incendie_initPlayer {};
			class incendie_initActions {};
			class incendie_remoteHoses {};
			class incendie_deroulerTuyau {};
			class incendie_deroulerDevidoir {};
			class incendie_prendreTuyau {};
			class incendie_lacherTuyau {};
			class incendie_raccorder2Tuyaux {};
			class incendie_deraccorder2Tuyaux {};
			class incendie_raccorderTuyauVehicule {};
			class incendie_raccorderTuyauHydrant {};
			class incendie_raccorderTuyauDivision {};
			class incendie_deraccorderTuyauVehicule {};
			class incendie_deraccorderTuyauHydrant {};
			class incendie_deraccorderTuyauDivision {};
			class incendie_allumerBSL {};
			class incendie_eteindreBSL {};
			class incendie_raccorderLDV {};
			class incendie_deraccorderLDV {};
			class incendie_rangerLDT {};
			class incendie_sortirLDT {};
			class incendie_rangerTuyau {};
			class incendie_changerPressionPompe {};
			class incendie_jetEau {};
			class incendie_capeler {};
			class incendie_decapeler {};
			class incendie_say3D {};
    	};
		class Fire_Script_V3_fdf {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Factions\Pompier\Fire_Script_V3\functions\fdf";
    		class local_delete_fire {};
			class local_fire_1 {};
			class local_fire_2 {};
			class local_fire_3 {};
			class steam_fire {};
    	};

    	class Penits {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Factions\Penits";
    		class cnpmMenu {};
    		class cnpmRetirer {};
    		class cnpmDeposer {};
    		class updateCNPMList {};
    	};

    	class Bank {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Banque";
    		class braquageAgence {};
    		class menuCompteBancaire {};
    		class achatCompteBancaire {};
    		class accessCompteBancaire {};
    		class deposerCompteBancaire {};
    		class retirerCompteBancaire {};
    		class transferCompteBancaire {};
    		class transferExtCompteBancaire {};
    		class afterTransferCompteBancaire {};
    		class badTransferCompteBancaire {};
    		class infoTransferCompteBancaire {};
    		class updateCompteBancaire {};
    		class cbParametre {};
            class handleCB {};
    	};

    	class Interaction {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Interaction";
    		class interactionSystem {};
    		class interactions_create {};
    		// class interactions_player_to_player_basics {};
    		class interactions_player_to_trash {};
    		class interactions_player_to_house {};
    		class interactions_player_to_objects {};
    		class interaction3D {};
    		class interaction3D_Liste_Actions {};
    		class interactionGiveKeyDef {};
    	};
        class Amendes {
            file = "\ALF_Core\CLIENT\ALF_Functions\Factions\Amendes";
            class ticketGive {};
            class ticketGivePenit {};
            class ticketPaid {};
            class ticketPaidPenit {};
            class ticketPay {};
            class ticketPayPenit {};
            class ticketPrompt {};
            class ticketPromptPenit {};
            class ticketAction {};
            class ticketActionPenit {};
        };
        class ServicesPubliques {
            file = "\ALF_Core\CLIENT\ALF_Functions\Factions\ServicesPubliques";
            class pubSetLevel {};
            class prefHautParleur {};
            class publiqueService {};
        };

    	class Business {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Business";
    		class initBusinessPlayer {};
    		class menuBusiness {};
    		class createBusiness {};
    		class btnCreateBusiness {};
    		//class agrandirBusiness {};
    		class deposerBusiness {};
    		class recruterBusiness {};
    		class payerBusiness {};
    		class virerBusiness {};
    		class getPaidBusiness {};
    		class businessGarage {};
    		class unimpoundBusiness {};
    		class impoundMenuBusiness {};
    		class garageLBBusiness {};
    		class BusinessCarShop {};
    		class BusinessCarShopBuy {};
    		class BusinessRangerGarage {};
    		class BusinessStoreVehicle {};
    		class insureBusiness {};
    		class sellGarageBusiness {};
            class payEntreprise {};
            class ticketEntreprise {};
    		class BusinessClothes {};
    		class BusinessGstore {};
    		class BusinessGarageGlitch {};
    		class dialogFisc {};
    		class circuitHautParleur {};
    	};

    	class Mailbox {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Maisons\Mailbox";
    		class menuMailbox {};
    		class recupererMailbox {};
    	};

    	class Internet {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Internet";
    		class menuInternet {};
    		class returnSearchURLDN {};
    		class searchUrl {};
    		class detectingBad {};
    		class knabisList {};
    		class knabisLivraison {};
    		class updateKnabis {};
    		class knabisBuy {};
    		class lbArmurerie {};
    		class addPArmurerie {};
    		class delPArmurerie {};
    		class payerArmurerie {};
    		class payerBM {};
    		class loadLeboncoin {};
    		class loadAnnonceLeboncoin {};
    		class vendreLeboncoin {};
    		class lbLeboncoin {};
    		class annulerLeboncoin {};
    		class achatLeboncoin {};
    		class buyLeboncoin {};
    		class moneyLeboncoin {};
    		class supprimerLeboncoin {};
    	};

    	class Gendarmerie {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Factions\Gendarmerie";
    		class placeCam {};
    		class selectCamera {};
    		class flashRadar {};
            class copBreakDoor {};
            class copHouseOwner {};
            class activerTourRadio {};
            class copSetLevel {};
    		class menuPlaque {};
    		class menuCamera {};
    		class menuSMSSR {};
    		class copHautParleur {};
            class CopService {};
    		class checkSecurityCam {};
    		class recherchePlaque {};
    		class resultPlaque {};
    		class getFlashed {};
    		class placeRadarM {};
    		class radarMenu {};
    		class setRadarM {};
    		class prendreRadarM {};
    		class reprendreRadarM {};
    		class reposerRadarM {};
    		class updateRadarM {};
    		class resetRadarM {};
    		class poserTracker {};
    		class laptopMenu {};
    		class lbChangedLaptop {};
    		class setVehSpeaker {};
    		class onMegaphonePressed {};
    		class onMegaphoneReleased {};
    		class copEnter {};
    		class copStoreVehicle {};
    		class questionBrico {};
    		class copQuestionDealer {};
    		class copHouseMarker {};
    		class adnMobilier {};
            class copRemovemobilier {};
    		class changerIdentitee {};
    		class menuInspectTel {};
    		class menuAjoutBracelet {};
    		class menuMettrePrison {};
    		class flashbang {};
    		class iem {};
    		class stunGrenade {};
    		class poserChargePorte {};
    		class poserPerceuse {};
    		class checkMenotter {};
    		class checkSurrender {};
    		class returnCommand {};
            class copMarkers {};
            class radar {};
            class spikeStripEffect {};
            class spikeStrip {};
    	};
    	class AdnFace {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Factions\Gendarmerie\ADNFACE";
    		class adnMenu {};
    		class adnCreate {};
    		class adnRecherche {};
    		class adnUpdate {};
    		class faceMenu {};
    		class faceCreate {};
    		class faceRecherche {};
    		class faceUpdate {};
    		class getPlayerAdn {};
    		class getPlayerFace {};
    	};
    	class Chien {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Factions\Gendarmerie\Chien";
			class Chien_Au_Pied {};
    		class dogChercherStup {};
    		class dogAttack {};
    		class dogFollowDoucement {};
    		class dogFollowVite {};
    		class dogGetInVehicle {};
    		class dogGetOutVehicle {};
    		class dogSit {};
    		class dogStop {};
    		class getDog {};
    		class deleteDog {};
    	};

    	class Hsbc {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Banque\Hsbc";
    		class menuHsbc {};
    		class achatHsbc {};
    		class accessHsbc {};
    		class deposerHsbc {};
    		class retirerHsbc {};
    		class transferExtHsbc {};
    		class afterTransferHsbc {};
    		class badTransferHsbc {};
    		class infoTransferHsbc {};
    		class updateHsbc {};
    		class conversionHsbc {};
    	};

		class CNG {
			file = "\ALF_Core\CLIENT\ALF_Functions\Banque\CaisseNationaleGendarmerie";
			class cngMenu {};
    		class cngRetirer {};
    		class cngDeposer {};
    		class updateCNGList {};
		};

    	class Dab {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Banque\Dab";
    		class menuDab {};
    		class retirerDab {};
    		class deposerDab {};
    		class updateDab {};
    		class confirmRetrait {};
    		class bag_deposit {};
    		class receiveDABCheck {};
    		class bag_get {};
    		class bag_stock {};
    		class bag_unstock {};
    		class moneyBagHandle {};
    	};

    	class Hud {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Hud";
    		class doCallIn {};
    		class doMsg {};
    		class doSms {};
    		class doGps {};
    		class doCopCall {};
    		class doMedCall {};
    		class doQuickMsg {};
    		class hudSetup {};
    		class showIDcard {};
    		class showPcard {};
    		class doBfmO {};
    		class doBfmCrime {};
    		class doBfmC {};
    	};
    	class YMenu {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Hud\Y";
    		class menuY {};
    		class addXP {};
    		class receiveMoney {};
    		class giveMoney {};
    		class keyGive {};
    		class keyGiveTime {};
    		class keyGiveDef {};
    		class keyDrop {};
    		//class s_onChar {};
    		class s_onCheckedChange {};
    		class s_onSliderChange {};
    		class settingsMenu {};
    		class updateViewDistance {};
    		class annonceBFM {};
    		class bfmCitoyen {};
    		class bfmCaracteres {};

    	};

		class Staff {
			file = "\ALF_Core\CLIENT\ALF_Functions\Server\Staff";
			class adminRevived {};
			class bfmOfficiel {};
            class staff_direct_message {};
			class staff_fast_animation {};
            class staff_freeze {};
            class staff_global_message {};
            class staff_god {};
            class staff_heal_player {};
            class staff_invisible {};
            class staff_map_teleport {};
            class staff_markers {};
            class staff_noclip {};
            class staff_open {};
            class staff_player_info_list {};
            class staff_revive {};
            class staff_search_player_list {};
            class staff_selected_tool {};
            class staff_self_feed {};
            class staff_teleport_to {};
            class staff_teleport_to_me {};
            class staff_userInputDisable {};
		};

        class Staff_cursor {
            file = "\ALF_Core\CLIENT\ALF_Functions\Server\Staff\Cursor";
            class cursor_attachTo {};
            class cursor_cursorTarget {};
        };

		class Staff_Debug {
			file = "\ALF_Core\CLIENT\ALF_Functions\Server\Staff\Debug";
			class debug_open {};
            class debug_init {};
            class debug_exec {};
            class debug_registerClientOwner {};
            class debug_remoteExecClients {};
            class debug_remoteExecGlobal {};
            class debug_remoteExecServer {};
            class debug_saveFields {};
            class debug_updateHistoryButtons {};
		};

        class Licences {
            file = "\ALF_Core\CLIENT\ALF_Functions\Licences";
            class buyHomeLicense {};
            class buyEboueurLicense {};
            class buyTaxiLicense {};
            class buyBusjobLicense {};
			class buyAmbulancierLicense {};
			class buyEnedisLicense {};
            class buyDistribLicense {};
            class buyGunLicense {};
            class buyShipLicense {};
            class buyPilotLicense {};
            class permisMoto {};
			class permisBateau {};
            class permisTruck {};
            class buyLicense {};
            class permisCar {};
            class recupPermis {};
            class copSetLic {};
            class checkPermis {};
            class stagePermis {};
            class actionPoints {};
            class actionPointsAdd {};
            class enleverPoints {};
            class ajouterPoints {};
            class nextPoints {};
            class retirerPermis {};
            class verifParmes {};
            class Parmes {};
            class pilot {};
            class driver {};
        };

    	class Player {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Player";
    		class fadeSound {};
    		class headbag_take_action {};
    		class headbag_put_target {};
    		class headbag_put_action {};
    		class handleAlcool {};
    		class handleDrug {};
            class fouilleAnal {};
    		class contrat_buy {};
    		class paycheck {};
    		class recupIDcard {};
    		class spawnVideo {};
    		class fixUniform {};
            class searchAction {};
    		class deleteKeysTime {};
    		class remonterFaim {};
    		class remonterSoif {};
            class testAlcoolemie {};
            class testStup {};
            class civLoadout {};
            class civMarkers {};
            class handleDamage {};
			class configureTFARVoiceDistance {};
			class placerRubalise {};
			class inventaire {};
			class inventaire_controlleur {};
		class actionFumee {};
			class finFumee {};
    	};

    	class Piano {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Objects\Piano";
    		class customColorMenu {};
    		class openColorMenu {};
    		class openPiano {};
    		class overColorMenu {};
    		class selectedColorMenu {};
    	};

    	class Farming {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Farming";
    		class minageSystem {};
    		class planterMais {};
    		class takeMais {};
    		class woodSystem {};
    		class woodSystemDIR {};
    		class getLookAt {};
    		class couperWeed {};
    		class interactMeth {};
    		class planterWeed {};
    		class planterWeed2 {};
    		class takeWeed {};
    		class puiserPetrole {};
    		class recupererPetrole {};
    		class cocaine {};
			class weedventilation {};
			class playSound3D {};
            class recupBois {};
    		class Anubis {};
    		class farmingVin {};
    		class farmingPinot {};
    		class farmingJusPomme {};
    		class farmingJusFraise {};
    		class farmingJusRaisin {};
    		class farmingXxX {};
    		class transformWhisky {};
    		class farmingPlanche {};
    		class transformPetrol {};
    		class planterTabac {};
    		class takeTabac {};
    		class sechageTabac {};
    		class createCigare {};
    		class createCigarette {};
    		class createjoint {};
    		class createCompoteBanane {};
    		class peche {};
			class pecheBateau {};
			class sandSystem {};
			class takeCanneSucre {};
    		class planterCanneSucre {};
    		class planterGraineRaccourci {};
    	};

    	class Phone {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Phone";
    		class menuForfait {};
    		class updateForfait {};
    		class buyForfait {};
    		class receptionSmsPhone {};
    		class setPhoneNumber {};
    	};

    	class Calling {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Phone\Call";
    		class endCall {};
    		class resetCall {};
    		class ringPlayer {};
    		class callInProgress {};
    		class callTime {};
    		class callForceEnd {};
    		class callSetVolume {};
    		class callDisablePhone {};
    		class callSetSpeaker {};
    	};

    	class Nokia {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Phone\Nokia";
    		class menuNokia {};
    		class addContactNokia {};
    		class deleteContactNokia {};
    		class smsContactNokia {};
    		class sendSmsNokia {};
    		class sendNewSmsNokia {};
    		class replySmsNokia {};
    		class deleteSmsNokia {};
    		class updateSmsNokia {};
    		class lbChangedSmsNokia {};
    		class setViberNokia {};
    		class smsNokia {};
    		class callRecentNokia {};
    		class callContactNokia {};
    		class callCustomNokia {};
    		class smsRecentNokia {};
    	};

    	class iPhone {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Phone\iPhone";
    		class menuiPhone {};
    		class iPhoneCallCustom {};
    		class iPhoneCallContact {};
    		class iPhoneSmsContact {};
    		class iPhoneSmsContactSend {};
    		class iPhoneNewSmsSend {};
    		class iPhoneaddContact {};
    		class iPhonedeleteContact {};
    		class iPhoneMute {};
    		class iPhoneUnmute {};
    		class iPhoneRing {};
    		class iPhoneSetVolume {};
    		class iPhoneSpeakers {};
    		class setiPhoneBackGround {};
    		class setiPhoneDate {};
    		class setiPhoneAnonyme {};
    		class setiPhoneBackGround2 {};
    		class setiPhoneRing {};
    		class setiPhoneViber {};
    		class iPhoneRadioConnect {};
    		class iPhoneRadioDisconnect {};
    		class updateSmsiPhone {};
    		class lbChangedSmsiPhone {};
    		class deleteSmsiPhone {};
    		class iPhoneReplySms {};
    		class iPhoneSmsSend {};
    		class iPhoneCallRecent {};
    		class iPhoneSmsRecent {};
    		class iPhoneTaxiEnsureControls {};
    		class iPhoneTaxiFetchLists {};
    		class iPhoneTaxiGetAvailable {};
    		class iPhoneTaxiMenu {};
    		class iPhoneTaxiCall {};
    	};
    	class Sony {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Phone\Sony";
    		class menuSony {};
    		class setSonyDate {};
    		class setupRadioSony {};
    		class connectRadioSony {};
    		class sonyRadioDisconnect {};
    		class SonySetVolume {};
    		class SonyRadioSetVolume {};
    		class SonyCallCustom {};
    		class SonyCallContact {};
    		class SonyCallRecent {};
    		class SonyUnmute {};
    		class SonyMute {};
    		class SonySpeakers {};
    		class terminateCallCentral {};
    		class joinCallCentral {};
    		class SonyDeleteContact {};
    		class SonyAddContact {};
    		class SonySetStereo {};
    		class SonySendNewSms {};
    		class SonySendSmsContact {};
    		class lbChangedSmsSony {};
    		class updateSmsSony {};
    		class SonySendReplySms {};
    		class SonyPlaque {};
    		class SonyResultPlaque {};
    		class update1FipSony {};
    		class update2FipSony {};
    		class fipSonyRech {};
    		class fipSonyAdd {};
    		class fipSonyLb {};
    		class fipSonyDel {};
    		class createTajSony {};
    		class rechercheTajSony {};
    		class updateTajSony {};
    		class lbChangedTajSony {};
    		class TajSonyDel {};
    		class deleteSmsSony {};
    		class SonyLoadCentral {};
    	};
    	class SonyTaxi {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Phone\SonyTaxi";
    		class SonyTaxi {};
    		class SonyTaxiRefreshMenu {};
    	};
    	class SonyP {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Phone\SonyP";
    		class menuSonyP {};
    		class setSonyPDate {};
    		class setupRadioSonyP {};
    		class connectRadioSonyP {};
    		class SonyPRadioDisconnect {};
    		class SonyPSetVolume {};
    		class SonyPRadioSetVolume {};
    		class SonyPCallCustom {};
    		class SonyPCallContact {};
    		class SonyPCallRecent {};
    		class SonyPUnmute {};
    		class SonyPMute {};
    		class SonyPSpeakers {};
    		class terminateCallCentralP {};
    		class joinCallCentralP {};
    		class SonyPDeleteContact {};
    		class SonyPAddContact {};
    		class SonyPSetStereo {};
    		class SonyPSendNewSms {};
    		class SonyPSendSmsContact {};
    		class lbChangedSmsSonyP {};
    		class updateSmsSonyP {};
    		class SonyPSendReplySms {};
    		class deleteSmsSonyP {};
    		class SonyPLoadCentral {};
    	};
    	class SonyPM {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Phone\SonyPM";
    		class menuSonyPM {};
    		class setSonyPMDate {};
    		class setupRadioSonyPM {};
    		class connectRadioSonyPM {};
    		class SonyPMRadioDisconnect {};
    		class SonyPMSetVolume {};
    		class SonyPMRadioSetVolume {};
    		class SonyPMCallCustom {};
    		class SonyPMCallContact {};
    		class SonyPMCallRecent {};
    		class SonyPMUnmute {};
    		class SonyPMMute {};
    		class SonyPMSpeakers {};
    		class terminateCallCentralPM {};
    		class joinCallCentralPM {};
    		class SonyPMDeleteContact {};
    		class SonyPMAddContact {};
    		class SonyPMSetStereo {};
    		class SonyPMSendNewSms {};
    		class SonyPMSendSmsContact {};
    		class lbChangedSmsSonyPM {};
    		class updateSmsSonyPM {};
    		class SonyPMSendReplySms {};
    		class deleteSmsSonyPM {};
    		class SonyPMLoadCentral {};
    	};

    	class Twitter {
    		file="\ALF_Core\CLIENT\ALF_Functions\Phone\Twitter";
    		class twitterLoadMessages {};
    		class twitterScroll {};
    		class twitterRenderMessages {};
    	};

    	class Bourse {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Banque\Bourse";
    		class checkPrice {};
    		class achatNombre {};
    		class listboxPrice {};
    		class loadlbPrice {};
    		class updateClientBourse {};
    		class returnPrice {};
    	};

    	class Vehicules {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Vehicules";
    		class insureSystem {};
    		class peint_onChar {};
            class pulloutAction {};
            class pulloutActionsp {};
    		class getJobCarClient {};
    		class importVehicle {};
    		class importVehicleCopSP {};
    		class importVehiclePenit {};
            class putInCarsp {};
            class putInCar {};
            class putInFourriere {};
    		class siphonageVehicles {};
    		class getADN {};
    		class setHPD {};
    		class cannabisVehicle {};
    		class cocaineVehicle {};
    		class changerPlaque {};
    		class storeVehicleJob {};
    		class deployerJetSki {};
    		class getPlaque {};
    		class immobiliserVehicle {};
    		class setAirRadio {};
    		class businessTransfertVeh {};
    		class onAirRadioPressed {};
    		class onAirRadioReleased {};
    		class setVehiclesKeys {};
            class addVehicle2Chain {};
            class lockVehicle {};
            class searchVehAction {};
            class storeVehicle {};
            class storeVehicleCopSP {};
            class storeVehiclePenit {};
			class lockCuffedInVehicle {};
            class unlockCuffedInVehicle  {};
            class checkWheelsAndFreeze {};
    		class keyGiveDefBill {};
			class keyGiveDefRemoveVehicle {};
			class updateCashClient {};
    	};
        class Reparations {
            file = "\ALF_Core\CLIENT\ALF_Functions\Vehicules\Reparations";
            class repairCar {};
            class repairHeli {};
            class repairBoat {};
            class repairMoto {};
            class repairTruck {};
            class repairCarWithTruck {};
            class inspectVehicle {};
        };
        class Interactions {
            file = "\ALF_Core\CLIENT\ALF_Functions\Vehicules\Interactions";
            class menuVehicles {};
            class menuPeinture {};
            class btnChangerPlaque {};
            class showCarStats {};
            class showCarBtn {};
            class showHeliStats {};
            class showHeliBtn {};
            class showTruckStats {};
            class showTruckBtn {};
            class showMotoStats {};
            class showMotoBtn {};
            class showBoatStats {};
            class showBoatBtn {};
            class showCivBtn {};
            class showCopBtn {};
            class showMedBtn {};
        };

        class Eboueur {
            file = "\ALF_Core\CLIENT\ALF_Functions\Jobs\Eboueur";
            class viderTrash {};
            class initClientEboueur {};
            class eboueur_ajouterActions {};
            class eboueur_chargerPoubelle {};
            class eboueur_animerVidage {};
            class eboueur_viderCamion {};
            class eboueur_terminerService {};
            class eboueur_transfererOrdures {};
            class eboueur_bloquerOrdures {};
            class eboueur_addPosition {};
			class eboueur_initMission {};
			class eboueur_payerJoueur {};
			class eboueur_rejoindreService {};
        };

        class Taxi {
            file = "\ALF_Core\CLIENT\ALF_Functions\Jobs\Taxi";
            class initClientTaxi {};
            class taxi_resolveVehicle {};
            class taxi_initService {};
            class taxi_endService {};
            class taxi_rangerVehicle {};
            class taxi_payLoop {};
            class taxi_syncCash {};
            class taxi_clientAfterSpawn {};
            class taxi_clientAfterRanger {};
            class taxi_clientAfterOrphanRanger {};
            class taxi_clientAfterEnd {};
            class taxi_missionLoop {};
            class taxi_missionStart {};
            class taxi_missionMonitor {};
            class taxi_missionCleanup {};
            class taxi_missionStop {};
            class taxi_missionUpdateMarkers {};
            class taxi_getRewards {};
            class taxi_showInfoMetier {};
            class taxi_equipServiceUniform {};
            class taxi_restoreCivilianUniform {};
            class taxi_notifyIncomingCall {};
            class taxiPickNearest {};
            class taxiFormatDistance {};
		};
		class Ambulancier {
            file = "\ALF_Core\CLIENT\ALF_Functions\Jobs\Ambulancier";
            class initClientAmbulancier {};
			class ambulancier_terminerService {};
			class ambulancier_initMission {};
			class ambulancier_initService {};
			class ambulancier_donnerOrgane {};
        };

        class LaPoste {
            file = "\ALF_Core\CLIENT\ALF_Functions\Jobs\LaPoste";
            class laposte_fonctions {};
            class laposte_initMission {};
        };

        class Tuto {
            file = "\ALF_Core\CLIENT\ALF_Functions\Tuto";
            class tuto_ensureConfig {};
            class tuto_openMenu {};
            class tuto_onMenuLoad {};
            class tuto_onMenuUnload {};
            class tuto_resolveTexture {};
            class tuto_selectTab {};
        };

        class BusJob {
            file = "\ALF_Core\CLIENT\ALF_Functions\Jobs\BusJob";
            class initClientBusJob {};
            class busjob_prendreService {};
            class busjob_ensureConfig {};
            class busjob_getArretsCoords {};
            class busjob_autoArretLoop {};
            class busjob_stopAutoArret {};
            class busjob_openMenu {};
            class busjob_onMenuLoad {};
            class busjob_onMenuUnload {};
            class busjob_selectLigne {};
            class busjob_ajouterActions {};
            class busjob_validerArret {};
            class busjob_terminerService {};
            class busjob_rangerVehicle {};
            class busjob_endService {};
            class busjob_gpsUpdate {};
            class busjob_payerJoueur {};
            class busjob_clientAfterSpawn {};
            class busjob_clientAfterRanger {};
            class busjob_clientAfterEnd {};
            class busjob_getDepotContext {};
        };

        class Distributeur {
            file = "\ALF_Core\CLIENT\ALF_Functions\Jobs\Distributeur";
            class initClientDistrib {};
            class distrib_isMachine {};
            class distrib_showMapMarkers {};
            class distrib_clearMapMarkers {};
            class distrib_getMarkerColor {};
            class distrib_updateMapMarker {};
            class distrib_getShopItems {};
            class distrib_getStockMax {};
            class distrib_getItemBuyPrice {};
            class distrib_getRestockPay {};
            class distrib_stockEncode {};
            class distrib_getMachineKey {};
            class distrib_getServiceBuyLimit {};
            class distrib_getServiceBuyCount {};
            class distrib_canBuyFromMachine {};
            class distrib_registerServiceBuy {};
            class distrib_initService {};
            class distrib_terminerService {};
            class distrib_restock {};
            class distrib_restockMenu {};
            class distrib_restockClose {};
            class distrib_restockCalcLayout {};
            class distrib_restockRefresh {};
            class distrib_restockOnPlus {};
            class distrib_restockNoItem {};
            class distrib_stockEnsure {};
            class distrib_stockTake {};
            class distrib_countPlayerItem {};
            class distrib_shopOpen {};
            class distrib_restockAdd {};
            class distrib_restockPay {};
            class distrib_rangerVehicle {};
            class distrib_clientAfterSpawn {};
            class distrib_clientAfterRanger {};
            class distrib_clientAfterEnd {};
            class test_licence_distrib {};
        };

    	class dir {
    		file = "\ALF_Core\CLIENT\ALF_Functions\Business\DIR";
    		class dirpc {};
            class bucheronnageDIR {};
            class reparerObjet {};
            class reparerFeuTricolore {};
			class dirMenu {};
    	};

        class House {
            file = "\ALF_Core\CLIENT\ALF_Functions\Maisons";
            class houseConfig {};
            class buyHouse {};
            class buyHouseBusiness {};	
            class getBuildingPositions {};
            class houseMenu {};
            class initHouses {};
            class lightHouse {};
            class sonnetteHouse {};
            class lightHouseAction {};
            class lockHouse {};
            class lockupHouse {};
            class placeDrugSystem {};
            class PlayerInBuilding {};
            class sellHouse {};
			class virerHouse {};
			class bevirerHouse {};
			class createRobberyMarkerClient {};
            class paramSafe {};
            class robberyAlert {}; // ALF_Server_fnc_robberyAlert
            //class monitorHouseDoors {};
        };

        class Mobiliers {
            file = "\ALF_Core\CLIENT\ALF_Functions\Maisons\Mobiliers";
            class setDirMobilier {};
            class placeMobilierAction {};
            class removemobilier {};
            class mobilierMenu {};
            class mobilierInvSearch {};
            class placeMobilier {};
            class MobilierInBuilding {};
            class mobilierInv {};
            class putInMobilier {};
            class takeInMobilier {};
            class mobilierSystem {};
            class addMobilierCopclient {};
        };

        class Criminal {
            file = "\ALF_Core\CLIENT\ALF_Functions\Criminel";
            class lockpick {};
			class braquageStation {};
            class desactiverTourRadio {};
            class buyBFMCrime {};
            class methzone {};
            class mission_buy {};
            class volerArgent {};
            class enleverBracelet {};
			class receleurGetVehicle {};
			class receleurPutVehicle {};
			class gofastGerant {};
			class gofastRemplir {};
			class gofastAssignRevendeur {};
			class gofastDonnerDrogue {};
			class gofastVider {};
        };

        class Chasse {
            file = "\ALF_Core\CLIENT\ALF_Functions\Chasse";
            class gutAnimal {};
			class turtleHold_init {};

        };

        class Shops {
            file = "\ALF_Core\CLIENT\ALF_Functions\Shops";
            class buyClothes {};
            class changeClothes {};
            class clothingFilter {};
            class clothingMenu {};
            class vehicleShop3DPreview {};
            class vehicleColor3DRefresh {};
            class vehicleShopBuy {};
            class vehicleShopBuyCopSP {};
            class vehicleShopBuyPenit {};
            class vehicleShopEnd3DPreview {};
            class vehicleShopInit3DPreview {};
            class vehicleShopLBChange {};
            class vehicleShopMenu {};
            class vehicleShopMenuV2 {};
            class weaponShopBuySell {};
            class weaponShopMenu {};
            class weaponShopSelection {};
            class weaponShopFilter {};
            class dispoVehicle {};
            class itemsVenteMenu {};
            class itemsVenteLoad {};
            class itemsVenteSelection {};
            class itemsVente {};
            class itemsVenteAll {};
            class itemsVenteMenudealer {};
            class itemsVenteLoaddealer {};
            class itemsVentedealer {};
        };
    };
};
