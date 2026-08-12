/*

Copyright 2023

Association law 1901 "GET YOUR PATH" registred under the RNA W252007073.

Statement form the journal-officiel.gouv.fr : https://www.journal-officiel.gouv.fr/pages/associations-detail-annonce/?q.id=id:202300270403

More information at kainnon@getyourpath.fr

All rights reserved.

*/

class ALF_SERVER_CfgFunctions 
{
	class MRP_Fonctions
	{
    	tag="MRPV2_Server";

		class Admins 
		{
			file = "\ALF_Core\SERVER\MRPV2_Fonctions\Admins";
			class Admins_Actions {};
		};

    	class Vehicules 
		{
    		file = "\ALF_Core\SERVER\MRPV2_Fonctions\Vehicules";
    		class Vehicule_Configurations {};
			class Vehicule_Garage_Importer_BDD {};
			class Vehicule_Garage_Exporter_BDD {};
			class Vehicule_Garage_Ranger_BDD {};
    		class Vehicule_Gestion_Dispo_Et_Ajout_BDD {};
    		class Vehicule_Inventaire_Chargement {};
    		class Vehicule_Inventaire_Sauvegarde {};
		};

		class Essence 
		{
			file = "\ALF_Core\SERVER\MRPV2_Fonctions\Essence";
			class Littrage_Citerne_Vers_Client {};
			class Littrage_Client_Vers_Citerne_BDD {};
			class Littrage_Creation_Citerne_BDD {};
		};

		class Divers 
		{
			file = "\ALF_Core\SERVER\MRPV2_Fonctions\Divers";
			class Divers_Init_Var_Heure_Session {}; 
			class Divers_Lock_Serv {preInit=1;};
			class Divers_Objets_Carte_En_Objet_Simple {};	
			class Divers_Inventaire_Autorisation {};	
			class Divers_Recup_Liste_Maison_Joueur {};			
		};
		class Diving
		 {
		    file = "\ALF_Core\SERVER\MRPV2_Fonctions\Diving";
		    class rebreatherRequest {};
		    class rebreatherSave {};
		};
		class Event
		 {
		    file = "\ALF_Core\SERVER\MRPV2_Fonctions\Event";
		    class startNoelServer {};
		};			
	};

	class ALFCore_Functions {
		tag = "ALFCore";
		class Init {
			file="\ALF_Core\SERVER\ALF_Initialization";
			class initServer {postInit=1;};
			class initFunctions {};
			class initConfig {};
			class checkOnConnect {};
			class initClientConfig {};
		}
		class Farming {
			file="\ALF_Core\SERVER\ALF_Functions\Farming";
			class ALF_Dealer {};
			class ALF_Eggs {};
		};
		class Request {
			file="\ALF_Core\SERVER\ALF_Request";
			class startRequests {};
			class checkRequests {};
			class convertArgsRequest {};
			class sendRequest {};
		};
	};
	/*
	class ALFCore_Requests_Receive {
		tag = "ALFCore_Request_R";

		class POST {
			file="\ALF_Core\SERVER\ALF_Request\RECEIVE\POST";
			cTag = "P"; // ALFCore_Request_R_P
			class toogleMaintenance {};
			class banPlayer {};
			class kickPlayer {};
		};
		class GET {
			file="\ALF_Core\SERVER\ALF_Request\RECEIVE\GET";
			cTag = "G"; // ALFCore_Request_R_G

			class getUserInfos {};
			class getUserBan {};
		};
	};

	class ALFCore_Requests_Send {
		tag = "ALFCore_Request_S";

		class POST {
			file="\ALF_Core\SERVER\ALF_Request\SEND\POST";
			cTag = "P"; // ALFCore_Request_S_P
		};
		class GET {
			file="\ALF_Core\SERVER\ALF_Request\SEND\GET";
			cTag = "G"; // ALFCore_Request_S_G
		};
	};
	*/
	class ALFCore_Tools {
		tag = "ALFTools_Server";
		class Other {
			file="\ALF_Core\SERVER\ALF_Tools";
			class convertDate {};
		};
		class Compile {
			file="\ALF_Core\SERVER\ALF_Tools\Compile";
			class compileClient {};
			class getToken {};
		};
		class RemoteExec {
			file="\ALF_Core\SERVER\ALF_Tools\RemoteExec";
			class receiveRemoteExec {};
			class remoteExec {};
		};
		class Admin {
			file="\ALF_Core\SERVER\ALF_Tools\Admin";
			class kick {};
			class ban {};
			class checkBan {};
			class toogleMaintenance {};
			class isAdmin {};
		};
		class MetaData {
			cTag = "MD"; // ALFTools_Server_MD
			file="\ALF_Core\SERVER\ALF_Tools\MetaData";
			class updateGear {};
			class unpackGear {};
		};

