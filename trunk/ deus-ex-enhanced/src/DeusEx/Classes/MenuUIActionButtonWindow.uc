//=============================================================================
// MenuUIActionButtonWindow
//=============================================================================

class MenuUIActionButtonWindow extends MenuUIBorderButtonWindow;

const dxEnhancedGUIScaleMultiplier = 2; 					// DJ: Added

// ----------------------------------------------------------------------
// DJ: Doubled values, and widths
// ----------------------------------------------------------------------

defaultproperties
{
     Left_Textures(0)=(Tex=Texture'DeusExUI.UserInterface.MenuActionButtonNormal_Left',Width=16)
     Left_Textures(1)=(Tex=Texture'DeusExUI.UserInterface.MenuActionButtonPressed_Left',Width=16)
     Right_Textures(0)=(Tex=Texture'DeusExUI.UserInterface.MenuActionButtonNormal_Right',Width=22)
     Right_Textures(1)=(Tex=Texture'DeusExUI.UserInterface.MenuActionButtonPressed_Right',Width=22)
     Center_Textures(0)=(Tex=Texture'DeusExUI.UserInterface.MenuActionButtonNormal_Center',Width=4)
     Center_Textures(1)=(Tex=Texture'DeusExUI.UserInterface.MenuActionButtonPressed_Center',Width=4)
     fontButtonText=Font'DeusExUI.FontMenuTitle'
     buttonHeight=38
     minimumButtonWidth=166
     textLeftMargin=16
}
