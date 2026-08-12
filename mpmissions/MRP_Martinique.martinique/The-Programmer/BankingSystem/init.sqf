/*
	_null=this execVM "The-Programmer\BankingSystem\init.sqf";
*/
_this allowDamage false; 
_this enableSimulation false;
_this addAction[(['STR_ADDACTION_LOGIN','The_Programmer_BankingSystem','BankingSystem_localization'] call theprogrammer_core_fnc_localize),the_programmer_bank_system_fnc_bankLogin,"",1.5,true,true,"","true",5];