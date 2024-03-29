//=============================================================================
// PersonaHealthActionButtonWindow
//=============================================================================

class PersonaHealthActionButtonWindow extends PersonaBorderButtonWindow;

var localized String HealButtonLabel;
var int partIndex;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();

	SetSize(66 * dxEnhancedGUIScaleMultiplier, 13 * dxEnhancedGUIScaleMultiplier);
	SetButtonText(HealButtonLabel);	
}

// ----------------------------------------------------------------------
// SetPartIndex()
// ----------------------------------------------------------------------

function SetPartIndex(int newPartIndex)
{
	partIndex = newPartIndex;
}

// ----------------------------------------------------------------------
// GetPartIndex()
// ----------------------------------------------------------------------

function int GetPartIndex()
{
	return partIndex;
}

// ----------------------------------------------------------------------
// DJ: Doubled values and widths
// ----------------------------------------------------------------------

defaultproperties
{
     HealButtonLabel="Heal"
     Left_Textures(0)=(Tex=Texture'DeusExUI.UserInterface.HealthButtonNormal_Left',Width=8)
     Left_Textures(1)=(Tex=Texture'DeusExUI.UserInterface.HealthButtonPressed_Left',Width=8)
     Right_Textures(0)=(Tex=Texture'DeusExUI.UserInterface.HealthButtonNormal_Right',Width=16)
     Right_Textures(1)=(Tex=Texture'DeusExUI.UserInterface.HealthButtonPressed_Right',Width=16)
     Center_Textures(0)=(Tex=Texture'DeusExUI.UserInterface.HealthButtonNormal_Center',Width=4)
     Center_Textures(1)=(Tex=Texture'DeusExUI.UserInterface.HealthButtonPressed_Center',Width=4)
     buttonHeight=26
     minimumButtonWidth=132
}
