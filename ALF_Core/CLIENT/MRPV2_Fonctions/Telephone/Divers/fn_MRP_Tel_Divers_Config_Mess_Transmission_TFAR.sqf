private _action = param [0,""];
private _application = param [1,""];
private _frequence = param [2,""];


private _couleur_Action = "";

if (_action isEquaLTo "Transmission") then
{
	_couleur_Action = "<t size='1' align='center' color='#00FF00'>%1</t><br />";
} else
{
	_couleur_Action = "<t size='1' align='center' color='#FF9900'>%1</t><br />";
};

if (_frequence isNotEqualTo "") then
{
	if (_frequence isequalto "Principal") exitwith
	{
		_frequence = MRP_Telephone_Info_Dispatch getordefault ["Principal",""];
	};

	if (_frequence isequalto "Secondaire") then
	{
		_frequence = MRP_Telephone_Info_Dispatch getordefault ["Secondaire",""];
	};
};

private _texte_Transmission_Radio = format
[	"
		" + _couleur_Action + "
		<img size='1.5' align='center' image='%2'/><br />
		<t size='1' align='center'>%3</t><br />
		<t size='1' align='center'>%4</t>
	",
	_action,
	"\MRP_Telephones\Data\Icones_Applications\Icone_" + _application + ".paa",
	"Application : " + _application,
	"Fréquence : " + _frequence
];

_texte_Transmission_Radio