		class MetaData_Tool {
			cTag = "MD_T"; // ALFTools_Server_MD_T
			file="\ALF_Core\SERVER\ALF_Tools\MetaData\Tools";
			class getNewItem {};
			class getNextItemClass {};
			class getDefaultClassName {};
			class createNewItem {};
			class checkMetaData {};
			class modifyData {};
			class packData {};
		};
	};

	class TON_System {
		tag = "TON";
		class Systems {
			file = "\ALF_Core\SERVER\ALF_Functions\Systems";
			class clientDisconnect {};
			class adminInvisible {};
		};
		class Reboot {
			file = "\ALF_Core\SERVER\ALF_Functions\Server\Reboot";
			class thunderbolt {};
			class hunt {};
		};
	};

	class ALF_Server
	{
		tag = "ALF_Server";
		class Essence
		{
			file = "\ALF_Core\SERVER\ALF_Functions\Essence";
			class fuelVehicule {};
			class updateStation {};
		};

		class General
		{
			file = "\ALF_Core\SERVER\ALF_Functions\General";
			class FirstJoinServer {};
			class playTime {};
			class updateCNPM {};
		};

		class Events {
            file = "\ALF_Core\SERVER\ALF_Functions\Events";
	        class wreckEventStart {};
	        class wreckSpawn {};
			class dirObjSpawn {};
			class dirObjEventStart {};
			class pafFlyover {};
			class EnedisEventStart {};
			class enedisSpawn {};
        };

		class Jobs {
			file = "\ALF_Core\SERVER\ALF_Functions\Jobs";
			class jobTime {};
		};

		class Server {
			file = "\ALF_Core\SERVER\ALF_Functions\Server";
			class queryRequest {};
			class updatePartial {};
			class cleanupRequest {};
			class savePlayerDisconnect {};
			class updateRequest {};
			class setVariableServer {};
			class saveGear {};
		};

		class Chasse {
			file = "\ALF_Core\SERVER\ALF_Functions\Chasse";
			class huntingZone {};
		};

		class Objects {
			file = "\ALF_Core\SERVER\ALF_Functions\Objects";
			class pickupAction {};
		};

		class MySQL {
			file = "\ALF_Core\SERVER\ALF_Functions\Server\MySQL";
			class asyncCall {};
			class bool {};
			class mresArray {};
			class mresString {};
			class mresToArray {};
			class numberSafe {};
		};
		
		class Pompier
		{
			file = "\ALF_Core\SERVER\ALF_Functions\Factions\Pompier";
			class startEventFire {};
			class checkSoin {};
			class startEventOrgane {};
			class listCNP {};
			class retirerCNP {};
			class deposerCNP {};
			class updateCNP {};
			class initCNP {};
			class cocaineInFire {};
			class initBanqueSang {};
			class saveBanqueSang {};
		};

		class Factions {
			file = "\ALF_Core\SERVER\ALF_Functions\Factions";
			class countService {};
			class doMedCall {};
			class doCopCall {};
			class doCopCallWL {};
			class doPenitCall {};
			class doRobberyCall {};
		};

		class Penits
		{
			file = "\ALF_Core\SERVER\ALF_Functions\Factions\Penits";			
			class retirerCNPM {};
			class deposerCNPM {};
			class listCNPM {};
			class initCNPM {};
		};

		class Camera
		{
			file = "\ALF_Core\SERVER\ALF_Functions\Camera";
			class setCameraVar {};
			class getCameraVar {};
		};

		class Rental
		{
			file = "\ALF_Core\SERVER\ALF_Functions\Rental";
			class spawnRentedBoat {};
			class deleteRentedBoat {};
			class spawnRentedCar {};
			class storeRentedCar {};
			class deleteRentedCar {};
		};

		class Prison
		{
			file = "\ALF_Core\SERVER\ALF_Functions\Prison";
			class mettrePrison {};
			class mettreCellule {};
			class initCoffre {};
			class saveCoffre {};
			class customCoffre {};
			class poserC4Prison {};
			class poserC4Barbed {};
			class sortiePrison {};
			class allPrisonnier {};
		};

