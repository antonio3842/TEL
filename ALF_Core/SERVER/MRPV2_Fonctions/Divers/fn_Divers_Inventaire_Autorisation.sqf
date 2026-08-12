// MRPV2_Server_fnc_Inventaire_Autorisation = {
// if (!isServer) exitWith {};
// private _liste_Objets_A_Changer = 
// [
//     "guardrailing_01_f.p3d",
//     "plp_up_paversrectpatio.p3d",
//     "plp_up_paversbricksgrypatio.p3d",
//     "bollard_01_f.p3d",
//     "concretewall_01_m_8m_f_nocontact.p3d",
//     "ConcreteWall_01_m_4m_F_nocontact.p3d",
//     "mrp_barriere_jardin.p3d",
//     "Land_ConcreteWall_01_l_4m_F.p3d",
//     "Land_ConcreteWall_01_l_8m_F.p3d",
//     "Land_ConcreteWall_01_l_pole_F.p3d",
//     "Land_ConcreteWall_01_m_pole_F.p3d",
//     "MRP_barriere_ville.p3d",
//     "Land_PipeFence_01_m_4m_F.p3d",
//     "Land_PipeFence_01_m_8m_F.p3d",
//     "Land_PipeFence_01_m_2m_F.p3d",
//     "Land_ConcreteWall_02_m_gate_F.p3d",
//     "Land_ConcreteKerb_01_2m_F.p3d",
//     "Land_Hedge_01_s_4m_F.p3d",
//     "Land_Hedge_01_s_2m_F.p3d",
//     "Land_ConcreteKerb_01_4m_F.p3d",
//     "Land_ConcreteKerb_01_8m_F.p3d",
//     "plp_up_PaversBricksGryAlley.p3d",
//     "plp_up_ParkingBlockConcreteDark.p3d",
//     "Land_NetFence_02_m_pole_F.p3d",
//     "Land_NetFence_02_m_4m_F.p3d",
//     "Land_NetFence_02_m_2m_F.p3d",
//     "Land_NetFence_02_m_8m_F.p3d",
//     "Land_PipeFence_01_m_pole_F.p3d",
//     "Land_PipeFence_01_m_gate_v2_F.p3d"
// ];

// private _liste_Objets_Monde = nearestTerrainObjects [[worldSize / 2, worldSize / 2],["wall","hide"],worldSize * sqrt 2 / 2,false,true] select {!isObjectHidden _x};
// private _liste_Objets_Trier = _liste_Objets_Monde select {((getModelInfo _x) # 0) in _liste_Objets_A_Changer};

// {
// 	private _obj = _x;
// 	private _pos = getPosWorld _obj;
// 	private _dir = vectorDir _obj;
// 	private _vectorUp = vectorUp _obj;
// 	private _info_Modele = (getModelInfo _obj) # 1;

// 	[_obj,TRUE] remoteExecCall ["hideObjectGlobal",2];
// 	deleteVehicle _obj;

// 	private _obj_Simple = createSimpleObject [_info_Modele, [0,0,0]];

// 	_obj_Simple setPosWorld _pos;
// 	_obj_Simple setVectordirandUp [_dir,_vectorUp];
// 	sleep 0.01;
// } foreach _liste_Objets_Trier;
// };