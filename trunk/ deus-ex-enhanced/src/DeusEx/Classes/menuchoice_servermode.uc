//=============================================================================
// MenuChoice_ServerMode
//=============================================================================

class MenuChoice_ServerMode extends MenuUIChoiceEnum;

var int    ServerModes; //const value for server modes
var localized String     ModeNames[2]; //Human readable server mode names.

const MODE_DEDICATED = 0;
const MODE_LISTEN = 1;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	PopulateServerModes();

	Super.InitWindow();

   SetInitialServerMode();

   SetActionButtonWidth(179 * dxEnhancedGUIScaleMultiplier);
}

// ----------------------------------------------------------------------
// PopulateServerModes()
// ----------------------------------------------------------------------

function PopulateServerModes()
{
	local int modeIndex;

   for (modeIndex = 0; modeIndex < arrayCount(ModeNames); modeIndex++)
   {
      enumText[modeIndex]=ModeNames[modeIndex];
   }
}

// ----------------------------------------------------------------------
// SetInitialServerMode()
// ----------------------------------------------------------------------

function SetInitialServerMode()
{
   local int ModeSetting;

   ModeSetting = int(player.ConsoleCommand("get" @ configsetting));

   SetValue(ModeSetting);
}

// ----------------------------------------------------------------------
// SaveSetting()
// ----------------------------------------------------------------------

function SaveSetting()
{
   player.ConsoleCommand("set" @ configsetting @ currentValue);
}

// ----------------------------------------------------------------------
// LoadSetting()
// ----------------------------------------------------------------------

function LoadSetting()
{
   local int ModeSetting;

   ModeSetting = int(player.ConsoleCommand("get" @ configsetting));

   SetValue(ModeSetting);
}

// ----------------------------------------------------------------------
// ResetToDefault
// ----------------------------------------------------------------------

function ResetToDefault()
{   
   player.ConsoleCommand("set " $ configSetting $ " " $ defaultValue);
   LoadSetting();
}

// ----------------------------------------------------------------------
// DJ: Doubled values defaultInfoWidth, defaultInfoPosX
// ----------------------------------------------------------------------

defaultproperties
{
     ModeNames(0)="Dedicated"
     ModeNames(1)="Non-Dedicated"
     defaultValue=1
     defaultInfoWidth=486
     defaultInfoPosX=406
     HelpText="Type of server to run.  Dedicated servers do not have a local player, but run faster."
     actionText="Server Mode"
     configSetting="MenuScreenHostGame ServerMode"
}
