//=============================================================================
// HUDObjectBelt
//=============================================================================
class HUDObjectBelt expands HUDBaseWindow;

var TileWindow winSlots;				// Window containing slots
var HUDObjectSlot objects[10];

var int	KeyRingSlot;
var Bool bInteractive;

// Defaults
var Texture texBackgroundLeft;
var Texture texBackgroundRight;
var Texture texBorder[3];

// ----------------------------------------------------------------------
// InitWindow()
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();

	// Hardcoded size, baby!
	SetSize(541 * dxEnhancedGUIScaleMultiplier, 69 * dxEnhancedGUIScaleMultiplier);
	
	CreateSlots();
	CreateNanoKeySlot();

	PopulateBelt();
}

// ----------------------------------------------------------------------
// CreateSlots()
//
// Creates the Slots 
// ----------------------------------------------------------------------

function CreateSlots()
{
	local int i;
	local RadioBoxWindow winRadio;

	// Radio window used to contain objects so they can be selected
	// with the mouse on the inventory screen.

	winRadio = RadioBoxWindow(NewChild(Class'RadioBoxWindow'));
	winRadio.SetSize(504 * dxEnhancedGUIScaleMultiplier, 
					( 54 * dxEnhancedGUIScaleMultiplier) + 
					(dxEnhancedGUIScaleMultiplier / 2) * 3);
	winRadio.SetPos(10 * dxEnhancedGUIScaleMultiplier, (6 * dxEnhancedGUIScaleMultiplier));
	winRadio.bOneCheck = False;

	winSlots = TileWindow(winRadio.NewChild(Class'TileWindow'));
	winSlots.SetMargins(0, 0);
	winSlots.SetMinorSpacing(0);
	winSlots.SetOrder(ORDER_LeftThenUp);

	for (i = 0; i < 10; i++)
	{
		objects[i] = HUDObjectSlot(winSlots.NewChild(Class'HUDObjectSlot'));
		objects[i].SetObjectNumber(i);
		objects[i].Lower();

		// Last item is a little shorter 	// DJ:  they mean "do this to make it shorter" 
		if (i == 0)
		{
			objects[0].SetWidth(44 * dxEnhancedGUIScaleMultiplier);
			objects[0].SetHeight(111); 		// DJ: added
		}
		else 								// DJ: added this else block to set the height and width of the belt icons, because it's the only way that worked!
		{
			objects[i].SetWidth(102);
			objects[i].SetHeight(111);
		}
		
	}
	objects[0].Lower();

}

// ----------------------------------------------------------------------
// CreateNanoKeySlot()
//
// The last object slot contains the NanoKeyRing, which lets the user
// easily open doors for which they have the code (Know the code!)
// ----------------------------------------------------------------------

function CreateNanoKeySlot()
{
	if (player != None)
	{
		if (player.KeyRing != None)
		{
			objects[KeyRingSlot].SetItem(player.KeyRing);
			objects[KeyRingSlot].AllowDragging(False);
		}
	}
}

// ----------------------------------------------------------------------
// DrawBackground()
// ----------------------------------------------------------------------

function DrawBackground(GC gc)
{
	local Color newBackground;

	gc.SetStyle(backgroundDrawStyle);

	if (( player != None ) && (player.Level.NetMode != NM_Standalone) && ( player.bBuySkills ))
	{
		newBackground.r = colBackground.r / 2;
		newBackground.g = colBackground.g / 2;
		newBackground.b = colBackground.b / 2;
		gc.SetTileColor(newBackground);
	}
	else
		gc.SetTileColor(colBackground);

	gc.DrawTexture(  2 * dxEnhancedGUIScaleMultiplier, 6 * dxEnhancedGUIScaleMultiplier, 9 * dxEnhancedGUIScaleMultiplier, 54 * dxEnhancedGUIScaleMultiplier, 0, 0, texBackgroundLeft);
	gc.DrawTexture(514 * dxEnhancedGUIScaleMultiplier, 6 * dxEnhancedGUIScaleMultiplier, 8 * dxEnhancedGUIScaleMultiplier, 54 * dxEnhancedGUIScaleMultiplier, 0, 0, texBackgroundRight);
}

// ----------------------------------------------------------------------
// DrawBorder()
// ----------------------------------------------------------------------

