//=============================================================================
// HUDMedBotAugItemButton
//=============================================================================

//Modified -- Y|yukichigai

class HUDMedBotAugItemButton extends PersonaItemButton;

var AugmentationCannister augCan;

var bool bSlotFull;
var bool bHasIt;

var Color colBorder;
var Color colIconDisabled;
var Color colIconNormal;

// ----------------------------------------------------------------------
// DrawWindow()
// ----------------------------------------------------------------------

event DrawWindow(GC gc)
{
	local Augmentation anAug;

	anAug = GetAugmentation();
	//Only renders the icon disabled if the slot is full, not if you already have it
//	if ((bSlotFull)) // || (bHasIt))	
//		colIcon = colIconDisabled;
//	else

	if(!bHasIt || anAug.CurrentLevel < anAug.MaxLevel)
		colIcon = colIconNormal;
	else
		colIcon = colIconDisabled;

	Super.DrawWindow(gc);

	// Draw selection border
	if (!bSelected)
	{
		gc.SetTileColor(colBorder);
		gc.SetStyle(DSTY_Masked);
		gc.DrawBorders(0, 0, borderWidth, borderHeight, 0, 0, 0, 0, texBorders);
	}
}

// ----------------------------------------------------------------------
// SetAugmentation()
// ----------------------------------------------------------------------

function SetAugmentation(Augmentation newAug)
{
	SetClientObject(newAug);
	SetIcon(newAug.smallIcon);

	// First check to see if the player already has this augmentation
	bHasIt = newAug.bHasIt;

	// Now check to see if this augmentation slot is full
	bSlotFull = player.AugmentationSystem.AreSlotsFull(newAug);
}

// ----------------------------------------------------------------------
// SetAugCan()
// ----------------------------------------------------------------------

function SetAugCan(AugmentationCannister newAugCan)
{
	augCan = newAugCan;
}

// ----------------------------------------------------------------------
// GetAugCan()
// ----------------------------------------------------------------------

function AugmentationCannister GetAugCan()
{
	return augCan;
}

// ----------------------------------------------------------------------
// GetAugmentation()
// ----------------------------------------------------------------------

function Augmentation GetAugmentation()
{
	return Augmentation(GetClientObject());
}

// ----------------------------------------------------------------------
// GetAugDesc()
// ----------------------------------------------------------------------

function String GetAugDesc()
{
	if (GetClientObject() != None)
		return Augmentation(GetClientObject()).augmentationName;
	else
		return "";
}

// ----------------------------------------------------------------------
// StyleChanged()
// ----------------------------------------------------------------------

event StyleChanged()
{
	local ColorTheme theme;

	Super.StyleChanged();

	colBorder.r = Int(Float(colBackground.r) * 0.75);
	colBorder.g = Int(Float(colBackground.g) * 0.75);
	colBorder.b = Int(Float(colBackground.b) * 0.75);
}

// ----------------------------------------------------------------------
// DJ: Doubled values
// ----------------------------------------------------------------------

defaultproperties
{
     colIconDisabled=(R=64,G=64,B=64)
     colIconNormal=(R=255,G=255)
     iconPosWidth=64
     iconPosHeight=64
     buttonWidth=68
     buttonHeight=68
     borderWidth=68
     borderHeight=68
}
