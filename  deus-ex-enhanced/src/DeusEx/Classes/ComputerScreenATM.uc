//=============================================================================
// ComputerScreenATM
//=============================================================================
class ComputerScreenATM extends ComputerUIWindow;

var MenuUIActionButtonWindow btnLogin;
var MenuUIActionButtonWindow btnCancel;
var MenuUILabelWindow        winWarning;
var MenuUILabelWindow        winLoginInfo;
var MenuUISmallLabelWindow   winLoginError;
var MenuUIEditWindow         editAccount;
var MenuUIEditWindow         editPIN;

var ATM atmOwner;		// what ATM owns this window?

var localized String AccountLabel;
var localized String PinLabel;
var localized String LoginInfoText;
var localized String WarningText;
var localized String StatusText;
var localized String InvalidLoginMessage;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();
	EnableButtons();
}

// ----------------------------------------------------------------------
// CreateControls()
// ----------------------------------------------------------------------

function CreateControls()
{
	Super.CreateControls();

	btnCancel = winButtonBar.AddButton(ButtonLabelCancel, HALIGN_Right);
	btnLogin  = winButtonBar.AddButton(ButtonLabelLogin,  HALIGN_Right);

	CreateMenuLabel( 10 * dxEnhancedGUIScaleMultiplier, 
					111 * dxEnhancedGUIScaleMultiplier, AccountLabel, winClient);
	CreateMenuLabel( 10 * dxEnhancedGUIScaleMultiplier, 
					141 * dxEnhancedGUIScaleMultiplier, PINLabel, winClient);

	editAccount = CreateMenuEditWindow(131 * dxEnhancedGUIScaleMultiplier, 
									   109 * dxEnhancedGUIScaleMultiplier, 
									   143 * dxEnhancedGUIScaleMultiplier, 
									    24 * dxEnhancedGUIScaleMultiplier, winClient);
	editPIN     = CreateMenuEditWindow(131 * dxEnhancedGUIScaleMultiplier, 
									   139 * dxEnhancedGUIScaleMultiplier, 
									   143 * dxEnhancedGUIScaleMultiplier, 
									    24 * dxEnhancedGUIScaleMultiplier, winClient);

	CreateWarningWindow();
	CreateLoginInfoWindow();
	CreateLoginErrorWindow();

	winTitle.SetTitle(Title);
	winStatus.SetText(StatusText);
}

// ----------------------------------------------------------------------
// UpdateStatus()
// ----------------------------------------------------------------------

function UpdateStatus()
{
	// Update the title, texture and description
	winTitle.SetTitle(Title);
}

// ----------------------------------------------------------------------
// CreateWarningWindow()
// ----------------------------------------------------------------------

function CreateWarningWindow()
{
	winWarning = MenuUILabelWindow(winClient.NewChild(Class'MenuUILabelWindow'));

	winWarning.SetPos(   8 * dxEnhancedGUIScaleMultiplier, 10 * dxEnhancedGUIScaleMultiplier);
	winWarning.SetSize(273 * dxEnhancedGUIScaleMultiplier, 50 * dxEnhancedGUIScaleMultiplier);
	winWarning.SetTextAlignments(HALIGN_Center, VALIGN_Center);
	winWarning.SetTextMargins(0, 0);
	winWarning.SetText(WarningText);
}

// ----------------------------------------------------------------------
// CreateLoginInfoWindow()
// ----------------------------------------------------------------------

function CreateLoginInfoWindow()
{
	winLoginInfo = MenuUILabelWindow(winClient.NewChild(Class'MenuUILabelWindow'));

	winLoginInfo.SetPos(   8 * dxEnhancedGUIScaleMultiplier, 66 * dxEnhancedGUIScaleMultiplier);
	winLoginInfo.SetSize(273 * dxEnhancedGUIScaleMultiplier, 31 * dxEnhancedGUIScaleMultiplier);
	winLoginInfo.SetTextAlignments(HALIGN_Center, VALIGN_Center);
	winLoginInfo.SetTextMargins(0, 0);
	winLoginInfo.SetText(LoginInfoText);
}

// ----------------------------------------------------------------------
// CreateLoginErrorWindow()
// ----------------------------------------------------------------------

function CreateLoginErrorWindow()
{
	winLoginError = MenuUISmallLabelWindow(winClient.NewChild(Class'MenuUISmallLabelWindow'));

	winLoginError.SetPos(  80 * dxEnhancedGUIScaleMultiplier, 172 * dxEnhancedGUIScaleMultiplier);
	winLoginError.SetSize(287 * dxEnhancedGUIScaleMultiplier, 25 * dxEnhancedGUIScaleMultiplier);
	winLoginError.SetTextAlignments(HALIGN_Left, VALIGN_Center);
	winLoginError.SetTextMargins(0, 0);
}

