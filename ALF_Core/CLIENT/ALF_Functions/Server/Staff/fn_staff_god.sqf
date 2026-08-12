/*
    File: fn_staff_god.sqf
    Author: Matthew

    Description
    Function to activate god mode.
*/

#include "\ALF_Client\script_macros.hpp"

if (isDamageAllowed player) then 
{
    player allowDamage false;
} else 
{
    player allowDamage true;
};