		class Poker
		{
			file = "\ALF_Core\SERVER\ALF_Functions\Business\Casino\Poker";
			class checkScore {};
			class distributeCards {};
			class playPoker {};
		};
		
		class Blackjack
		{
			file = "\ALF_Core\SERVER\ALF_Functions\Business\Casino\Blackjack";
			class checkScoreBJ {};
			class distributeBJCards {};
			class playBJ {};
		};

		class Gendarmerie
		{
			file = "\ALF_Core\SERVER\ALF_Functions\Factions\Gendarmerie";
			class braceletElectronique {};
			class enleverBracelet {};
			class switchCommand {};
			class placeCamera {};
			class recupCamera {};
		};

		class Leboncoin
		{
			file = "\ALF_Core\SERVER\ALF_Functions\Leboncoin";
			class getLeboncoin {};
			class getAnnonceLeboncoin {};
			class createVehiculeLeboncoin {};
			class annulerLeboncoin {};
			class checkLeboncoin {};
			class achatLeboncoin {};
			class supprimerLeboncoin {};
		};

		class AdnFace
		{
			file = "\ALF_Core\SERVER\ALF_Functions\Factions\Gendarmerie\AdnFace";
			class adnCreate {};
			class adnRecherche {};
			class faceCreate {};
			class createAdnFace {};
			class faceRecherche {};
		};

		class Bank
		{
			file = "\ALF_Core\SERVER\ALF_Functions\Banque";
			class cbParametre {};
			class achatCompteBancaire {};
			class transferExtCompteBancaire {};
		};

		class BankCentral
		{
			file = "\ALF_Core\SERVER\ALF_Functions\Banque\BanqueCentrale";
			class poserC4 {};
			class poserPc {};
		};

		class Hsbc
		{
			file = "\ALF_Core\SERVER\ALF_Functions\Banque\Hsbc";
			class achatHsbc {};
			class transferHsbc {};
		};

		class Bourse
		{
			file = "\ALF_Core\SERVER\ALF_Functions\Banque\Bourse";
			class calculBourse {};
			class initBourse {};
			class searchURLDN {};
			class saveBourse {};
			class updateBourse {};
			class loggedBourse {};
			class randomEvent {};
		};

		class DynamicMarkers {
    		file = "\ALF_Core\SERVER\ALF_Functions\Markers\DynamicMarkers";
    		class dynamicMarkers_create {};
    		class dynamicMarkers_getPos {};
    		class dynamicMarkers_init {};
			class dynamicMarkers_update {};
    	};

		class Marker
		{
			file = "\ALF_Core\SERVER\ALF_Functions\Markers";
			class fetchMarkers {};
			class sendMarker {};
			class removeMarker {};
		};