// ----------------------------------------------------------------------
// SetCompOwner()
// ----------------------------------------------------------------------

function SetCompOwner(ElectronicDevices newCompOwner)
{
	Super.SetCompOwner(newCompOwner);
	atmowner = ATM(compOwner);

	SetFocusWindow(editAccount);

	// Check to see if this ATM has been sucked dry, in which
	// case we just want to show the the Disabled screen

	if (atmOwner.bSuckedDryByHack == True)
		CloseScreen("ATMDISABLED");
}

// ----------------------------------------------------------------------
// SetNetworkTerminal()
// ----------------------------------------------------------------------

function SetNetworkTerminal(NetworkTerminal newTerm)
{
	Super.SetNetworkTerminal(newTerm);

	// If the user already hacked this computer, then set the 
	// "Hack" button to "Return"
	if (winTerm != None)
		winTerm.SetHackButtonToReturn();
}

// ----------------------------------------------------------------------
// ButtonActivated()
// ----------------------------------------------------------------------

function bool ButtonActivated( Window buttonPressed )
{
	local bool bHandled;

	bHandled = True;

	switch( buttonPressed )
	{
		case btnLogin:
			ProcessLogin();
			break;

		case btnCancel:
			CloseScreen("EXIT");
			break;

		default:
			bHandled = False;
			break;
	}

	if (bHandled)
		return True;
	else
		return Super.ButtonActivated(buttonPressed);
}

// ----------------------------------------------------------------------
// EditActivated()
//
// Allow the user to press [Return] to accept the username/password
// ----------------------------------------------------------------------

event bool EditActivated(window edit, bool bModified)
{
	if (btnLogin.IsSensitive())
	{
		ProcessLogin();
		return True;
	}
	else
	{
		return False;
	}
}

// ----------------------------------------------------------------------
// ProcessLogin()
// ----------------------------------------------------------------------

function ProcessLogin()
{
	local bool bSuccessfulLogin;
	local int  accountIndex;
	local int  userIndex;

	bSuccessfulLogin = False;

	for (accountIndex=0; accountIndex<atmOwner.NumUsers(); accountIndex++)
	{
		if (Caps(editAccount.GetText()) == atmOwner.GetAccountNumber(accountIndex))
		{
			userIndex = accountIndex;
			break;
		}
	}

	if (userIndex != -1)
	{
		if (Caps(editPIN.GetText()) == atmOwner.GetPIN(userIndex))
			bSuccessfulLogin = True;
	}

	if (bSuccessfulLogin)
	{
		winTerm.SetLoginInfo("", userIndex);
		CloseScreen("LOGIN");
	}
	else
	{
		// Print a message about invalid login
		winLoginError.SetText(InvalidLoginMessage);

		// Clear text fields and reset focus
		editAccount.SetText("");
		editPIN.SetText("");
		SetFocusWindow(editAccount);
	}
}

// ----------------------------------------------------------------------
// TextChanged() 
// ----------------------------------------------------------------------

event bool TextChanged(window edit, bool bModified)
{
	EnableButtons();

	return False;
}

// ----------------------------------------------------------------------
// EnableButtons()
// ----------------------------------------------------------------------

function EnableButtons()
{
	// Text must be entered in the two fields for the login button to be
	// enabled

	btnLogin.SetSensitivity((editAccount.GetText() != "") && (editPIN.GetText() != ""));
}

// ----------------------------------------------------------------------
// DJ: Doubled values, except: textureRows, textureCols
// ----------------------------------------------------------------------

defaultproperties
{
     AccountLabel="Account #:"
     PinLabel="PIN #:"
     LoginInfoText="Please enter your Account # and Pin"
     WarningText="WARNING: Unauthorized access will be met with excessive force!"
     StatusText="PNGBS//GLOBAL//PUB:3902.9571[login]"
     InvalidLoginMessage="LOGIN ERROR, ACCESS DENIED"
     Title="PageNet Global Banking System"
     ClientWidth=606
     ClientHeight=462
     verticalOffset=60
     clientTextures(0)=Texture'DeusExUI.UserInterface.ComputerGBSLogonBackground_1'
     clientTextures(1)=Texture'DeusExUI.UserInterface.ComputerGBSLogonBackground_2'
     textureRows=1
     textureCols=2
     bAlwaysCenter=True
     statusPosY=412
}
