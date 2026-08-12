/*
	serviceIncendie
*/
if (life_medicLevel < 5) exitWith {["INFO","Vous n'avez pas le grade pour cela.","warning"] spawn ALF_fnc_doMsg;};
if((time - life_action_delay) < 5) exitWith {["INFO", "Vous appuyez trop vite.", "warning"] spawn ALF_fnc_doMsg;};

life_action_delay = time;
[] remoteExecCall ["ALF_Server_fnc_serviceIncendie",2];