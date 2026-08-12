// CLIENT
// Reçoit la valeur serveur et signale la synchro à la loop
params ["_rem"];
missionNamespace setVariable ["MRP_rebr_remaining", _rem max 0];
missionNamespace setVariable ["MRP_rebr_synced", true];
