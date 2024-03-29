//=============================================================================
// MenuScreenBrightness
//=============================================================================

class MenuScreenBrightness expands MenuUIScreenWindow;

var Color colRed;
var Color colGreen;
var Color colBlue;
var Color colWhite;

var localized string helpMessage;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();

	ShowHelp(helpMessage);

	// Don't mask this window, we want the user to see the 
	// 3D Scene unmolested to assist when setting the 
	// brightness.
	root.HideSnapshot();
}

// ----------------------------------------------------------------------
// DestroyWindow()
// ----------------------------------------------------------------------

event DestroyWindow()
{
	root.ShowSnapshot(True);

	Super.DestroyWindow();
}

// ----------------------------------------------------------------------
// CreateControls()
// ----------------------------------------------------------------------

function CreateControls()
{
	Super.CreateControls();

	// Create scale textures
	CreateScaleWindow(14  * dxEnhancedGUIScaleMultiplier, colRed);
	CreateScaleWindow(144 * dxEnhancedGUIScaleMultiplier, colGreen);
	CreateScaleWindow(274 * dxEnhancedGUIScaleMultiplier, colBlue);
	CreateScaleWindow(404 * dxEnhancedGUIScaleMultiplier, colWhite);

	// Create line
//	CreateScaleLine();
}

// ----------------------------------------------------------------------
// CreateScaleLine()
// ----------------------------------------------------------------------

function CreateScaleLine()
{
	local Window winLine;

	winLine = winClient.NewChild(Class'Window');
	winLine.SetPos(14 * dxEnhancedGUIScaleMultiplier, 178 * dxEnhancedGUIScaleMultiplier);
	winLine.SetSize(520 * dxEnhancedGUIScaleMultiplier, 1 * dxEnhancedGUIScaleMultiplier);
	winLine.SetBackground(Texture'Solid');
	winLine.SetBackgroundStyle(DSTY_Normal);
	winLine.SetTileColor(colWhite);
}

// ----------------------------------------------------------------------
// CreateScaleWindow()
// ----------------------------------------------------------------------

function CreateScaleWindow(int posX, Color colScale)
{
	local Window winScale;

	winScale = winClient.NewChild(Class'Window');
	winScale.SetPos(posX, 67 * dxEnhancedGUIScaleMultiplier);
	winScale.SetSize(130 * dxEnhancedGUIScaleMultiplier, 137 * dxEnhancedGUIScaleMultiplier);
	winScale.SetBackground(Texture'MenuBrightnessGradient');
	winScale.SetTileColor(colScale);
	winScale.SetBackgroundStyle(DSTY_Normal);
}

// ----------------------------------------------------------------------
// DJ: Doubled values
// ----------------------------------------------------------------------

defaultproperties
{
     colRed=(R=255)
     colGreen=(G=255)
     colBlue=(B=255)
     colWhite=(R=255,G=255,B=255)
     HelpMessage="Adjust the slider so the color bars fade smoothly to pure black at the bottom of the bars."
     choices(0)=Class'DeusEx.MenuChoice_AdjustBrightness'
     actionButtons(0)=(Align=HALIGN_Right,Action=AB_Cancel)
     actionButtons(1)=(Align=HALIGN_Right,Action=AB_OK)
     actionButtons(2)=(Action=AB_Reset)
     Title="Adjust Brightness"
     ClientWidth=1112
     ClientHeight=566
     clientTextures(0)=Texture'DeusExUI.UserInterface.MenuBrightnessBackground_1'
     clientTextures(1)=Texture'DeusExUI.UserInterface.MenuBrightnessBackground_2'
     clientTextures(2)=Texture'DeusExUI.UserInterface.MenuBrightnessBackground_3'
     clientTextures(3)=Texture'DeusExUI.UserInterface.MenuBrightnessBackground_4'
     clientTextures(4)=Texture'DeusExUI.UserInterface.MenuBrightnessBackground_5'
     clientTextures(5)=Texture'DeusExUI.UserInterface.MenuBrightnessBackground_6'
     bHelpAlwaysOn=True
     helpPosY=458
}
