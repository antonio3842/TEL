// ALF_fnc_Chien_Au_Pied = {['adad'] remoteExec ['systemchat',0];
private _dog = player getVariable ["ALF_Dog", objNull];    
_dog playMoveNow "Dog_Stop";
player setVariable ["ALF_dogAction","stop"];
_dog setposatl (player getRelPos [1,90]);
_dog setdir getdir player;
// };