		class Reparations {
			file = "\ALF_Core\SERVER\ALF_Functions\Vehicules\Reparations";
			class startDiagnostic {};
			class startElevator {};
			class startRepair {};
		};
		class FireWorks {
			file = "\ALF_Core\SERVER\ALF_Functions\Objects\FireWorks";
			class fire {};
		};
		class Casino {
			file = "\ALF_Core\SERVER\ALF_Functions\Business\Casino";
			class getStock {};
			class payerDance {};
			class setparam {};
			class playSlotMachine {};
			class switchSlotMachine {};
		};
		class Assurance {
			file = "\ALF_Core\SERVER\ALF_Functions\Assurance";
			class axa {};
			class checkAxa {};
		};
		class Licences {
			file = "\ALF_Core\SERVER\ALF_Functions\Licences";
			class permisVerif {};
			class permisTime {};
		};
		class Vehicules {
			file = "\ALF_Core\SERVER\ALF_Functions\Vehicules";
			class insertVehicle {};
			class getJobCar {};
			class insertVehicleCopSP {};
			class insertVehiclePenit {};
			class importVehicleHC {};
			class importVehicleHCCopSP {};
			class importVehicleHCPenit {};
			class getVehicles {};
			class getVehiclesCopSP {};
			class getVehiclesPenits {};
			class getVehiclesLock {};
			class spawnVehicle {};
			class spawnVehicleCopSP {};
			class spawnVehicleLock {};
			class spawnVehicleLaunch {};
			class spawnVehicleLaunch_CIV {};
			class spawnVehicleLaunch_GN {};
			class spawnVehicleLaunch_Penit {};
			class spawnVehicleLaunch_SP {};
			class spawnVehiclePenit {};
			class vehicleStore {};
			class vehicleJobStore {};
			class vehicleStoreCopSP {};
			class vehicleStorePenit {};
			class vehicleCreate {};
			class vehicleDelete {};
			class vehicleStockAfterSell {};
			class vehicleUpdate {};
			class vehicleTransfert {};
			class vehicleAutoSync {};
			class insureVehicles {};
			class recherchePlaque {};
			class dispoVehicle {};
			class copStoreVehicle {};
			class changerPlaque {};
			class createFireVehicle {};
			class getBoundingBox {};
			class peintureVehicule {};
			class createEpaveVehicle {};
		};
		class Housing {
			file = "\ALF_Core\SERVER\ALF_Functions\Maisons";
			class addMobilier {};
			class addMobilierCop {};
			class addHouse {};
			class addHouseBusiness {};
			class deleteDBMobilier {};
			class fetchPlayerHouses {};
			class houseCleanup {};
			class sonnetteHouse {};
			class sellHouse {};
			class sellHouseMobilier {};
			class initHouses {};
			class initLocaux {};
			class cfghouseclassnameslock {};
			class updateMobilierInv {};
			class editSafeCode {};
			class recupHouseData {};
			class recupMobilierData {};
			class copHouseMarker {};
			class playSonnetteHouse {};
			class copBreakDoor {};
			class poserBaril {};
			class createHouseLeboncoin {};
			class createRobberyMarker {};
			class loadAllFurniture {};
			class setAlarmGendarmerie {};
			
		};
		class CNG {
			file = "\ALF_Core\SERVER\ALF_Functions\Banque\CaisseNationaleGendarmerie";
			class initCNG {};
			class updateCNG {};
			class retirerCNG {};
			class deposerCNG {};
			class listCNG {};
		};
		class DAB {
			file = "\ALF_Core\SERVER\ALF_Functions\Banque\DAB";
			class initDAB {};
			class bag_vehicle {};
			class updateDABDispo {};
		};
		class Mission {
			file = "\ALF_Core\SERVER\ALF_Functions\Criminel";
			class mission {};
			class receleurSell {};
			class receleurInit {};
		};
		class Business {
			file = "\ALF_Core\SERVER\ALF_Functions\Business";
			class getVehiclesBusiness {};
			class spawnVehicleBusiness {};
			class vehicleCreateBusiness {};
			class vehicleStoreBusiness {};
			class putInFourriere {};
			class initBusiness {};
			class createBusiness {};
			//class agrandirBusiness {};
			class capitalBusiness {};
			class getBusinessCapital {};
			class withdrawBusinessCapital {};
			class withdrawCapitalBySecteur {};
			class addCapitalBySecteur {};
			class recruterBusiness {};
			class BusinessToFisc {};
			class PayToFisc {};
			class fiscToPlayer {};
		};
		class LaPoste {
			file = "\ALF_Core\SERVER\ALF_Functions\Jobs\LaPoste";
			class livraisonSystem {};
			class internetLivSystem {};
			class laposte_checkIsBuyHouse {};
			class laposte_returnHouse {};
		};
		class Eboueur {
			file = "\ALF_Core\SERVER\ALF_Functions\Jobs\Eboueur";
			class eboueur_config_positions {};
			class initEboueur {};
			class eboueur_spawnPoubelles {};
			class eboueur_rechargerPoubelles {};
		};
		class Taxi {
			file = "\ALF_Core\SERVER\ALF_Functions\Jobs\Taxi";
			class taxiSpawnServiceVehicle {};
			class taxiEndServiceVehicle {};
			class taxiRangerVehicle {};
			class taxiFinishServiceParked {};
		};
		class BusJob {
			file = "\ALF_Core\SERVER\ALF_Functions\Jobs\BusJob";
			class busjob_generatePlaque {};
			class busjobSpawnServiceVehicle {};
			class busjobEndServiceVehicle {};
			class busjobRangerVehicle {};
			class busjobFinishServiceParked {};
		};
		class Distributeur {
			file = "\ALF_Core\SERVER\ALF_Functions\Jobs\Distributeur";
			class distrib_stockInit {};
			class distrib_stockItemClasses {};
			class distrib_getStockMax {};
			class distrib_getItemBuyPrice {};
			class distrib_getRestockPay {};
			class distrib_sqlEscape {};
			class distrib_stockBuildDefault {};
			class distrib_stockEncode {};
			class distrib_stockDecode {};
			class distrib_bddFindRow {};
			class distrib_bddCreate {};
			class distrib_bddSave {};
			class distrib_stockLoad {};
			class distrib_stockTake {};
			class distrib_isMachine {};
			class distrib_initAllMachines {};
			class distrib_addStock {};
			class distrib_tryRestock {};
			class distrib_getMachineKey {};
			class distrib_getServiceBuyLimit {};
			class distrib_purchaseStock {};
			class distribSpawnServiceVehicle {};
			class distribRangerVehicle {};
			class distribFinishServiceParked {};
			class distribEndServiceVehicle {};
		};
		class Items {
			file = "\ALF_Core\SERVER\ALF_Functions\Objects\Items";
			class setRadarM {};
			class spikeStrip {};
		};
		class Keys {
			file = "\ALF_Core\SERVER\ALF_Functions\Vehicules\Cles";
			class getVehiclesKeys {};
			class keyGiveTime {};
			class keyGiveDef {};
			class keyGiveDefBillSend {};
			class fetchKeys {};
			class keyManagement {};
		};
		class Boucle {
			file = "\ALF_Core\SERVER\ALF_Functions\Server\Boucle";
			class countDownBracelet {};
			class countDownForfait {};
			class countDownPrison {};
			//class feuTricolore {};
			class appleSystem {};
			class spawnAlgues {};
			//class eboueurSystem {};
			class raisinSystem {};
			class cleanup {};
			class initReboot {};
			class rebootSync {};
			class rebootWeather {};
			class casseFeuTricolore {};
			class feuForet {};
			//class tresorSystem {};
			class sanctuaireTurtles {};
		};

