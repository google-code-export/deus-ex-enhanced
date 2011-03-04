//=============================================================================
// PersonaActionButtonWindow
//=============================================================================

class PersonaActionButtonWindow extends PersonaBorderButtonWindow;

// ----------------------------------------------------------------------
// DJ: Doubled values including widths
// ----------------------------------------------------------------------

defaultproperties
{
     Left_Textures(0)=(Tex=Texture'DeusExUI.UserInterface.PersonaActionButtonNormal_Left',Width=8)
     Left_Textures(1)=(Tex=Texture'DeusExUI.UserInterface.PersonaActionButtonPressed_Left',Width=8)
     Right_Textures(0)=(Tex=Texture'DeusExUI.UserInterface.PersonaActionButtonNormal_Right',Width=16)
     Right_Textures(1)=(Tex=Texture'DeusExUI.UserInterface.PersonaActionButtonPressed_Right',Width=16)
     Center_Textures(0)=(Tex=Texture'DeusExUI.UserInterface.PersonaActionButtonNormal_Center',Width=4)
     Center_Textures(1)=(Tex=Texture'DeusExUI.UserInterface.PersonaActionButtonPressed_Center',Width=4)
     buttonHeight=32
     minimumButtonWidth=40
}
