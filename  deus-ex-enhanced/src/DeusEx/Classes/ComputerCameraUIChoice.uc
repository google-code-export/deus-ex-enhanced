//=============================================================================
// ComputerCameraUIChoice
//=============================================================================

class ComputerCameraUIChoice extends MenuUIChoiceEnum
	abstract;

var ComputerSecurityCameraWindow winCamera;
var ComputerScreenSecurity       securityWindow;

// ----------------------------------------------------------------------
// SetCameraView()
// ----------------------------------------------------------------------

function SetCameraView(ComputerSecurityCameraWindow newCamera)
{
	winCamera = newCamera;
}

// ----------------------------------------------------------------------
// SetSecurityWindow()
// ----------------------------------------------------------------------

function SetSecurityWindow(ComputerScreenSecurity newScreen)
{
	securityWindow = newScreen;
}

// ----------------------------------------------------------------------
// DisableChoice()
// ----------------------------------------------------------------------

function DisableChoice()
{
	btnAction.DisableWindow();
	btnInfo.DisableWindow();
}

// ----------------------------------------------------------------------
// DJ: Doubled values
// ----------------------------------------------------------------------

defaultproperties
{
     defaultInfoWidth=226
     defaultInfoPosX=308
}
