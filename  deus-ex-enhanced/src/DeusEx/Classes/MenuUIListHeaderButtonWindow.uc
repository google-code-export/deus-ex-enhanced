//=============================================================================
// MenuUIListHeaderButtonWindow
//=============================================================================

class MenuUIListHeaderButtonWindow extends MenuUIBorderButtonWindow;

// ----------------------------------------------------------------------
// StyleChanged()
// ----------------------------------------------------------------------

event StyleChanged()
{
	Super.StyleChanged();

	// Override disabled color
	colText[3] = colText[2];
}

// ----------------------------------------------------------------------
// DJ: Doubled values, including widths
// ----------------------------------------------------------------------

defaultproperties
{
     Left_Textures(0)=(Tex=Texture'DeusExUI.UserInterface.MenuListHeaderButtonNormal_Left',Width=10)
     Left_Textures(1)=(Tex=Texture'DeusExUI.UserInterface.MenuListHeaderButtonPressed_Left',Width=10)
     Right_Textures(0)=(Tex=Texture'DeusExUI.UserInterface.MenuListHeaderButtonNormal_Right',Width=26)
     Right_Textures(1)=(Tex=Texture'DeusExUI.UserInterface.MenuListHeaderButtonPressed_Right',Width=26)
     Center_Textures(0)=(Tex=Texture'DeusExUI.UserInterface.MenuListHeaderButtonNormal_Center',Width=4)
     Center_Textures(1)=(Tex=Texture'DeusExUI.UserInterface.MenuListHeaderButtonPressed_Center',Width=4)
     colText(0)=(R=197,G=225,B=247)
     colText(3)=(R=255,G=255,B=255)
     fontButtonText=Font'DeusExUI.FontMenuHeaders'
     buttonHeight=30
     minimumButtonWidth=166
     textLeftMargin=16
}