function DrawBorder(GC gc)
{
	local Color newCol;

	if (bDrawBorder)
	{
		gc.SetStyle(borderDrawStyle);
		if (( player != None ) && ( player.bBuySkills ))
		{
			newCol.r = colBorder.r / 2;
			newCol.g = colBorder.g / 2;
			newCol.b = colBorder.b / 2;
			gc.SetTileColor(newCol);
		}
		else
			gc.SetTileColor(colBorder);

		gc.DrawTexture(  0, 0, 256 * dxEnhancedGUIScaleMultiplier, 69 * dxEnhancedGUIScaleMultiplier, 0, 0, texBorder[0]);
		gc.DrawTexture(256 * dxEnhancedGUIScaleMultiplier, 0, 256 * dxEnhancedGUIScaleMultiplier, 69 * dxEnhancedGUIScaleMultiplier, 0, 0, texBorder[1]);
		gc.DrawTexture(512 * dxEnhancedGUIScaleMultiplier, 0,  29 * dxEnhancedGUIScaleMultiplier, 69 * dxEnhancedGUIScaleMultiplier, 0, 0, texBorder[2]);
	}
}

// ----------------------------------------------------------------------
// UpdateInHand()
// 
// Called when the player's "inHand" variable changes
// ----------------------------------------------------------------------

function UpdateInHand()
{
	local int slotIndex;
	local bool bPressed;
	
	// highlight the slot and unhighlight the other slots
	if ((player != None) && (!bInteractive))
	{
		bPressed = False;
		for (slotIndex=0; slotIndex<ArrayCount(objects); slotIndex++)
		{
			// Highlight the object in the player's hand
			if ((player.inHand != None) && (objects[slotIndex].item == player.inHand))
				objects[slotIndex].HighlightSelect(True);
			else
				objects[slotIndex].HighlightSelect(False);

			//== We only want to actually activate one of these buttons for multi-slot items in MP
			if ((player.inHandPending != None) && //(player.inHandPending != player.inHand) &&
			    (objects[slotIndex].item == player.inHandPending) && !bPressed)
			{
				objects[slotIndex].SetToggle(true);
				bPressed = True;
			}
			else
				objects[slotIndex].SetToggle(false);
		}
	}
}

// ----------------------------------------------------------------------
// SetInteractive()
// ----------------------------------------------------------------------

function SetInteractive(bool bNewInteractive)
{
	bInteractive = bNewInteractive;
}

// ----------------------------------------------------------------------
// IsValidPos()
// ----------------------------------------------------------------------

function bool IsValidPos(int pos)
{
	// Don't allow NanoKeySlot to be used
	if ((pos >= 0) && (pos < 10))
		return true;
	else
		return false;
}

// ----------------------------------------------------------------------
// ClearPosition()
// ----------------------------------------------------------------------

function ClearPosition(int pos)
{
	if (IsValidPos(pos))
		objects[pos].SetItem(None);
}

// ----------------------------------------------------------------------
// ClearBelt()
//
// Removes all items from belt
// ----------------------------------------------------------------------

function ClearBelt()
{
	local int beltPos;

	for(beltPos=0; beltPos<10; beltPos++)
		ClearPosition(beltPos);
}

// ----------------------------------------------------------------------
// RemoveObjectFromBelt()
// ----------------------------------------------------------------------

