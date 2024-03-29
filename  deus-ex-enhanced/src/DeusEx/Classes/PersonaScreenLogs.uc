//=============================================================================
// PersonaScreenLogs
//=============================================================================

class PersonaScreenLogs extends PersonaScreenBaseWindow;

var PersonaActionButtonWindow btnClear;
var PersonaListWindow         lstLogs;
var PersonaScrollAreaWindow   winScroll;

var localized String LogsTitleText;
var localized string ClearButtonLabel;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();

	PopulateLog();

	PersonaNavBarWindow(winNavBar).btnLogs.SetSensitivity(False);

	EnableButtons();
}

// ----------------------------------------------------------------------
// ButtonActivated()
// ----------------------------------------------------------------------

function bool ButtonActivated( Window buttonPressed )
{
	local bool bHandled;

	if ( Super.ButtonActivated( buttonPressed ) )
		return True;

	bHandled   = True;

	switch( buttonPressed )
	{
		case btnClear:
			ClearLog();
			break;

		default:
			bHandled = False;
			break;
	}

	return bHandled;
}


// ----------------------------------------------------------------------
// CreateControls()
// ----------------------------------------------------------------------

function CreateControls()
{
	Super.CreateControls();

	CreateTitleWindow(9 * dxEnhancedGUIScaleMultiplier, 5 * dxEnhancedGUIScaleMultiplier, LogsTitleText);
	CreateLogWindow();
	CreateButtons();
}

// ----------------------------------------------------------------------
// CreateLogWindow()
// ----------------------------------------------------------------------

function CreateLogWindow()
{
	winScroll = CreateScrollAreaWindow(winClient);
	winScroll.SetPos(16 * dxEnhancedGUIScaleMultiplier, 21 * dxEnhancedGUIScaleMultiplier);
	winScroll.SetSize(394 * dxEnhancedGUIScaleMultiplier, 361 * dxEnhancedGUIScaleMultiplier);

	lstLogs = PersonaListWindow(winScroll.clipWindow.NewChild(Class'PersonaListWindow'));
	lstLogs.EnableMultiSelect(False);
	lstLogs.EnableAutoExpandColumns(True);
	lstLogs.SetNumColumns(2);
	lstLogs.SetSortColumn(1, True);
	lstLogs.SetColumnType(1, COLTYPE_Float);
	lstLogs.SetColumnWidth(0, 394 * dxEnhancedGUIScaleMultiplier);
	lstLogs.HideColumn(1);
	lstLogs.EnableAutoSort(False);
}

// ----------------------------------------------------------------------
// CreateButtons()
// ----------------------------------------------------------------------

function CreateButtons()
{
	local PersonaButtonBarWindow winActionButtons;

	winActionButtons = PersonaButtonBarWindow(winClient.NewChild(Class'PersonaButtonBarWindow'));
	winActionButtons.SetPos(10 * dxEnhancedGUIScaleMultiplier, 385 * dxEnhancedGUIScaleMultiplier);
	winActionButtons.SetWidth(75 * dxEnhancedGUIScaleMultiplier);

	btnClear = PersonaActionButtonWindow(winActionButtons.NewChild(Class'PersonaActionButtonWindow'));
	btnClear.SetButtonText(ClearButtonLabel);
}

// ----------------------------------------------------------------------
// PopulateLog()
//
// Loops through all the log messages and displays them 
// ----------------------------------------------------------------------

function PopulateLog()
{
	local DeusExLog log;
	local int rowIndex;
	local int logCount;

	// Now loop through all the conversations and add them to the list
	log = player.FirstLog;
	logCount = 0;

	while(log != None)
	{
		rowIndex = lstLogs.AddRow(log.text $ ";" $ logCount++);
		log = log.next;
	}

	lstLogs.Sort();
}

// ----------------------------------------------------------------------
// ClearLog()
// ----------------------------------------------------------------------

function ClearLog()
{
	lstLogs.DeleteAllRows();
	player.ClearLog();
	EnableButtons();
}

// ----------------------------------------------------------------------
// EnableButtons()
// ----------------------------------------------------------------------

function EnableButtons()
{
	btnClear.SetSensitivity(lstLogs.GetNumRows() > 0);
}

// ----------------------------------------------------------------------
// DJ: Doubled values, except last 4
// ----------------------------------------------------------------------

defaultproperties
{
     LogsTitleText="Logs"
     ClearButtonLabel="Cl|&ear Log"
     ClientWidth=852
     ClientHeight=814
     clientOffsetX=210
     clientOffsetY=34
     clientTextures(0)=Texture'DeusExUI.UserInterface.LogsBackground_1'
     clientTextures(1)=Texture'DeusExUI.UserInterface.LogsBackground_2'
     clientTextures(2)=Texture'DeusExUI.UserInterface.LogsBackground_3'
     clientTextures(3)=Texture'DeusExUI.UserInterface.LogsBackground_4'
     clientBorderTextures(0)=Texture'DeusExUI.UserInterface.ConversationsBorder_1'
     clientBorderTextures(1)=Texture'DeusExUI.UserInterface.ConversationsBorder_2'
     clientBorderTextures(2)=Texture'DeusExUI.UserInterface.ConversationsBorder_3'
     clientBorderTextures(3)=Texture'DeusExUI.UserInterface.ConversationsBorder_4'
     clientBorderTextures(4)=Texture'DeusExUI.UserInterface.ConversationsBorder_5'
     clientBorderTextures(5)=Texture'DeusExUI.UserInterface.ConversationsBorder_6'
     clientTextureRows=2
     clientTextureCols=2
     clientBorderTextureRows=2
     clientBorderTextureCols=3
}
