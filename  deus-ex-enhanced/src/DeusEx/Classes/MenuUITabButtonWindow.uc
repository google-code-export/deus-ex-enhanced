//=============================================================================
// MenuUITabButtonWindow
//=============================================================================

class MenuUITabButtonWindow expands ButtonWindow;

const dxEnhancedGUIScaleMultiplier = 2; 				// DJ: Added
var DeusExPlayer player;

var String buttonText;

// Defaults
var Color colText;
var Color colTextDisabled;

var Font fontText;
var int fontBaseLine;
var int fontAcceleratorLineHeight;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();

	EnableTextAsAccelerator(false);

	SetSize(70 * dxEnhancedGUIScaleMultiplier, 17 * dxEnhancedGUIScaleMultiplier);
	SetFont(fontText);
	SetBackgroundStyle(DSTY_Masked);
	SetButtonTextures(
		Texture'MenuTabButton_Normal', Texture'MenuTabButton_Pressed',
		Texture'MenuTabButton_Normal', Texture'MenuTabButton_Pressed',
		Texture'MenuTabButton_Normal', Texture'MenuTabButton_Normal');

	// Get a pointer to the player
	player = DeusExPlayer(GetRootWindow().parentPawn);

	SetBaselineData(fontBaseLine, fontAcceleratorLineHeight);

	StyleChanged();
}

// ----------------------------------------------------------------------
// DrawWindow()
// ----------------------------------------------------------------------

event DrawWindow(GC gc)
{	
	// Draw the text

	// If the button is insensitive, then draw it differently
	if (IsSensitive())
		gc.SetTextColor(colText);
	else
		gc.SetTextColor(colTextDisabled);

	// If the button is pressed, draw the text down and to the right
	if ( bButtonPressed )
		gc.DrawText(1, 1, width, height, buttonText); // DJ: Hmm...
	else
		gc.DrawText(0, 0, width, height, buttonText);
}

// ----------------------------------------------------------------------
// SetButtonText()
// ----------------------------------------------------------------------

function SetButtonText(String newButtonText)
{
	buttonText = newButtonText;

	SetAcceleratorText(newButtonText);
}

// ----------------------------------------------------------------------
// StyleChanged()
// ----------------------------------------------------------------------

event StyleChanged()
{
	local Color colButtonFace;
	local ColorTheme theme;

	theme = player.ThemeManager.GetCurrentMenuColorTheme();

	colButtonFace   = theme.GetColorFromName('MenuColor_ButtonFace');
	colText         = theme.GetColorFromName('MenuColor_ButtonTextNormal');
	colTextDisabled = theme.GetColorFromName('MenuColor_ButtonTextFocus');

	SetButtonColors(colButtonFace, colButtonFace, colButtonFace,
	                colButtonFace, colButtonFace, colButtonFace);
}

// ----------------------------------------------------------------------
// DJ: Hmmm...
// ----------------------------------------------------------------------

defaultproperties
{
     fontText=Font'DeusExUI.FontMenuTitle'
     fontBaseLine=1
     fontAcceleratorLineHeight=1
}
