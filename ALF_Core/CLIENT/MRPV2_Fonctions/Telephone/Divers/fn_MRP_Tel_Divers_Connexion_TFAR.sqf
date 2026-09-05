// MRPV2_fnc_MRP_Tel_Divers_Connexion_TFAR= {
private _type = param [0,""];

private _radio = tolower (call TFAR_fnc_activeSwRadio);
if (isnil {_radio}) exitwith {FALSE};

[_radio,0] call TFAR_fnc_setSwVolume;

sleep 0.33;

private _volume_Sauvegarder = player getvariable ["MRP_Telephone_Volume_Appel",5];

if (_type isEqualto "Connexion") then
{
	private _channel = _radio call TFAR_fnc_getSwChannel;
	private _currentFrequency = [_radio,_channel + 1] call TFAR_fnc_getChannelFrequency;

	[_radio, _channel, _currentFrequency, false] call TFAR_fnc_doSRTransmit;
	[_radio,_volume_Sauvegarder] call TFAR_fnc_setSwVolume;
	[] call TFAR_fnc_hideHint;
} else
{
	private _radio = tolower (call TFAR_fnc_activeSwRadio);
	private _channel = _radio call TFAR_fnc_getSwChannel;
	private _currentFrequency = [_radio, _channel + 1] call TFAR_fnc_getChannelFrequency;

	[_radio, _channel, _currentFrequency, false] call TFAR_fnc_doSRTransmitEnd;
	[_radio,_volume_Sauvegarder] call TFAR_fnc_setSwVolume;
	[] call TFAR_fnc_hideHint;
};

TRUE
// };