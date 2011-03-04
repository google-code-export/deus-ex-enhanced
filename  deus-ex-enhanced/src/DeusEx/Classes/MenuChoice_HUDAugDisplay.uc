//=============================================================================
// MenuChoice_HUDAugDisplay
//=============================================================================

class MenuChoice_HUDAugDisplay extends MenuUIChoiceEnum;

// ----------------------------------------------------------------------
// LoadSetting()
// ----------------------------------------------------------------------

function LoadSetting()
{
	SetValue(int(player.bHUDShowAllAugs));
}

// ----------------------------------------------------------------------
// SaveSetting()
// ----------------------------------------------------------------------

function SaveSetting()
{
	player.bHUDShowAllAugs = bool(GetValue());
	player.AugmentationSystem.RefreshAugDisplay();
}

// ----------------------------------------------------------------------
// ResetToDefault()
// ----------------------------------------------------------------------

function ResetToDefault()
{
	SetValue(defaultValue);
}

// ----------------------------------------------------------------------
// DJ: Doubled defaultInfoWidth
// ----------------------------------------------------------------------

defaultproperties
{
     enumText(0)="Active"
     enumText(1)="All Augs"
     defaultValue=1
     defaultInfoWidth=176
     HelpText="This setting determines which Augmentations are displayed in the HUD."
     actionText="HUD |&Augmentation Display"
}
