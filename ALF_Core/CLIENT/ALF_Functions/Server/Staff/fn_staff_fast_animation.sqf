/*
    File: fn_staff_fast_animation.sqf
    Author: Matthew

    Description
    Function to accelerate players animations.
*/

#include "\ALF_Client\script_macros.hpp"

if (ALF_FastAnimationOn) then {
    player setAnimSpeedCoef 1;
    ALF_FastAnimationOn = false;
} else {
    player setAnimSpeedCoef 2.5;
    ALF_FastAnimationOn = true;
};