function RemoveObjectFromBelt(Inventory item)
{
	local int i;
	local int j;
	local int StartPos;

	local Inventory itemp;


	j = 0;
   StartPos = 1;
   if ( (Player != None) && (Player.Level.NetMode != NM_Standalone) && (Player.bBeltIsMPInventory) )
      StartPos = 0;

	for (i=StartPos; IsValidPos(i); i++)
	{
		if (objects[i].GetItem() == item)
		{
			objects[i].SetItem(None);
			item.bInObjectBelt = False;
			item.beltPos = -1;
			if(Player.Level.NetMode != NM_Standalone && Player.bBeltIsMPInventory)
			{
				if(i == 7)
				{
					if(DeusExWeapon(Player.FindInventoryType(Class'DeusEx.WeaponEMPGrenade')).AmmoType.AmmoAmount > 0)
						AddObjectToBelt(Player.FindInventoryType(Class'DeusEx.WeaponEMPGrenade'),i,false);

					else if(DeusExWeapon(Player.FindInventoryType(Class'DeusEx.WeaponGasGrenade')).AmmoType.AmmoAmount > 0)
						AddObjectToBelt(Player.FindInventoryType(Class'DeusEx.WeaponGasGrenade'),i,false);

					else if(DeusExWeapon(Player.FindInventoryType(Class'DeusEx.WeaponLAM')).AmmoType.AmmoAmount > 0)
						AddObjectToBelt(Player.FindInventoryType(Class'DeusEx.WeaponLAM'),i,false);
				}
				if(i == 8)
				{
					if(DeusExPickup(Player.FindInventoryType(Class'DeusEx.Medkit')).NumCopies > 0)
						AddObjectToBelt(Player.FindInventoryType(Class'DeusEx.Medkit'),i,false);
					else if(DeusExPickup(Player.FindInventoryType(Class'DeusEx.BioelectricCell')).NumCopies > 0)
						AddObjectToBelt(Player.FindInventoryType(Class'DeusEx.BioelectricCell'),i,false);
				}
				j++;
				if(j > 9)
					break;
			}
			else
			{
				if(item.IsA('LockPick') && DeusExPickup(Player.FindInventoryType(Class'DeusEx.Lockpick')).NumCopies <= 0)
				{
					itemp = Player.FindInventoryType(Class'DeusEx.Multitool');
					if(DeusExPickup(itemp).NumCopies > 0 && (itemp.beltPos == -1 || itemp.beltPos == i))
						AddObjectToBelt(itemp,i,false);
				}
				else if(item.IsA('Multitool') && DeusExPickup(Player.FindInventoryType(Class'DeusEx.Multitool')).NumCopies <= 0)
				{
					itemp = Player.FindInventoryType(Class'DeusEx.Lockpick');
					if(DeusExPickup(itemp).NumCopies > 0 && (itemp.beltPos == -1 || itemp.beltPos == i))
						AddObjectToBelt(itemp,i,false);
				}
				break;
			}
		}
	}
}

// ----------------------------------------------------------------------
// UpdateObjectText()
// ----------------------------------------------------------------------

function UpdateObjectText(int pos)
{
	// First find the object
	if (IsValidPos(pos))
		objects[pos].UpdateItemText();		
}

// ----------------------------------------------------------------------
// AddObjectToBelt()
// ----------------------------------------------------------------------

