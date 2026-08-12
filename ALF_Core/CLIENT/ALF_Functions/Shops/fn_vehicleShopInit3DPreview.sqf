/*
	File: fn_vehicleShopInit3DPreview.sqf
	Author: NiiRoZz

	Description:
	Called when a player open the vehicle shop and setup cam and the while for rotate around the vehicle
*/
// Creating a camera.
life_preview_3D_vehicle_cam = "camera" camCreate ([[5000, 5000, 0]] call ALF_fnc_searchPosEmpty);
life_preview_3D_vehicle_cam cameraEffect ["Internal", "BACK"];
life_preview_3D_vehicle_cam camSetFocus [-1, -1];
showCinemaBorder false;
life_preview_3D_vehicle_cam camCommit 0;

life_preview_3D_vehicle_object = objNull;

// Thread execution performing a continuous rotation of the camra around the view object.
0 spawn
{
	// Until we left the visualization.
	while {!isNull life_preview_3D_vehicle_cam} do {
		private ["_object","_distanceCam","_azimuthCam"];

		// Waiting for a view object.
		waitUntil {!isNull life_preview_3D_vehicle_object};

		_object = life_preview_3D_vehicle_object;
		private _bb = boundingBoxreal [_object,"firegeometry"];

		_distanceCam = 2.00 * ([_bb # 0 # 0, _bb # 0 # 2] distance [_bb # 1 # 0, _bb # 1 # 2]);
		_azimuthCam = 0;

		life_preview_3D_vehicle_cam camSetTarget _object;
		life_preview_3D_vehicle_cam camSetPos (_object modelToWorld [_distanceCam * sin _azimuthCam, _distanceCam * cos _azimuthCam, _distanceCam * 0.33]);
		life_preview_3D_vehicle_cam camCommit 0;

		// Rotation around the object.
		while {life_preview_3D_vehicle_object isEqualTo _object} do {
			_azimuthCam = _azimuthCam + .70;

			life_preview_3D_vehicle_cam camSetPos (_object modelToWorld [_distanceCam * sin _azimuthCam, _distanceCam * cos _azimuthCam, _distanceCam * 0.33]);
			life_preview_3D_vehicle_cam camCommit 0.05;

			sleep 0.05;
		};
	};
};
