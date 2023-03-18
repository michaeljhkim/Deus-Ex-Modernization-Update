//=============================================================================
// RFMenuScreenLoadGame.
//
// Created for the Revision Framework, and may be used according to the project license.
//=============================================================================
class RFMenuScreenLoadGame extends MenuScreenLoadGame;

// ----------------------------------------------------------------------
// UpdateFreeDiskSpace()
// ----------------------------------------------------------------------

function UpdateFreeDiskSpace()
{
	local GameDirectory saveDir;
	local int freeDiskSpaceMegaByte;

	saveDir = player.CreateGameDirectoryObject();
	freeDiskSpace = saveDir.GetSaveFreeSpace();
	//freeDiskSpace = -1545314777; // Testing.

	// Special value indicating 4GB+
	if ( freeDiskSpace==0xFFFFFFFF )
	{
		winFreeSpace.SetText(Sprintf(FreeSpaceLabel,"4194304")$"+");
		winFreeSpace.SetTextColorRGB(0,255,0);
	}
	else
	{
		// Emulate a logic shift.
		if ( freeDiskSpace>=0 ) // Checks sign bit.
			freeDiskSpaceMegaByte = freeDiskSpace>>10;
		else
			freeDiskSpaceMegaByte = ((freeDiskSpace&0x7FFFFFFF)>>10)+0x200000;

		//winFreeSpace.SetText(Sprintf(FreeSpaceLabel,freeDiskSpace>>10));
		winFreeSpace.SetText(Sprintf(FreeSpaceLabel,freeDiskSpaceMegaByte));

		// If free space is below the minimum, show in RED
		//else if ( (freeDiskSpace>>10)<minFreeDiskSpace )
		if ( freeDiskSpaceMegaByte<minFreeDiskSpace )
			winFreeSpace.SetTextColorRGB(255,0,0);
		else
			winFreeSpace.StyleChanged();
	}

	CriticalDelete(savedir);
}

// ----------------------------------------------------------------------
// EnableButtons()
//
// Checks the state of the list control and updates the pushbuttons
// appropriately
// ----------------------------------------------------------------------

function EnableButtons()
{
	EnableActionButton(AB_Other, (lstGames.GetNumSelectedRows() > 0), "LOAD");

	// Cannot delete rows that have a saveindex < 0
	if (lstGames.GetNumSelectedRows() > 0)
		EnableActionButton(AB_Other, True,  "DELETE");
	else
		EnableActionButton(AB_Other, False, "DELETE");
}

// ----------------------------------------------------------------------
// CreateGamesList()
//
// Creates the listbox containing the save games
//
// Column 0 = Save Description (typed by user)
// Column 1 = Human Readable Date/Time stamp
// Column 2 = Sort column on Julian date
// Column 3 = 
// Column 4 = Save File Index (0 - 9999)
// ----------------------------------------------------------------------

function CreateGamesList()
{
	winScroll = CreateScrollAreaWindow(winClient);

	winScroll.SetPos(11, 22);
	winScroll.SetSize(371, 270);

	lstGames = MenuUIListWindow(winScroll.clipWindow.NewChild(Class'MenuUIListWindow'));
	lstGames.EnableMultiSelect(False);
	lstGames.EnableAutoExpandColumns(False);

	lstGames.SetNumColumns(5);

	lstGames.SetColumnWidth(0, 225);	// Was 240, changed to fix scroll bar overwriting am/pm
	lstGames.SetColumnType(0, COLTYPE_String);
	lstGames.SetColumnWidth(1, 131);
	lstGames.SetColumnType(1, COLTYPE_String);
	lstGames.SetColumnFont(1, Font'FontFixedWidthSmall');

	lstGames.SetColumnType(2, COLTYPE_Float);
	lstGames.SetSortColumn(2, bDateSortOrder);
	lstGames.EnableAutoSort(True);
	
	lstGames.SetColumnType(4, COLTYPE_Float);

	lstGames.HideColumn(2);
	lstGames.HideColumn(3);
	lstGames.HideColumn(4);
}

// ----------------------------------------------------------------------
// CreateHeaderButtons()
// ----------------------------------------------------------------------

function CreateHeaderButtons()
{
	btnHeaderName = CreateHeaderButton(10,  3, 223, strHeaderNameLabel, winClient);
	btnHeaderDate = CreateHeaderButton(236, 3, 146, strHeaderDateLabel, winClient);
}

// ----------------------------------------------------------------------
// BuildTimeStringFromInfo()
// ----------------------------------------------------------------------

function String BuildTimeStringFromInfo(DeusExSaveInfo saveInfo)
{
	local String retValue;
	

	if ( saveInfo == None )
	{
		retValue = "DeusExLevelInfo Missing";
		retValue = "";
	}
	else
	{
		if (player != None && bool(player.GetPropertyText("bUseEUTimestamps")))
		{
			retValue = BuildEUTimeString(
				saveInfo.Year, saveInfo.Month, saveInfo.Day,
				saveInfo.Hour, saveInfo.Minute);
		}
		else
		{
			retValue = BuildTimeString(
				saveInfo.Year, saveInfo.Month, saveInfo.Day,
				saveInfo.Hour, saveInfo.Minute);
		}
	}

	return retValue;
}

// ----------------------------------------------------------------------
// BuildEUTimeString()
// ----------------------------------------------------------------------

function String BuildEUTimeString(
	int Year,
	int Month,
	int Day,
	int Hour,
	int Minute)
{
	local String retValue;

	retValue = TwoDigits(Day) $ "/" $ TwoDigits(Month) $ "/" $ Year $ " ";
	retValue = retValue $ TwoDigits(Hour) ;
	retValue = retValue $ ":" $ TwoDigits(Minute);

	return retValue;
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
    minFreeDiskSpace=125
    clientTextures(0)=None
    clientTextures(1)=None
    clientTextures(2)=None
    clientTextures(3)=None
    clientTextures(4)=None
    clientTextures(5)=None
}
