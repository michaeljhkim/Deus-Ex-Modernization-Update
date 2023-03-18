//=============================================================================
// RFMenuChoice_UIScaling
//
// Created for the Revision Framework, and may be used according to the project license.
//=============================================================================
class RFMenuChoice_UIScaling extends MenuUIChoiceEnum;

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
	SetValue(Int(player.ConsoleCommand("get" @ configSetting)) + 1);
}

// ----------------------------------------------------------------------
// SaveSetting()
// ----------------------------------------------------------------------

function SaveSetting()
{
	//Change user.ini setting, our ini settings go from -1 and up (no real limit) so here we just offset since our values here go from 0 to 3.
	player.ConsoleCommand("set" @ configSetting @ currentValue-1);
}

// ----------------------------------------------------------------------
// BoxOptionSelected()
// ----------------------------------------------------------------------

event bool BoxOptionSelected(Window button, int buttonNumber)
{
	CyclePreviousValue();
	return True;
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
    enumText(0)="Relaxed"
    enumText(1)="Dynamic"
    enumText(2)="Normal"
    enumText(3)="HiDPI"
    defaultValue=2
    defaultInfoWidth=98
    HelpText="In dynamic mode, the UI is scaled based on your resolution. HiDPI enlarges the UI up to 2x scale. Relaxed may be useful for unusual resolutions."
    actionText="|&UI Scaling"
    configSetting="RFPlayer scaleMode"
}
