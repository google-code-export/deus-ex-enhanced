//=============================================================================
// MenuChoice_MaxPlayers
//=============================================================================

class MenuChoice_MaxPlayers extends MenuUIChoiceSlider;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();

   SetActionButtonWidth(179 * dxEnhancedGUIScaleMultiplier);

   btnSlider.winSlider.SetValueFormat("%1.0f");
}

// ----------------------------------------------------------------------
// DJ: Doubled choiceControlPosX
// ----------------------------------------------------------------------

defaultproperties
{
     numTicks=16
     startValue=1.000000
     endValue=16.000000
     defaultValue=8.000000
     choiceControlPosX=406
     HelpText="Sets the maximum number of players allowed in the game."
     actionText="Maximum # of Players"
     configSetting="DeusExMPGame MaxPlayers"
}