function bool AddObjectToBelt(Inventory newItem, int pos, bool bOverride)
{
	local int  i;
	local int j;
	local int MPsize;
	local int counter;
   local int FirstPos;
	local bool retval;

	retval = true;

	if ((newItem != None ) && (newItem.Icon != None))
	{
		// If this is the NanoKeyRing, force it into slot 0
		if (newItem.IsA('NanoKeyRing'))
		{
			ClearPosition(0);
			pos = 0;
		}

		//Y|yukichigai -- Okay, test to see if this is a category weapon and if the slot is filled
		for(i = 7; i <= 9; i++)
		{
			if(newItem.testMPBeltSpot(i) && Player.Level.NetMode != NM_Standalone)
			{
				if(objects[i].GetItem() != None)
				{
					ClearPosition(i);
					pos = i;
				}
//				else
//					return false;
					
			}
		}

		if (  (!IsValidPos(pos)) || 
            (  (Player.Level.NetMode != NM_Standalone) && 
               (Player.bBeltIsMPInventory) && 
               (!newItem.TestMPBeltSpot(pos)) ) )
		{
         FirstPos = 1;
         if ((Player.Level.NetMode != NM_Standalone) && (Player.bBeltIsMPInventory))
            FirstPos = 0;
			for (i=FirstPos; IsValidPos(i); i++)
      	   		{
				if ((objects[i].GetItem() == None) && ( (Player.Level.NetMode == NM_Standalone) || (!Player.bBeltIsMPInventory) || (newItem.TestMPBeltSpot(i))))
            			{
					break;
            			}
         		}
			if (!IsValidPos(i))
			{
				if(!newItem.IsA('Lockpick') && !newItem.IsA('Multitool') && !newItem.IsA('Medkit') && !newItem.IsA('BioelectricCell')
				   && !newItem.IsA('WeaponGasGrenade') && !newItem.IsA('WeaponEMPGrenade') && !newItem.IsA('WeaponLAM'))
				{
					if (bOverride)
						pos = 1;
				}
			}
			else
			{
				pos = i;
			}
		}

		if (IsValidPos(pos))
		{
			// If there's already an object here, remove it
			if ( objects[pos].GetItem() != None )
			{
				RemoveObjectFromBelt(objects[pos].GetItem());
			}

			//=== Add in some more hairy stuff for the new Deus Ex MP -- Y|yukichigai
			MPSize = Player.MPBeltSizer(newItem);
			if ((Player.Level.NetMode != NM_Standalone) && (Player.bBeltIsMPInventory) && MPSize > 1)
			{
				i = pos;
				for(j = 1; j < 7; j++)
				{
					if(objects[i].GetItem() == None)
						counter++;
					if(counter == MPSize)
						break;
					i++;
					if(i > 6)
						i = 1;
				}
				i = pos;
				if(counter == MPSize)
				{
					counter = 0;
					for(j = 1; j < 7; j++)
					{
						if(objects[i].GetItem() == None)
						{
							objects[i].SetItem(newItem);
							counter++;
						}
						if(counter == MPSize)
							break;
						i++;
						if(i > 6)
							i = 1;
					}
				}
				else
					retval = false;
			}
			else
				objects[pos].SetItem(newItem);
		}
		else
		{
			retval = false;
		}
	}
	else
		retval = false;

	// The inventory item needs to know it's in the object
	// belt, as well as the location inside the belt.  This is used
	// when traveling to a new map.

	if ((retVal) && (Player.Role == ROLE_Authority))
	{
		newItem.bInObjectBelt = True;
		newItem.beltPos = pos;
	}

	UpdateInHand();

	return (retval);
}

// ----------------------------------------------------------------------
// GetObjectFromBelt()
// ----------------------------------------------------------------------

function Inventory GetObjectFromBelt(int pos)
{
	if (IsValidPos(pos))
		return (objects[pos].GetItem());
	else
		return (None);
}

// ----------------------------------------------------------------------
// SetVisibility()
// ----------------------------------------------------------------------

function SetVisibility( bool bNewVisibility )
{
	Show( bNewVisibility );
}

// ----------------------------------------------------------------------
// PopulateBelt()
//
// Looks through the player's inventory and rebuilds the object belt
// based on the inventory items.  This needs to be done after a load
// game
// ----------------------------------------------------------------------

function PopulateBelt()
{
	local Inventory anItem;
	local HUDObjectBelt belt;
	local DeusExPlayer player;

	// Get a pointer to the player
	player = DeusExPlayer(DeusExRootWindow(GetRootWindow()).parentPawn);

	for (anItem=player.Inventory; anItem!=None; anItem=anItem.Inventory)
		if (anItem.bInObjectBelt)
      {
			AddObjectToBelt(anItem, anItem.beltPos, True);
      }
}

// ----------------------------------------------------------------------
// RefreshHUDDisplay()
// ----------------------------------------------------------------------

function RefreshHUDDisplay(float DeltaTime)
{
    ClearBelt();
    PopulateBelt();
    UpdateInHand();
    Super.RefreshHUDDisplay(DeltaTime);
}

// ----------------------------------------------------------------------
// AssignWinInv()
// ----------------------------------------------------------------------

function AssignWinInv(PersonaScreenInventory newWinInventory)
{
	local Int slotIndex;

	// Update the individual slots
	for (slotIndex=0; slotIndex<10; slotIndex++)
		objects[slotIndex].AssignWinInv(newWinInventory);

	UpdateInHand();
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     texBackgroundLeft=Texture'DeusExUI.UserInterface.HUDObjectBeltBackground_Left'
     texBackgroundRight=Texture'DeusExUI.UserInterface.HUDObjectBeltBackground_Right'
     texBorder(0)=Texture'DeusExUI.UserInterface.HUDObjectBeltBorder_1'
     texBorder(1)=Texture'DeusExUI.UserInterface.HUDObjectBeltBorder_2'
     texBorder(2)=Texture'DeusExUI.UserInterface.HUDObjectBeltBorder_3'
}
