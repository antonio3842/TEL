// ALF_fnc_menuPeinture = {
params [
	["_mode",-1,[0]],
	["_param",[],[[]]]
];
disableSerialization;

if (_mode isEqualTo -1) exitWith {};

private _textureIndex = 0; // Déclaration en haut pour éviter l'erreur "undefined variable"

diag_log "DEBUG: Début du script fn_menuPeinture.sqf";

switch (_mode) do 
{
	//Lancement Dialog
	case 0: 
	{
		diag_log format ["DEBUG3: Texture Index utilisé = %1", _textureIndex];
		if !(createDialog "alfpeinture") exitWith {};

		ALF_Peinture_Appliquer = false;		
		_textureIndex = if ("_mrp_" in tolower (typeof ALF_Peinture_NearestVehicle)) then {11} else {0};

		ALF_Peinture_Texture = (getObjectTextures ALF_Peinture_NearestVehicle) # _textureIndex;
		ALF_Peinture_Materiel = (getObjectMaterials ALF_Peinture_NearestVehicle) # _textureIndex;
		ALF_Peinture_CurrentRvmat = "";
		ALF_Peinture_CurrentTexture = "";		

		private _textures = getObjectTextures ALF_Peinture_NearestVehicle;
		private _materials = getObjectMaterials ALF_Peinture_NearestVehicle;
		
		diag_log format ["DEBUG15: Textures disponibles = %1", _textures];
		diag_log format ["DEBUG16: Matériaux disponibles = %1", _materials];
		diag_log format ["DEBUG4: Texture = %1 | Material = %2", ALF_Peinture_Texture, ALF_Peinture_Materiel];

		waitUntil {!(isNull (findDisplay 89770))};
		private _display = findDisplay 89770;

		{
			_control = _display displayCtrl _x;
			_control sliderSetRange [0, 1];
			_control sliderSetPosition 0;
		} forEach [89771, 89772, 89773];

		{
			_control = _display displayCtrl 89774;
			_index = _control lbAdd (_x select 0);
			_control lbSetData [_index, (_x select 1)];
		} forEach 
		[
			["Effet Mat Leger","\ALF_Vehicules\ALF_Q7\rvmats\Skin_2.rvmat"],
			["Effet Carosserie Brillant","\alf_vehicules\alf_skyline\data\rvmats\metallic_sky.rvmat"],
			["Effet Mat Clasique","\ALF_Vehicules\ALF_Q7\rvmats\interieur.rvmat"],
			["Nacre Bleue","\ALF_Vehicules\ALF_data\PeintureNacre\Blue.rvmat"],
			["Nacre Vert Fonce","\ALF_Vehicules\ALF_data\PeintureNacre\Darkgreen.rvmat"],
			["Nacre Rouge Fonce","\ALF_Vehicules\ALF_data\PeintureNacre\Darkred.rvmat"],
			["Nacre Vert","\ALF_Vehicules\ALF_data\PeintureNacre\Green.rvmat"],
			["Nacre Orange","\ALF_Vehicules\ALF_data\PeintureNacre\Orange.rvmat"],
			["Nacre Rose","\ALF_Vehicules\ALF_data\PeintureNacre\Pink.rvmat"],
			["Nacre Violet","\ALF_Vehicules\ALF_data\PeintureNacre\Purple.rvmat"],
			["Nacre Rouge","\ALF_Vehicules\ALF_data\PeintureNacre\Red.rvmat"],
			["Nacre Jaune","\ALF_Vehicules\ALF_data\PeintureNacre\Yellow.rvmat"]
		];
		
		private _camo = 
		[
			["Covering Noir et Rouge","\ALF_Moto\ALF_Knucklehead\Skin_moto\CamoRoue.paa"],
			["Covering Vert, Marron et Beige","\ALF_Moto\ALF_Knucklehead\Skin_moto\CamoVert.paa"],
			["Covering Camo Orange","\ALF_Moto\ALF_Knucklehead\Skin_moto\CamoOrange.paa"],
			["Covering Noir, Balnc et Gris","\ALF_Moto\ALF_Knucklehead\Skin_moto\Camogris.paa"],
			["Covering Bleu, Noir et Blanc","\ALF_Moto\ALF_Knucklehead\Skin_moto\Camobleu.paa"],
			["Covering Camo Goute","\ALF_Moto\ALF_Knucklehead\Skin_moto\goute.paa"],
			["Covering Camo Militaire","\ALF_Vehicules\ALF_data\skin_camo_co.paa"],
			["Covering Camo Gris","\ALF_Vehicules\ALF_data\skin_camo_urban_co.paa"],
			["Covering Orange et Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camoornge2.paa"],
			["Covering Rose, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camorose2.paa"],
			["Covering Rouge, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camorouge2.paa"],
			["Covering Vert, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camovert2.paa"],
			["Covering Violet, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camoviolet2.paa"],
			["Covering Orange, Gris","\mrp_carter_base\camo\skin_camo_co11.paa"],
			["Covering Orange, Gris 2","\mrp_carter_base\camo\skin_camo_co22.paa"],
			["Covering Bleu, Gris, Noir","\mrp_carter_base\camo\skin_camo_co33.paa"],
			["Covering Jaune, Gris","\mrp_carter_base\camo\skin_camo_co44.paa"],
			["Covering special","\mrp_carter_base\camo\skin_camo_co55.paa"],
			["Covering special 2","\mrp_carter_base\camo\skin_camo_co66.paa"],
			["Covering special 3","\mrp_carter_base\camo\skin_camo_co77.paa"],
			["Covering special 4","\mrp_carter_base\camo\skin_camo_co88.paa"],
			["Covering special 5","\mrp_carter_base\camo\skin_camo_co99.paa"],
			["Covering special 6","\mrp_carter_base\camo\skin_camo_co1010.paa"],
			["Covering special 7","\mrp_carter_base\camo\skin_camo_co1111.paa"],
			["Covering special 8","\mrp_carter_base\camo\skin_camo_co1212.paa"]
		];

		[] call
		{
			if (typeOf(ALF_Peinture_NearestVehicle) isEqualTo "V_ALF_G63_MRPV2") exitWith 
			{
				_camo = 
				[
					["Rouge/Noir", "\ALF_Vehicules_11\ALF_G63\data\skins\g63_red_co.paa"],
					["Bleu/Noir", "\ALF_Vehicules_11\ALF_G63\data\skins\g63_blue_co.paa"],
					["Vert/Noir", "\ALF_Vehicules_11\ALF_G63\data\skins\g63_green_co.paa"],
					["Orange/Noir", "\ALF_Vehicules_11\ALF_G63\data\skins\g63_orange_co.paa"],
					["Jaune/Noir", "\ALF_Vehicules_11\ALF_G63\data\skins\g63_yellow_co.paa"],
					["Rose/Noir", "\ALF_Vehicules_11\ALF_G63\data\skins\g63_pink_co.paa"],
					["Blanc/Noir", "\ALF_Vehicules_11\ALF_G63\data\skins\g63_white_co.paa"],
					["Gris/Noir", "\ALF_Vehicules_11\ALF_G63\data\skins\g63_grey_co.paa"],
					["Rouge Foncé/Noir", "\ALF_Vehicules_11\ALF_G63\data\skins\g63_darkred_co.paa"],
					["Bleu Foncé/Noir", "\ALF_Vehicules_11\ALF_G63\data\skins\g63_darkblue_co.paa"],
					["Vert Foncé/Noir", "\ALF_Vehicules_11\ALF_G63\data\skins\g63_darkgreen_co.paa"],
					["Covering Noir et Rouge","\ALF_Moto\ALF_Knucklehead\Skin_moto\CamoRoue.paa"],
					["Covering Vert, Marron et Beige","\ALF_Moto\ALF_Knucklehead\Skin_moto\CamoVert.paa"],
					["Covering Camo Orange","\ALF_Moto\ALF_Knucklehead\Skin_moto\CamoOrange.paa"],
					["Covering Noir, Balnc et Gris","\ALF_Moto\ALF_Knucklehead\Skin_moto\Camogris.paa"],
					["Covering Bleu, Noir et Blanc","\ALF_Moto\ALF_Knucklehead\Skin_moto\Camobleu.paa"],
					["Covering Camo Goute","\ALF_Moto\ALF_Knucklehead\Skin_moto\goute.paa"],
					["Covering Camo Militaire","\ALF_Vehicules\ALF_data\skin_camo_co.paa"],
					["Covering Camo Gris","\ALF_Vehicules\ALF_data\skin_camo_urban_co.paa"],
					["Covering Orange et Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camoornge2.paa"],
					["Covering Rose, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camorose2.paa"],
					["Covering Rouge, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camorouge2.paa"],
					["Covering Vert, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camovert2.paa"],
					["Covering Violet, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camoviolet2.paa"],
					["Covering Orange, Gris","\mrp_carter_base\camo\skin_camo_co11.paa"],
					["Covering Orange, Gris 2","\mrp_carter_base\camo\skin_camo_co22.paa"],
					["Covering Bleu, Gris, Noir","\mrp_carter_base\camo\skin_camo_co33.paa"],
					["Covering Jaune, Gris","\mrp_carter_base\camo\skin_camo_co44.paa"],
					["Covering special","\mrp_carter_base\camo\skin_camo_co55.paa"],
					["Covering special 2","\mrp_carter_base\camo\skin_camo_co66.paa"],
					["Covering special 3","\mrp_carter_base\camo\skin_camo_co77.paa"],
					["Covering special 4","\mrp_carter_base\camo\skin_camo_co88.paa"],
					["Covering special 5","\mrp_carter_base\camo\skin_camo_co99.paa"],
					["Covering special 6","\mrp_carter_base\camo\skin_camo_co1010.paa"],
					["Covering special 7","\mrp_carter_base\camo\skin_camo_co1111.paa"],
					["Covering special 8","\mrp_carter_base\camo\skin_camo_co1212.paa"]
				];
			};
																						
			if (typeOf(ALF_Peinture_NearestVehicle) isEqualTo "V_ALF_Ghost_MRPV2") exitWith 
			{_camo = 
				[
					["Rouge/Noir", "\ALF_Vehicules_11\ALF_Ghost\data\skins\gh_red_co.paa"],
					["Bleu/Noir", "\ALF_Vehicules_11\ALF_Ghost\data\skins\gh_blue_co.paa"],
					["Vert/Noir", "\ALF_Vehicules_11\ALF_Ghost\data\skins\gh_green_co.paa"],
					["Orange/Noir", "\ALF_Vehicules_11\ALF_Ghost\data\skins\gh_orange_co.paa"],
					["Jaune/Noir", "\ALF_Vehicules_11\ALF_Ghost\data\skins\gh_yellow_co.paa"],
					["Rose/Noir", "\ALF_Vehicules_11\ALF_Ghost\data\skins\gh_pink_co.paa"],
					["Blanc/Noir", "\ALF_Vehicules_11\ALF_Ghost\data\skins\gh_white_co.paa"],
					["Gris/Noir", "P\ALF_Vehicules_11\ALF_Ghost\data\skins\gh_grey_co.paa"],
					["Rouge Foncé/Noir", "\ALF_Vehicules_11\ALF_Ghost\data\skins\gh_darkred_co.paa"],
					["Bleu Foncé/Noir", "\ALF_Vehicules_11\ALF_Ghost\data\skins\gh_darkblue_co.paa"],
					["Vert Foncé/Noir", "\ALF_Vehicules_11\ALF_Ghost\data\skins\gh_darkgreen_co.paa"],
					["Covering Noir et Rouge","\ALF_Moto\ALF_Knucklehead\Skin_moto\CamoRoue.paa"],
					["Covering Vert, Marron et Beige","\ALF_Moto\ALF_Knucklehead\Skin_moto\CamoVert.paa"],
					["Covering Camo Orange","\ALF_Moto\ALF_Knucklehead\Skin_moto\CamoOrange.paa"],
					["Covering Noir, Balnc et Gris","\ALF_Moto\ALF_Knucklehead\Skin_moto\Camogris.paa"],
					["Covering Bleu, Noir et Blanc","\ALF_Moto\ALF_Knucklehead\Skin_moto\Camobleu.paa"],
					["Covering Camo Goute","\ALF_Moto\ALF_Knucklehead\Skin_moto\goute.paa"],
					["Covering Camo Militaire","\ALF_Vehicules\ALF_data\skin_camo_co.paa"],
					["Covering Camo Gris","\ALF_Vehicules\ALF_data\skin_camo_urban_co.paa"],
					["Covering Orange et Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camoornge2.paa"],
					["Covering Rose, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camorose2.paa"],
					["Covering Rouge, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camorouge2.paa"],
					["Covering Vert, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camovert2.paa"],
					["Covering Violet, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camoviolet2.paa"],
					["Covering Orange, Gris","\mrp_carter_base\camo\skin_camo_co11.paa"],
					["Covering Orange, Gris 2","\mrp_carter_base\camo\skin_camo_co22.paa"],
					["Covering Bleu, Gris, Noir","\mrp_carter_base\camo\skin_camo_co33.paa"],
					["Covering Jaune, Gris","\mrp_carter_base\camo\skin_camo_co44.paa"],
					["Covering special","\mrp_carter_base\camo\skin_camo_co55.paa"],
					["Covering special 2","\mrp_carter_base\camo\skin_camo_co66.paa"],
					["Covering special 3","\mrp_carter_base\camo\skin_camo_co77.paa"],
					["Covering special 4","\mrp_carter_base\camo\skin_camo_co88.paa"],
					["Covering special 5","\mrp_carter_base\camo\skin_camo_co99.paa"],
					["Covering special 6","\mrp_carter_base\camo\skin_camo_co1010.paa"],
					["Covering special 7","\mrp_carter_base\camo\skin_camo_co1111.paa"],
					["Covering special 8","\mrp_carter_base\camo\skin_camo_co1212.paa"]
				];
			};
																						
			if (typeOf(ALF_Peinture_NearestVehicle) isEqualTo "V_ALF_Limousine_MRPV2") then 
			{
				_camo = 
				[
					["Rouge/Noir", "\ALF_Vehicules_11\ALF_Limousine\data\skins\limo_red_co.paa"],
					["Bleu/Noir", "\ALF_Vehicules_11\ALF_Limousine\data\skins\limo_blue_co.paa"],
					["Vert/Noir", "\ALF_Vehicules_11\ALF_Limousine\data\skins\limo_green_co.paa"],
					["Orange/Noir", "\ALF_Vehicules_11\ALF_Limousine\data\skins\limo_orange_co.paa"],
					["Jaune/Noir", "\ALF_Vehicules_11\ALF_Limousine\data\skins\limo_yellow_co.paa"],
					["Rose/Noir", "\ALF_Vehicules_11\ALF_Limousine\data\skins\limo_pink_co.paa"],
					["Blanc/Noir", "\ALF_Vehicules_11\ALF_Limousine\data\skins\limo_white_co.paa"],
					["Gris/Noir", "P\ALF_Vehicules_11\ALF_Limousine\data\skins\limo_grey_co.paa"],
					["Rouge Foncé/Noir", "\ALF_Vehicules_11\ALF_Limousine\data\skins\limo_darkred_co.paa"],
					["Vert Foncé/Noir", "\ALF_Vehicules_11\ALF_Limousine\data\skins\limo_darkgreen_co.paa"],
					["Covering Noir et Rouge","\ALF_Moto\ALF_Knucklehead\Skin_moto\CamoRoue.paa"],
					["Covering Vert, Marron et Beige","\ALF_Moto\ALF_Knucklehead\Skin_moto\CamoVert.paa"],
					["Covering Camo Orange","\ALF_Moto\ALF_Knucklehead\Skin_moto\CamoOrange.paa"],
					["Covering Noir, Balnc et Gris","\ALF_Moto\ALF_Knucklehead\Skin_moto\Camogris.paa"],
					["Covering Bleu, Noir et Blanc","\ALF_Moto\ALF_Knucklehead\Skin_moto\Camobleu.paa"],
					["Covering Camo Goute","\ALF_Moto\ALF_Knucklehead\Skin_moto\goute.paa"],
					["Covering Camo Militaire","\ALF_Vehicules\ALF_data\skin_camo_co.paa"],
					["Covering Camo Gris","\ALF_Vehicules\ALF_data\skin_camo_urban_co.paa"],
					["Covering Orange et Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camoornge2.paa"],
					["Covering Rose, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camorose2.paa"],
					["Covering Rouge, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camorouge2.paa"],
					["Covering Vert, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camovert2.paa"],
					["Covering Violet, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camoviolet2.paa"],
					["Covering Orange, Gris","\mrp_carter_base\camo\skin_camo_co11.paa"],
					["Covering Orange, Gris 2","\mrp_carter_base\camo\skin_camo_co22.paa"],
					["Covering Bleu, Gris, Noir","\mrp_carter_base\camo\skin_camo_co33.paa"],
					["Covering Jaune, Gris","\mrp_carter_base\camo\skin_camo_co44.paa"],
					["Covering special","\mrp_carter_base\camo\skin_camo_co55.paa"],
					["Covering special 2","\mrp_carter_base\camo\skin_camo_co66.paa"],
					["Covering special 3","\mrp_carter_base\camo\skin_camo_co77.paa"],
					["Covering special 4","\mrp_carter_base\camo\skin_camo_co88.paa"],
					["Covering special 5","\mrp_carter_base\camo\skin_camo_co99.paa"],
					["Covering special 6","\mrp_carter_base\camo\skin_camo_co1010.paa"],
					["Covering special 7","\mrp_carter_base\camo\skin_camo_co1111.paa"],
					["Covering special 8","\mrp_carter_base\camo\skin_camo_co1212.paa"]
				];
			};

			if (typeOf(ALF_Peinture_NearestVehicle) isEqualTo "V_ALF_Actros_DEP_4000_MRPV2") then 
			{
				_camo = 
				[
					["HDM", "\mrp_carter_base\camo\HDM_Mercedes_Actros.paa"],
					["Caraïbes", "\mrp_carter_base\camo\Caraïbes_Actros.paa"],
					["DIR", "\mrp_carter_base\camo\DIR_Actros.paa"],
					["GRG", "\MRPV2_Texture\vehicule\entreprises\grg\Actros_GRG.paa"]

				];
			};
			if (typeOf(ALF_Peinture_NearestVehicle) isEqualTo "ALF_LX_premium_dp_MRPV2") then 
			{
				_camo = 
				[
					["HDM", "\mrp_carter_base\camo\HDM_Prenium_Depaneuse.paa"],
					["Caraibes", "\mrp_carter_base\camo\Caraïbes_Renault.paa"],
					["DIR", "\mrp_carter_base\camo\DIR_Renault.paa"],
					["GRG", "\MRPV2_Texture\vehicule\entreprises\grg\Renault_GRG.paa"]
				];
			};
			if (typeOf(ALF_Peinture_NearestVehicle) isEqualTo "ALF_LX_clio4_MRPV2") then 
			{
				_camo = 
				[
					["FDJ", "\mrp_carter_base\camo\Clio_4_LX_FDJ.paa"],
					["Covering Noir et Rouge","\ALF_Moto\ALF_Knucklehead\Skin_moto\CamoRoue.paa"],
					["Covering Vert, Marron et Beige","\ALF_Moto\ALF_Knucklehead\Skin_moto\CamoVert.paa"],
					["Covering Camo Orange","\ALF_Moto\ALF_Knucklehead\Skin_moto\CamoOrange.paa"],
					["Covering Noir, Balnc et Gris","\ALF_Moto\ALF_Knucklehead\Skin_moto\Camogris.paa"],
					["Covering Bleu, Noir et Blanc","\ALF_Moto\ALF_Knucklehead\Skin_moto\Camobleu.paa"],
					["Covering Camo Goute","\ALF_Moto\ALF_Knucklehead\Skin_moto\goute.paa"],
					["Covering Camo Militaire","\ALF_Vehicules\ALF_data\skin_camo_co.paa"],
					["Covering Camo Gris","\ALF_Vehicules\ALF_data\skin_camo_urban_co.paa"],
					["Covering Orange et Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camoornge2.paa"],
					["Covering Rose, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camorose2.paa"],
					["Covering Rouge, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camorouge2.paa"],
					["Covering Vert, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camovert2.paa"],
					["Covering Violet, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camoviolet2.paa"],
					["Covering Orange, Gris","\mrp_carter_base\camo\skin_camo_co11.paa"],
					["Covering Orange, Gris 2","\mrp_carter_base\camo\skin_camo_co22.paa"],
					["Covering Bleu, Gris, Noir","\mrp_carter_base\camo\skin_camo_co33.paa"],
					["Covering Jaune, Gris","\mrp_carter_base\camo\skin_camo_co44.paa"],
					["Covering special","\mrp_carter_base\camo\skin_camo_co55.paa"],
					["Covering special 2","\mrp_carter_base\camo\skin_camo_co66.paa"],
					["Covering special 3","\mrp_carter_base\camo\skin_camo_co77.paa"],
					["Covering special 4","\mrp_carter_base\camo\skin_camo_co88.paa"],
					["Covering special 5","\mrp_carter_base\camo\skin_camo_co99.paa"],
					["Covering special 6","\mrp_carter_base\camo\skin_camo_co1010.paa"],
					["Covering special 7","\mrp_carter_base\camo\skin_camo_co1111.paa"],
					["Covering special 8","\mrp_carter_base\camo\skin_camo_co1212.paa"]
				];
			};
			if (typeOf(ALF_Peinture_NearestVehicle) isEqualTo "VEH_MRP_Sprinter_Cargo_Civ") then 
			{
				_camo = 
				[
					["Troika", "\mrp_carter_base\camo\Sprinter_Cargo_Troika.paa"],
					["Total Energie", "\mrp_carter_base\camo\Mercesdes_Cargo_TotalEnergie.paa"],
					["D Diamond", "\mrp_carter_base\camo\Cargo_D_Diamond.paa"],
					["Wiki Tropic Bar", "\MRPV2_Texture\vehicule\entreprises\wiki_tropic\Cargo_Wiki_Tropic.paa"],
					["Covering Noir et Rouge","\ALF_Moto\ALF_Knucklehead\Skin_moto\CamoRoue.paa"],
					["Covering Vert, Marron et Beige","\ALF_Moto\ALF_Knucklehead\Skin_moto\CamoVert.paa"],
					["Covering Camo Orange","\ALF_Moto\ALF_Knucklehead\Skin_moto\CamoOrange.paa"],
					["Covering Noir, Balnc et Gris","\ALF_Moto\ALF_Knucklehead\Skin_moto\Camogris.paa"],
					["Covering Bleu, Noir et Blanc","\ALF_Moto\ALF_Knucklehead\Skin_moto\Camobleu.paa"],
					["Covering Camo Goute","\ALF_Moto\ALF_Knucklehead\Skin_moto\goute.paa"],
					["Covering Camo Militaire","\ALF_Vehicules\ALF_data\skin_camo_co.paa"],
					["Covering Camo Gris","\ALF_Vehicules\ALF_data\skin_camo_urban_co.paa"],
					["Covering Orange et Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camoornge2.paa"],
					["Covering Rose, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camorose2.paa"],
					["Covering Rouge, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camorouge2.paa"],
					["Covering Vert, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camovert2.paa"],
					["Covering Violet, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camoviolet2.paa"],
					["Covering Orange, Gris","\mrp_carter_base\camo\skin_camo_co11.paa"],
					["Covering Orange, Gris 2","\mrp_carter_base\camo\skin_camo_co22.paa"],
					["Covering Bleu, Gris, Noir","\mrp_carter_base\camo\skin_camo_co33.paa"],
					["Covering Jaune, Gris","\mrp_carter_base\camo\skin_camo_co44.paa"],
					["Covering special","\mrp_carter_base\camo\skin_camo_co55.paa"],
					["Covering special 2","\mrp_carter_base\camo\skin_camo_co66.paa"],
					["Covering special 3","\mrp_carter_base\camo\skin_camo_co77.paa"],
					["Covering special 4","\mrp_carter_base\camo\skin_camo_co88.paa"],
					["Covering special 5","\mrp_carter_base\camo\skin_camo_co99.paa"],
					["Covering special 6","\mrp_carter_base\camo\skin_camo_co1010.paa"],
					["Covering special 7","\mrp_carter_base\camo\skin_camo_co1111.paa"],
					["Covering special 8","\mrp_carter_base\camo\skin_camo_co1212.paa"]
				];
			};
			if (typeOf(ALF_Peinture_NearestVehicle) isEqualTo "V_ALF_Raptor_DEP_MRPV2") then 
            {
                _camo = 
                [
                    ["Caraïbes", "\mrp_carter_base\camo\Caraïbes_Raptor.paa"]

                ];
            };
			if (typeOf(ALF_Peinture_NearestVehicle) isEqualTo "VEH_MRP_Citroen_Ami_Civ") then 
            {
                _camo = 
                [
                    ["HDM", "\MRP_MM_Luxury\Skin\Citroen_Ami\Services_public\hdm_courtoisie.paa"],
					["Covering Noir et Rouge","\ALF_Moto\ALF_Knucklehead\Skin_moto\CamoRoue.paa"],
			        ["Covering Vert, Marron et Beige","\ALF_Moto\ALF_Knucklehead\Skin_moto\CamoVert.paa"],
			        ["Covering Camo Orange","\ALF_Moto\ALF_Knucklehead\Skin_moto\CamoOrange.paa"],
			        ["Covering Noir, Balnc et Gris","\ALF_Moto\ALF_Knucklehead\Skin_moto\Camogris.paa"],
			        ["Covering Bleu, Noir et Blanc","\ALF_Moto\ALF_Knucklehead\Skin_moto\Camobleu.paa"],
			        ["Covering Camo Goute","\ALF_Moto\ALF_Knucklehead\Skin_moto\goute.paa"],
			        ["Covering Camo Militaire","\ALF_Vehicules\ALF_data\skin_camo_co.paa"],
			        ["Covering Camo Gris","\ALF_Vehicules\ALF_data\skin_camo_urban_co.paa"],
			        ["Covering Orange et Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camoornge2.paa"],
			        ["Covering Rose, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camorose2.paa"],
			        ["Covering Rouge, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camorouge2.paa"],
			        ["Covering Vert, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camovert2.paa"],
			        ["Covering Violet, Noir","\ALF_Vehicules_6\ALF_Evoque\data\depanneur\Camoviolet2.paa"],
			        ["Covering Orange, Gris","\mrp_carter_base\camo\skin_camo_co11.paa"],
			        ["Covering Orange, Gris 2","\mrp_carter_base\camo\skin_camo_co22.paa"],
			        ["Covering Bleu, Gris, Noir","\mrp_carter_base\camo\skin_camo_co33.paa"],
			        ["Covering Jaune, Gris","\mrp_carter_base\camo\skin_camo_co44.paa"],
			        ["Covering special","\mrp_carter_base\camo\skin_camo_co55.paa"],
			        ["Covering special 2","\mrp_carter_base\camo\skin_camo_co66.paa"],
			        ["Covering special 3","\mrp_carter_base\camo\skin_camo_co77.paa"],
			        ["Covering special 4","\mrp_carter_base\camo\skin_camo_co88.paa"],
			        ["Covering special 5","\mrp_carter_base\camo\skin_camo_co99.paa"],
			        ["Covering special 6","\mrp_carter_base\camo\skin_camo_co1010.paa"],
			        ["Covering special 7","\mrp_carter_base\camo\skin_camo_co1111.paa"],
			        ["Covering special 8","\mrp_carter_base\camo\skin_camo_co1212.paa"]
                ];
            };
			if (typeOf(ALF_Peinture_NearestVehicle) isEqualTo "VEH_Mercura_MRP_Toyota_Depanneuse") then 
            {
                _camo = 
                [
                    ["HDM", "\MRP_MM_Luxury\Skin\Toyota_Dep\Services_Public\skin_HDM.paa"],
					["DIR", "\MRP_MM_Luxury\Skin\Toyota_Dep\Services_Public\skin_DIR.paa"],
					["GRG", "\MRPV2_Texture\vehicule\entreprises\grg\Toyota_GRG.paa"]
                ];
            };
			if (typeOf(ALF_Peinture_NearestVehicle) isEqualTo "VEH_Mercura_MRP_Man_TGS_Dep") then 
            {
                _camo = 
                [
                    ["HDM", "\MRP_MM_Luxury\Skin\Man_TGS_Dep\skin_HDM.paa"],
					["MM LUXURY", "\MRP_MM_Luxury\Skin\Man_TGS_Dep\Skin_MM_Luxury.paa"],
					["DIR", "\MRPV2_Texture\vehicule\entreprises\dir\DIR_MAN_TGS.paa"],
					["GRG", "\MRPV2_Texture\vehicule\entreprises\grg\Man_GRG.paa"]
                ];
            };
			if (typeOf(ALF_Peinture_NearestVehicle) isEqualTo "VEH_Mercura_MRP_Sprinter_2022_Dp") then 
            {
                _camo = 
                [
                    ["MM LUXURY", "\MRP_MM_Luxury\Skin\Sprinter_2022\skin_mm.paa"],
					["MM LUXURY BLK", "\MRP_MM_Luxury\Skin\Sprinter_2022\skin_mm_blk.paa"],
					["GRG", "\MRP_MM_Luxury\Skin\Sprinter_2022\GRG_Sprinter.paa"],
					["HDM", "\MRP_MM_Luxury\Skin\Sprinter_2022\HDM_Sprinter.paa"]
                ];
            };
			if (typeOf(ALF_Peinture_NearestVehicle) isEqualTo "VEH_MRP_Alpine_A110_Civ") then 
			{
				_camo = 
				[
					["Rallye5", "\MRP_MM_Luxury\Skin\Alpine_A110\Rallye\Alpine5.paa"],
					["Rallye17", "\MRP_MM_Luxury\Skin\Alpine_A110\Rallye\Alpine17.paa"],
					["Rallye76", "\MRP_MM_Luxury\Skin\Alpine_A110\Rallye\Alpine76.paa"],
					["Rallye972", "\MRP_MM_Luxury\Skin\Alpine_A110\Rallye\Alpine972.paa"]
				];
			};
			if (typeOf(ALF_Peinture_NearestVehicle) isEqualTo "ALF_Peugeot_308_2022_MRPV2") then 
            {
                _camo = 
                [
                    ["M SECURITY", "\MRPV2_Texture\vehicule\entreprises\Securite\308_martinique_security.paa"]
                ];
            };
			if (typeOf(ALF_Peinture_NearestVehicle) isEqualTo "V_ALF_Evoque_MRPV2") then 
			{
				_camo = 
				[
					["M SECURITY", "\MRPV2_Texture\vehicule\entreprises\msecurite\Evoque_MSecurite.paa"]
				];
			};
		};
		//On setup les Covering
		{
			_control = _display displayCtrl 89775;
			_index = _control lbAdd (_x select 0);
			_control lbSetData [_index, (_x select 1)];
		} forEach _camo;
		diag_log "DEBUG: Entrée dans le CASE 0";
	};
	case 1: 
	{
		if (isNull ALF_Peinture_NearestVehicle) exitWith {};

		// Vérification pour empêcher la boucle infinie
		private _sliderPosR = round(sliderPosition 89771 * 100) / 100;
		private _sliderPosG = round(sliderPosition 89772 * 100) / 100;
		private _sliderPosB = round(sliderPosition 89773 * 100) / 100;

		if (
			_sliderPosR isequalto (missionNamespace getVariable ["ALF_Peinture_SliderR", -1]) AND
			_sliderPosG isequalto (missionNamespace getVariable ["ALF_Peinture_SliderG", -1]) AND
			_sliderPosB isequalto (missionNamespace getVariable ["ALF_Peinture_SliderB", -1])
		) exitWith {};

		missionNamespace setVariable ["ALF_Peinture_SliderR", _sliderPosR];
		missionNamespace setVariable ["ALF_Peinture_SliderG", _sliderPosG];
		missionNamespace setVariable ["ALF_Peinture_SliderB", _sliderPosB];

		_classname = toLower (typeOf ALF_Peinture_NearestVehicle);
		_textureIndex = if ("_mrp_" in tolower (typeof ALF_Peinture_NearestVehicle)) then {11} else {0};

		private _texture = format ["#(argb,8,8,3)color(%1,%2,%3,1.0,co)", _sliderPosR, _sliderPosG, _sliderPosB];
		ALF_Peinture_NearestVehicle setObjectTextureGlobal [_textureIndex, _texture];
		ALF_Peinture_CurrentTexture = _texture;

		diag_log format ["DEBUG: Nouvelle texture appliquée = %1", _texture];
	};
	
	// Combo Pos Changed RVMAT
	case 2: 
	{
		_param params ["_control", "_selectedIndex"];
		if (isNull ALF_Peinture_NearestVehicle OR {isNull _control OR {_selectedIndex isEqualTo -1}}) exitWith {};

		_classname = toLower (typeOf ALF_Peinture_NearestVehicle);
		_textureIndex = if ("_mrp_" in tolower (typeof ALF_Peinture_NearestVehicle)) then {11} else {0};

		private _data = _control lbData _selectedIndex;
		if (_data isEqualTo "") exitWith {};

		ALF_Peinture_NearestVehicle setObjectMaterialGlobal [_textureIndex, _data];
		ALF_Peinture_CurrentRvmat = _data;
		diag_log "DEBUG: Entrée dans le CASE 2";
	};

	// Combo Pos Changed Covering
	case 3: 
	{
		_param params ["_control", "_selectedIndex"];
		if (isNull ALF_Peinture_NearestVehicle OR {isNull _control OR {_selectedIndex isEqualTo -1}}) exitWith {};

		private _classname = toLower (typeOf ALF_Peinture_NearestVehicle);
		private _textureIndex = if ("_mrp_" in tolower (typeof ALF_Peinture_NearestVehicle)) then {11} else {0};

		private _data = _control lbData _selectedIndex;
		if (_data isEqualTo "") exitWith {};

		ALF_Peinture_NearestVehicle setObjectTextureGlobal [_textureIndex, _data];
		ALF_Peinture_CurrentTexture = _data;
		diag_log "DEBUG: Entrée dans le CASE 3";
	};

	// Bouton Appliquer
	case 4: 
	{
		if (isNull ALF_Peinture_NearestVehicle) exitWith {};

		_classname = toLower (typeOf ALF_Peinture_NearestVehicle);
		_textureIndex = if ("_mrp_" in tolower (typeof ALF_Peinture_NearestVehicle)) then {11} else {0};

		if (ALF_Peinture_CurrentTexture isEqualTo "") then {
			ALF_Peinture_CurrentTexture = (getObjectTextures ALF_Peinture_NearestVehicle) select _textureIndex;
		};

		if (ALF_Peinture_CurrentRvmat isEqualTo "") then {
			ALF_Peinture_CurrentRvmat = (getObjectMaterials ALF_Peinture_NearestVehicle) select _textureIndex;
		};

		ALF_Peinture_NearestVehicle setObjectTextureGlobal [_textureIndex, ALF_Peinture_CurrentTexture];
		ALF_Peinture_NearestVehicle setObjectMaterialGlobal [_textureIndex, ALF_Peinture_CurrentRvmat];

		ALF_Peinture_Appliquer = true;
		[ALF_Peinture_NearestVehicle, ALF_Peinture_CurrentTexture, ALF_Peinture_CurrentRvmat] remoteExecCall ["ALF_Server_fnc_peintureVehicule", 2];
		closeDialog 0;
		ALF_Peinture_CurrentTexture = "";
		diag_log "DEBUG: Entrée dans le CASE 4";
		diag_log format ["DEBUG: Texture finale = %1 | Rvmat finale = %2", ALF_Peinture_CurrentTexture, ALF_Peinture_CurrentRvmat];
	};
};

diag_log format ["DEBUG2: Texture Index utilisé = %1", _textureIndex];
diag_log format ["DEBUG: Valeur de _mode = %1", _mode];

[] spawn 
{
	waituntil 
	{
		if (isnull (findDisplay 89770)) exitwith 
		{
			if !(ALF_Peinture_Appliquer) then 
			{
				private _textureIndex = if ("_mrp_" in tolower (typeof ALF_Peinture_NearestVehicle)) then {11} else {0};

				if !(ALF_Peinture_Appliquer) then {ALF_Peinture_NearestVehicle setObjectTextureGlobal [_textureIndex,ALF_Peinture_Texture]; 
				ALF_Peinture_NearestVehicle setObjectMaterialGlobal [_textureIndex,ALF_Peinture_Materiel];};
			};

			TRUE
		};

		FALSE
	};
};
// };