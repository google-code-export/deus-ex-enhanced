//=============================================================================
// MenuChoice_Crosshairs
//=============================================================================

class MenuChoice_Crosshairs extends MenuChoice_VisibleHidden;

// ----------------------------------------------------------------------
// LoadSetting()
// ----------------------------------------------------------------------

function LoadSetting()
{
	SetValue(int(!player.bCrosshairVisible));
}

// ----------------------------------------------------------------------
// SaveSetting()
// ----------------------------------------------------------------------

function SaveSetting()
{
	player.bCrosshairVisible = !bool(GetValue());
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

function ResetToDefault()
{
	SetValue(int(!player.bCrosshairVisible));
}

// ----------------------------------------------------------------------
// DJ: Doubled defaultInfoWidth
// ----------------------------------------------------------------------

defaultproperties
{
     defaultInfoWidth=196
     HelpText="Toggles Crosshairs visibility."
     actionText="Cross|&hairs"
}