		class Logs {
			file = "\ALF_Core\SERVER\ALF_Functions\Server\Logs";
			class copLogIt {};
			class logIt {};
			class medLogIt {};
			class ACDiag {};
		};		

		class Barbecue {
			file = "\ALF_Core\SERVER\ALF_Functions\Objects\Barbecue";
			class cuireViande {};
		};

		class DIR {
			file = "\ALF_Core\SERVER\ALF_Functions\Business\DIR";
			class reparerFeu {};
		};

        class Documents {
            file = "\ALF_Core\SERVER\ALF_Functions\Business\Documents";
            class insertDocument {};
            class setDocumentsList {};
            class getDocuments {};
        };

		class Phone {
			file = "\ALF_Core\SERVER\ALF_Functions\Phone";
			class buyForfait {};
			class removeForfait {};
			class createPhoneNumber {};
			class updateContactsPhone {};
			class sendSmsPhone {};
			class getUnitFromNumber {};
			class getUnitFromNumberSR {};
			class getMSGFromNumber {};
		};

		class Call {
			file = "\ALF_Core\SERVER\ALF_Functions\Phone\Call";
			class callSystem {};
			class inCallSystem {};
			class centralSystem {};
			class joinCentral {};
		};

		class Nokia {
			file = "\ALF_Core\SERVER\ALF_Functions\Phone\Nokia";
			class loadSmsNokia {};
			class deleteSmsNokia {};
		};

		class iPhone {
			file = "\ALF_Core\SERVER\ALF_Functions\Phone\iPhone";
			class loadSmsiPhone {};
			class deleteSmsiPhone {};
			class iPhoneTaxiGetAvailable {};
			class iPhoneTaxiStartCall {};
		};

		class SonyCop {
			file = "\ALF_Core\SERVER\ALF_Functions\Phone\Sony";
			class loadSmsSony {};
			class deleteSmsSony {};
			class SonyRecherchePlaque {};
			class loadFipSony {};
			class addFipSony {};
			class selectFipSony {};
			class deleteFipSony {};
			class createTajSony {};
			class selectTajSony {};
			class deleteTajSony {};
			class loadCopCentral {};
		};

		class SonyMed {
			file = "\ALF_Core\SERVER\ALF_Functions\Phone\SonyP";
			class loadSmsSonyP {};
			class deleteSmsSonyP {};
			class loadMedCentral {};
		};

		class SonyPM {
			file = "\ALF_Core\SERVER\ALF_Functions\Phone\SonyPM";
			class loadSmsSonyPM {};
			class deleteSmsSonyPM {};
			class loadPMCentral {};
		};

		class Service {
			file = "\ALF_Core\SERVER\ALF_Functions\Factions\ServicesPubliques";
			class disconnectService {};
			class priseService {};
		};

