//=============================================================================
// MenuChoice_ObjectNames
//=============================================================================

class MenuChoice_ObjectNames extends MenuChoice_EnabledDisabled;

// ----------------------------------------------------------------------
// LoadSetting()
// ----------------------------------------------------------------------

function LoadSetting()
{
	SetValue(int(!player.bObjectNames));
}

// ----------------------------------------------------------------------
// SaveSetting()
// ----------------------------------------------------------------------

function SaveSetting()
{
	player.bObjectNames = !bool(GetValue());
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

function ResetToDefault()
{
	SetValue(int(!player.bObjectNames));
}

// ----------------------------------------------------------------------
// DJ: Doubled value
// ----------------------------------------------------------------------

defaultproperties
{
     defaultInfoWidth=176
     HelpText="If enabled, the name of the selected object in the world will be printed"
     actionText="|&Object Names"
}
