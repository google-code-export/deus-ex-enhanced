//=============================================================================
// MenuChoice_HUDBordersVisible
//=============================================================================

class MenuChoice_HUDBordersVisible extends MenuChoice_OnOff;

// ----------------------------------------------------------------------
// LoadSetting()
// ----------------------------------------------------------------------

function LoadSetting()
{
	SetValue(int(player.bHUDBordersVisible));
}

// ----------------------------------------------------------------------
// SaveSetting()
// ----------------------------------------------------------------------

function SaveSetting()
{
	player.bHUDBordersVisible = bool(GetValue());
}

// ----------------------------------------------------------------------
// ResetToDefault()
// ----------------------------------------------------------------------

function ResetToDefault()
{
	player.bHUDBordersVisible = bool(defaultValue);
	SetValue(defaultValue);
	ChangeStyle();
}

// ----------------------------------------------------------------------
// CycleNextValue()
// ----------------------------------------------------------------------

function CycleNextValue()
{
	Super.CycleNextValue();
	player.bHUDBordersVisible = bool(GetValue());
	ChangeStyle();
}

// ----------------------------------------------------------------------
// CyclePreviousValue()
// ----------------------------------------------------------------------

function CyclePreviousValue()
{
	Super.CyclePreviousValue();
	player.bHUDBordersVisible = bool(GetValue());
	ChangeStyle();
}

// ----------------------------------------------------------------------
// DJ: Doubled defaultInfoWidth
// ----------------------------------------------------------------------

defaultproperties
{
     defaultValue=1
     defaultInfoWidth=194
     HelpText="Determines whether the HUD Borders are displayed"
     actionText="HUD Borders |&Visible"
}
