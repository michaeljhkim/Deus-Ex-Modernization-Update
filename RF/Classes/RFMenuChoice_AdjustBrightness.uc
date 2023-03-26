//=============================================================================
// RFMenuChoice_AdjustBrightness.
// 
// Finer grained control over brightness.
//
// Created for the Revision Framework, and may be used according to the project license.
//=============================================================================
class RFMenuChoice_AdjustBrightness extends MenuUIChoiceSlider;

// ----------------------------------------------------------------------
// SaveSetting()
// ----------------------------------------------------------------------
function SaveSetting()
{
	Super.SaveSetting();
	player.ConsoleCommand("FLUSH");
}

// ----------------------------------------------------------------------
// LoadSetting()
// ----------------------------------------------------------------------
function LoadSetting()
{
	saveValue = float(player.ConsoleCommand("get" @ configSetting));

	Super.LoadSetting();
}

// ----------------------------------------------------------------------
// CancelSetting()
// ----------------------------------------------------------------------
function CancelSetting()
{
	player.ConsoleCommand("set" @ configSetting @ saveValue);
	//player.ConsoleCommand("FLUSH 0");
	player.ConsoleCommand("UPDATEGAMMA");
}

// ----------------------------------------------------------------------
// ResetToDefault()
// ----------------------------------------------------------------------
function ResetToDefault()
{
	Super.ResetToDefault();

	//player.ConsoleCommand("FLUSH 0");
	player.ConsoleCommand("UPDATEGAMMA");
}

// ----------------------------------------------------------------------
// ScalePositionChanged() : Called when an ancestor scale window's
//                          position is moved
// ----------------------------------------------------------------------
event bool ScalePositionChanged(Window scale, int newTickPosition,
                                float newValue, bool bFinal)
{
	// Don't do anything while initializing as we get several 
	// ScalePositionChanged() events before LoadSetting() is called.

	if (bInitializing)
		return False;

	player.ConsoleCommand("set" @ configSetting @ GetValue());
	//player.ConsoleCommand("FLUSH 0");
	player.ConsoleCommand("UPDATEGAMMA");

	return false;
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     numTicks=51
     endValue=1.000000
     defaultValue=0.500000
     choiceControlPosX=290
     actionText="|&Brightness"
     configSetting="ini:Engine.Engine.ViewportManager Brightness"
}
