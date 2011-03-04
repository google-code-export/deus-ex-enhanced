//=============================================================================
// MenuChoice_AugsAllowed
//=============================================================================

class MenuChoice_AugsAllowed extends MenuChoice_OnOff;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();

   SetActionButtonWidth(179 * dxEnhancedGUIScaleMultiplier);
}

// ----------------------------------------------------------------------
// LoadSetting()
// ----------------------------------------------------------------------

function LoadSetting()
{
	local String SettingString;
	local int enumIndex;
	local int SettingChoice;

	SettingString = player.ConsoleCommand("get " $ configSetting);
	SettingChoice = 0;

	for (enumIndex=0; enumIndex<arrayCount(FalseTrue); enumIndex++)
	{
		if (FalseTrue[enumIndex] == SettingString)
		{
			SettingChoice = enumIndex;
			break;
		}	
	}

	SetValue(SettingChoice);
}

// ----------------------------------------------------------------------
// SaveSetting()
// ----------------------------------------------------------------------

function SaveSetting()
{
	player.ConsoleCommand("set " $ configSetting $ " " $ FalseTrue[GetValue()]);
}

// ----------------------------------------------------------------------
// DJ: Doubled values, except first
// ----------------------------------------------------------------------

defaultproperties
{
     defaultValue=1
     defaultInfoWidth=356
     defaultInfoPosX=408
     HelpText="Sets whether players receive starting augmentations and augmentations for kills."
     actionText="Augmentations"
     configSetting="DeusExMPGame bAugsAllowed"
}
