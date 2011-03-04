//=============================================================================
// PersonaGoalTextWindow
//=============================================================================

class PersonaGoalTextWindow extends TextWindow;

const dxEnhancedGUIScaleMultiplier = 2;

var Font fontText;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();
	
	SetFont(fontText);
	SetTextAlignments(HALIGN_Left, VALIGN_Center);
	SetTextMargins(5 * dxEnhancedGUIScaleMultiplier, 2 * dxEnhancedGUIScaleMultiplier);
}

// ----------------------------------------------------------------------
// StyleChanged()
// ----------------------------------------------------------------------

event StyleChanged()
{
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     fontText=Font'DeusExUI.FontMenuSmall'
}