		class Farming {
			file = "\ALF_Core\SERVER\ALF_Functions\Farming";
			class fonderieFer {};
			class fonderieOr {};
			class fonderieCuivre {};
			class systemeDiamant {};
			class MaisSystem {};
			class WeedSystem {};
			class WeedSystem2 {};
			class WeedVentilation {};
			class petroleSystem {};
			class farmingVin {};
			class farmingJusFraise {};
			class farmingJusPomme {};
			class farmingJusRaisin {};
			class farmingPinot {};
			class farmingXxX {};
			class farmingPlanche {};
			class transformPetrol {};
			class cocaine {};
			class recupererPetrole {};
			class canneSucreSystem {};
			class takeWeed {};
			class systemeSaphir {};
			class tabacSystem {};
		};

		class FarmingMeth {
			file = "\ALF_Core\SERVER\ALF_Functions\Farming\Meth";
			class addElement {};
			class recupMeth {};
			class startCrystalise {};
			class startPillon {};
			class startSynthese {};
		};

		class Fire {
			file = "\ALF_Core\SERVER\ALF_Functions\Factions\Pompier\Feux";
			class serviceIncendie {};
			class removeFromHCFire {};
			class spawnFire_serveur {};
			class fire_1 {};
			class fire_2 {};
			class fire_3 {};
			class fire_prop_L {};
			class fire_prop_M {};
			class fire_prop_wind {};
			class burn_building {};
			class burn_poubelle {};
			class burn_foret {};
			class vehiclefire {};
		};

		class Medical {
			file = "\ALF_Core\SERVER\ALF_Functions\Medical";
			class medicalo2 {};
			class drapMortCheck {};
			class donDuSang {};
			class deathScreen {};
		};

		class Anim {
			file = "\ALF_Core\SERVER\ALF_Functions\Animations";
			class getAnimGear {};
			class ambientAnim {};
		};

		class BIE {
			file = "\ALF_Core\SERVER\ALF_Functions\Jobs\BIE";
			class actionLamps {};
			class bieAllumer {};
			class bieEteindre {};
			class biePoserC4 {};
			class biePoserPc {};
			class bieReparer {};
			class bieReparerSystem {};
		};
	};
	
};

class ALF_Repair {
	class HitFuel {
		name = "Réservoir";
		item = "ALF_Reservoir";
	};

	class HitEngine {
		name = "Moteur";
		item = "ALF_Moteur";
	};
	class HitEngine1 {
		name = "Moteur";
		item = "ALF_Moteur";
	};
	class HitEngine2: HitEngine1 {};
	class HitEngine3: HitEngine1 {};

	class HitBody {
		name = "Carrosserie";
		item = "ALF_Caross";
	};

	class HitLFWheel {
		name = "Roue";
		item = "ALF_Roue";
	};
	class HitLF2Wheel: HitLFWheel {};
	class HitLMWheel: HitLFWheel {};
	class HitLBWheel: HitLFWheel {};
	class HitRFWheel: HitLFWheel {};
	class HitRF2Wheel: HitLFWheel {};
	class HitRMWheel: HitLFWheel {};
	class HitRBWheel: HitLFWheel {};
	class HitFWheel: HitLFWheel {};
	class HitBWheel: HitLFWheel {};

	class HitGlass1 {
		name = "Vitre";
		item = "ALF_Vitre";
	};
	class HitGlass2: HitGlass1 {};
	class HitGlass3: HitGlass1 {};
	class HitGlass4: HitGlass1 {};
	class HitGlass5: HitGlass1 {};
	class HitGlass6: HitGlass1 {};
	class HitGlass7: HitGlass1 {};
	class HitGlass8: HitGlass1 {};
	class HitGlass9: HitGlass1 {};
	class HitGlass10: HitGlass1 {};
	class HitRGlass: HitGlass1 {};
	class HitLGlass: HitGlass1 {};

	class HitTurret {
		name = "Carrosserie";
		item = "ALF_Caross";
	};
	class HitGun: HitTurret {};
	class HitAmmo: HitTurret {};
	class HitHull: HitTurret {};
	class HitAvionics: HitTurret {};
	class HitHRotor: HitTurret {};
	class HitVRotor: HitTurret {};
	class HitWinch: HitTurret {};
	class HitTransmission: HitTurret {};
	class HitLight: HitTurret {};
	class HitHydraulics: HitTurret {};
	class HitGear: HitTurret {};
	class HitHStabilizerL1: HitTurret {};
	class HitHStabilizerR1: HitTurret {};
	class HitVStabilizer1: HitTurret {};
	class HitTail: HitTurret {};
	class HitPitotTube: HitTurret {};
	class HitStaticPort: HitTurret {};
	class HitStarter1: HitTurret {};
	class HitStarter2: HitTurret {};
	class HitStarter3: HitTurret {};
};