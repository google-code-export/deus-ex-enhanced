//=============================================================================
// HUDCompassDisplay
//=============================================================================
class HUDCompassDisplay expands HUDBaseWindow;

var Color			colTickMarks;
var DeusExPlayer	player;
var Int				mapNorth;
var Float			UnitsPerPixel;
var Window			winCompass1;
var Window			winCompass2;
var Int				clipWidth;
var Int             clipWidthHalf;
var Int				tickWidth;

// Used in Tick()
var int             drawPos;
var int             wrapPos;
var int             lastPlayerYaw;

// Defaults
var Texture texBackground;
var Texture texBorder;
var Texture texTickBox;

// ----------------------------------------------------------------------
// InitWindow()
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();

	Hide();

	player = DeusExPlayer(DeusExRootWindow(GetRootWindow()).parentPawn);

	SetSize(73 * dxEnhancedGUIScaleMultiplier, 40 * dxEnhancedGUIScaleMultiplier);

	clipWidthHalf = clipWidth / 2;

	GetMapTrueNorth();
	CreateCompassWindow();
}

// ----------------------------------------------------------------------
// Tick()
//
// Used to update the position of the compass based on the
// direction the player is facing.
// ----------------------------------------------------------------------

event Tick(float deltaSeconds)
{
	// Only continue if we moved
	if (lastPlayerYaw != player.Rotation.Yaw)
	{
		lastPlayerYaw = player.Rotation.Yaw;

		// Based on the player's rotation and the map's True North, calculate
		// where to draw the tick marks and letters
		drawPos = clipWidthHalf - (((lastPlayerYaw - mapNorth) & 65535) / UnitsPerPixel);

		// We have two tickmark windows to compensate what happens with
		// the wrap condition.

		if ((drawPos > 0) && (drawPos < clipWidth))
			wrapPos = drawPos - tickWidth;
		else if (drawPos - tickWidth < (clipWidthHalf))
			wrapPos = drawPos + tickWidth;
		else
			wrapPos = 100 * dxEnhancedGUIScaleMultiplier; // DJ: I don't actually know what this line is for

		winCompass1.SetPos(drawPos, 0);
		winCompass2.SetPos(wrapPos, 0);
	}
}

// ----------------------------------------------------------------------
// VisibilityChanged()
// ----------------------------------------------------------------------

event VisibilityChanged(bool bNewVisibility)
{
	// If we becames visible make sure we enable the tick event so 
	// the compass position is enabled.
	bTickEnabled = bNewVisibility;
}

// ----------------------------------------------------------------------
// PostDrawWindow()
// ----------------------------------------------------------------------

function PostDrawWindow(GC gc)
{
	PostDrawBackground(gc);
}

// ----------------------------------------------------------------------
// PostDrawBackground()
// ----------------------------------------------------------------------

function DrawBackground(GC gc)
{
	gc.SetStyle(backgroundDrawStyle);
	gc.SetTileColor(colBackground);
	gc.DrawTexture( 11 * dxEnhancedGUIScaleMultiplier, 6 * dxEnhancedGUIScaleMultiplier, 
					60 * dxEnhancedGUIScaleMultiplier, 19 * dxEnhancedGUIScaleMultiplier, 0, 0, texBackground);
}

// ----------------------------------------------------------------------
// PostDrawBackground()
// ----------------------------------------------------------------------

function PostDrawBackground(GC gc)
{
	// Draw the tick box
	gc.SetTileColor(colBackground);
	gc.SetStyle(DSTY_Masked);
	gc.DrawTexture( 11 * dxEnhancedGUIScaleMultiplier, 6 * dxEnhancedGUIScaleMultiplier, 
					60 * dxEnhancedGUIScaleMultiplier, 19 * dxEnhancedGUIScaleMultiplier, 0, 0, texTickBox);
}

// ----------------------------------------------------------------------
// PostDrawBorder()
// ----------------------------------------------------------------------

function DrawBorder(GC gc)
{
	if (bDrawBorder)
	{
		gc.SetStyle(borderDrawStyle);
		gc.SetTileColor(colBorder);
		gc.DrawTexture(0, 0, 73 * dxEnhancedGUIScaleMultiplier, 
							 40 * dxEnhancedGUIScaleMultiplier, 0, 0, texBorder);
	}
}

// ----------------------------------------------------------------------
// CreateCompassWindow()
// ----------------------------------------------------------------------

function CreateCompassWindow()
{
	local Window winCompassClip;

	winCompassClip = NewChild(Class'Window');
	winCompassClip.SetSize(clipWidth, 22 * dxEnhancedGUIScaleMultiplier);
	winCompassClip.SetPos(13 * dxEnhancedGUIScaleMultiplier, 7 * dxEnhancedGUIScaleMultiplier);

	// Create the two windows that have the tick marks.  We need two 
	// of these because of the "wrap" point.
	winCompass1 = CreateTickWindow(winCompassClip);
	winCompass2 = CreateTickWindow(winCompassClip);

	// Calculate how many rotation units per pixel
	UnitsPerPixel = 65536 / tickWidth;
}

// ----------------------------------------------------------------------
// CreateTickWindow()
// ----------------------------------------------------------------------

function Window CreateTickWindow(Window winParent)
{
	local Window winCompass;

	winCompass = winParent.NewChild(Class'Window');
	winCompass.SetPos(0, 0);
	winCompass.SetSize(tickWidth, 15 * dxEnhancedGUIScaleMultiplier);
	winCompass.SetBackground(Texture'HUDCompassTicks');
	winCompass.SetBackgroundStyle(DSTY_Masked);
	winCompass.SetTileColor(colTickMarks);

	return winCompass;
}

// ----------------------------------------------------------------------
// SetVisibility()
// ----------------------------------------------------------------------

function SetVisibility( bool bNewVisibility )
{
	Show( bNewVisibility );

	bTickEnabled = bNewVisibility;
}

// ----------------------------------------------------------------------
// GetMapTrueNorth()
//
// Gets a pointer to the DeusExLevelInfo object and stores a local
// copy of the map rotation
// ----------------------------------------------------------------------

function GetMapTrueNorth()
{
	local DeusExLevelInfo info;

	if (player != None) 
	{
		info = player.GetLevelInfo();

		if (info != None)
			mapNorth = info.TrueNorth;
	}
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------
// DJ: Doubled the two values below

defaultproperties
{
     colTickMarks=(R=200,G=200,B=200)
     clipWidth=110
     tickWidth=480
     texBackground=Texture'DeusExUI.UserInterface.HUDCompassBackground_1'
     texBorder=Texture'DeusExUI.UserInterface.HUDCompassBorder_1'
     texTickBox=Texture'DeusExUI.UserInterface.HUDCompassTickBox'
}
