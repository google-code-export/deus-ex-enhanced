//=============================================================================
// PersonaHealthBodyWindow
//=============================================================================

class PersonaHealthBodyWindow extends Window;

const dxEnhancedGUIScaleMultiplier = 2;

var Texture bodyTextures[2];

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();

	SetSize(219 * dxEnhancedGUIScaleMultiplier, 357 * dxEnhancedGUIScaleMultiplier);
}

// ----------------------------------------------------------------------
// DrawWindow()
// ----------------------------------------------------------------------

event DrawWindow(GC gc)
{	
	// Draw window background
	gc.SetStyle(DSTY_Masked);

	gc.DrawTexture(0,   0, 219 * dxEnhancedGUIScaleMultiplier, 256 * dxEnhancedGUIScaleMultiplier, 0, 0, bodyTextures[0]);
	gc.DrawTexture(0, 256 * dxEnhancedGUIScaleMultiplier, 219 * dxEnhancedGUIScaleMultiplier, 101 * dxEnhancedGUIScaleMultiplier, 0, 0, bodyTextures[1]);
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     bodyTextures(0)=Texture'DeusExUI.UserInterface.HealthBody_1'
     bodyTextures(1)=Texture'DeusExUI.UserInterface.HealthBody_2'
}
