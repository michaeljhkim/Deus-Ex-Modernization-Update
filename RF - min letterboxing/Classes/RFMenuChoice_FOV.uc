//=============================================================================
// RFMenuChoice_FOV
//
// Created for the Revision Framework, and may be used according to the project license.
//=============================================================================
class RFMenuChoice_FOV extends MenuUIChoiceEnum;

// ----------------------------------------------------------------------
// ButtonActivated()
// ----------------------------------------------------------------------

function bool ButtonActivated( Window buttonPressed )
{
	CycleNextValue();
	return True;
}

// ----------------------------------------------------------------------
// LoadSetting()
// ----------------------------------------------------------------------

function LoadSetting()
{
	//Round down.
	if (player.DesiredFOV < 82)
		SetValue(0);
	else if (player.DesiredFOV >= 82 && player.DesiredFOV < 84)
		SetValue(1);
	else if (player.DesiredFOV >= 84 && player.DesiredFOV < 86)
		SetValue(2);		
	else if (player.DesiredFOV >= 86 && player.DesiredFOV < 88)
		SetValue(3);
	else if (player.DesiredFOV >= 88 && player.DesiredFOV < 90)
		SetValue(4);
	else if (player.DesiredFOV >= 90 && player.DesiredFOV < 92)
		SetValue(5);
	else if (player.DesiredFOV >= 92 && player.DesiredFOV < 94)
		SetValue(6);
	else if (player.DesiredFOV >= 94 && player.DesiredFOV < 96)
		SetValue(7);
	else if (player.DesiredFOV >= 96 && player.DesiredFOV < 98)
		SetValue(8);
	else if (player.DesiredFOV >= 98 && player.DesiredFOV < 100)
		SetValue(9);
	else if (player.DesiredFOV >= 100 && player.DesiredFOV < 102)
		SetValue(10);
	else if (player.DesiredFOV >= 102 && player.DesiredFOV < 104)
		SetValue(11);
	else if (player.DesiredFOV >= 104 && player.DesiredFOV < 106)
		SetValue(12);
	else if (player.DesiredFOV >= 106 && player.DesiredFOV < 108)
		SetValue(13);
	else if (player.DesiredFOV >= 108 && player.DesiredFOV < 110)
		SetValue(14);
	else if (player.DesiredFOV >= 110 && player.DesiredFOV < 112)
		SetValue(15);
	else if (player.DesiredFOV >= 112 && player.DesiredFOV < 114)
		SetValue(16);
	else if (player.DesiredFOV >= 114 && player.DesiredFOV < 116)
		SetValue(17);
	else if (player.DesiredFOV >= 116 && player.DesiredFOV < 118)
		SetValue(18);
	else if (player.DesiredFOV >= 118 && player.DesiredFOV < 120)
		SetValue(19);
	else if (player.DesiredFOV >= 120)
		SetValue(20);
}

// ----------------------------------------------------------------------
// SaveSetting()
// ----------------------------------------------------------------------

function SaveSetting()
{
	local int newFov;
	
	//original this was just a switch case for all values for some reason
	//newFov = 80 + (2*currentValue); 
	switch (currentValue)
	{
		case (0):
			newFov = 80; break;
		case (1):
			newFov = 82; break;
		case (2):
			newFov = 84; break;
		case (3):
			newFov = 86; break;
		case (4):
			newFov = 88; break;
		case (5):
			newFov = 90; break;
		case (6):
			newFov = 92; break;
		case (7):
			newFov = 94; break;
		case (8):
			newFov = 96; break;
		case (9):
			newFov = 98; break;
		case (10):
			newFov = 100; break;
		case (11):
			newFov = 102; break;
		case (12):
			newFov = 104; break;
		case (13):
			newFov = 106; break;
		case (14):
			newFov = 108; break;
		case (15):
			newFov = 110; break;
		case (16):
			newFov = 112; break;
		case (17):
			newFov = 114; break;
		case (18):
			newFov = 116; break;
		case (19):
			newFov = 118; break;
		case (20):
			newFov = 120; break;
	}
	
	player.fov(newFov);
}

// ----------------------------------------------------------------------
// BoxOptionSelected()
// ----------------------------------------------------------------------

event bool BoxOptionSelected(Window button, int buttonNumber)
{
	if (buttonNumber == 0) 
		CyclePreviousValue();
	else
		CyclePreviousValue();
		
	return true;
}

// ----------------------------------------------------------------------
// ResetToDefault()
// ----------------------------------------------------------------------

function ResetToDefault()
{
	LoadSetting();
}

// ----------------------------------------------------------------------
// Default Property Values
// ----------------------------------------------------------------------
// changed default FOV to 90

defaultproperties
{
     enumText(0)="80"
     enumText(1)="82"
     enumText(2)="84"
     enumText(3)="86"
     enumText(4)="88"
     enumText(5)="90"
     enumText(6)="92"
     enumText(7)="94"
     enumText(8)="96"
     enumText(9)="98"
     enumText(10)="100"
     enumText(11)="102"
     enumText(12)="104"
     enumText(13)="106"
     enumText(14)="108"
     enumText(15)="110"
     enumText(16)="112"
     enumText(17)="114"
     enumText(18)="116"
     enumText(19)="118"
     enumText(20)="120"
     defaultValue=5
     defaultInfoWidth=98
     HelpText="Field of View controls how much of the world is in view. This is helpful for tuning the game to your display size and shape."
     actionText="Field of |&View"
}
