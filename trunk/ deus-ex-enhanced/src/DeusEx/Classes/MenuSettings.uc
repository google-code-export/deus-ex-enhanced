//=============================================================================
// MenuSettings
//=============================================================================

class MenuSettings expands MenuUIMenuWindow;

// ----------------------------------------------------------------------
// DJ: Doubled values, except last 1
// ----------------------------------------------------------------------

defaultproperties
{
     ButtonNames(0)="Keyboard/Mouse"
     ButtonNames(1)="Controls"
     ButtonNames(2)="Game Options"
     ButtonNames(3)="Display"
     ButtonNames(4)="Colors"
     ButtonNames(5)="Sound"
     ButtonNames(6)="Previous Menu"
     buttonXPos=14
     buttonWidth=564
     buttonDefaults(0)=(Y=26,Action=MA_MenuScreen,Invoke=Class'DeusEx.MenuScreenCustomizeKeys')
     buttonDefaults(1)=(Y=98,Action=MA_MenuScreen,Invoke=Class'DeusEx.MenuScreenControls')
     buttonDefaults(2)=(Y=170,Action=MA_MenuScreen,Invoke=Class'DeusEx.MenuScreenOptions')
     buttonDefaults(3)=(Y=242,Action=MA_MenuScreen,Invoke=Class'DeusEx.MenuScreenDisplay')
     buttonDefaults(4)=(Y=314,Action=MA_MenuScreen,Invoke=Class'DeusEx.MenuScreenAdjustColors')
     buttonDefaults(5)=(Y=386,Action=MA_MenuScreen,Invoke=Class'DeusEx.MenuScreenSound')
     buttonDefaults(6)=(Y=532,Action=MA_Previous)
     Title="Settings"
     ClientWidth=588
     ClientHeight=616
     clientTextures(0)=Texture'DeusExUI.UserInterface.MenuOptionsBackground_1'
     clientTextures(1)=Texture'DeusExUI.UserInterface.MenuOptionsBackground_2'
     clientTextures(2)=Texture'DeusExUI.UserInterface.MenuOptionsBackground_3'
     clientTextures(3)=Texture'DeusExUI.UserInterface.MenuOptionsBackground_4'
     textureCols=2
}
