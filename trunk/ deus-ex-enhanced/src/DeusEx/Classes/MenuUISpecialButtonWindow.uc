//=============================================================================
// MenuUISpecialButtonWindow
//=============================================================================

class MenuUISpecialButtonWindow extends ButtonWindow;

const dxEnhancedGUIScaleMultiplier = 2; 				// DJ: Added

var DeusExPlayer player;

var Texture texNormal;
var Texture texFocus;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();
	
	// Get a pointer to the player
	player = DeusExPlayer(GetRootWindow().parentPawn);

	SetSize(25 * dxEnhancedGUIScaleMultiplier, 19 * dxEnhancedGUIScaleMultiplier);

	StyleChanged();
}

// ----------------------------------------------------------------------
// StyleChanged()
// ----------------------------------------------------------------------

event StyleChanged()
{
	local ColorTheme theme;
	local Color colButtonFace;

	theme         = player.ThemeManager.GetCurrentMenuColorTheme();
	colButtonFace = theme.GetColorFromName('MenuColor_ButtonFace');

	SetButtonColors(
		colButtonFace, colButtonFace, colButtonFace,
		colButtonFace, colButtonFace, colButtonFace);
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
}
