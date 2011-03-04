//=============================================================================
// MenuChoice_FriendlyFire
//=============================================================================

class MenuChoice_FriendlyFire extends MenuUIChoiceSlider;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();

   SetActionButtonWidth(179 * dxEnhancedGUIScaleMultiplier);

   btnSlider.winSlider.SetValueFormat("%1.1f");
}

// ----------------------------------------------------------------------
// DJ: Doubled choiceControlPosX
// ----------------------------------------------------------------------

defaultproperties
{
     endValue=1.000000
     defaultValue=0.500000
     choiceControlPosX=406
     HelpText="Percentage of full damage received from friendly fire."
     actionText="Friendly Fire"
     configSetting="DeusExMPGame fFriendlyFireMult"
}
