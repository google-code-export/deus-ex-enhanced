//=============================================================================
// MenuChoice_WorldTextureDetail
//=============================================================================

class MenuChoice_WorldTextureDetail extends MenuChoice_LowMedHigh;

// ----------------------------------------------------------------------
// LoadSetting()
// ----------------------------------------------------------------------

function LoadSetting()
{
	local String detailString;
	local int enumIndex;
	local int detailChoice;

	detailString = player.ConsoleCommand("get " $ configSetting);
	detailChoice = 0;

	for (enumIndex=0; enumIndex<arrayCount(enumText); enumIndex++)
	{
		if (englishEnumText[enumIndex] == detailString)
		{
			detailChoice = enumIndex;
			break;
		}	
	}

	SetValue(detailChoice);
}

// ----------------------------------------------------------------------
// SaveSetting()
// ----------------------------------------------------------------------

function SaveSetting()
{
	player.ConsoleCommand("set " $ configSetting $ " " $ englishEnumText[GetValue()]);
}

// ----------------------------------------------------------------------
// DJ: Doubled value
// ----------------------------------------------------------------------

defaultproperties
{
     defaultInfoWidth=196
     HelpText="Change the amount of texture detail in the world"
     actionText="|&World Texture Detail"
     configSetting="ini:Engine.Engine.ViewportManager TextureDetail"
}
