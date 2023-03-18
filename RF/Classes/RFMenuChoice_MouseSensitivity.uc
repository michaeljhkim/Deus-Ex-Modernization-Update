//=============================================================================
// RFMenuChoice_MouseSensitivity
//
// Created for the Revision Framework, and may be used according to the project license.
//
// Revision History:
//  * Added range of 0.1-0.9 values in 0.1 steps to selection.
//=============================================================================
class RFMenuChoice_MouseSensitivity extends MenuUIChoiceSlider;

// ----------------------------------------------------------------------
// LoadSetting()
// ----------------------------------------------------------------------
function LoadSetting()
{
	local float NewValue;

	SaveValue = Player.MouseSensitivity;

	if ( Player.MouseSensitivity<1.0 )
		NewValue = Player.MouseSensitivity*10.0-1.0;
	else
		NewValue = Player.MouseSensitivity+8.0;
		
	//Log( "LoadSetting() (MouseSensitivity="$Player.MouseSensitivity$",NewValue="$NewValue$")", Class.Name );

	BtnSlider.WinSlider.SetTickPosition( NewValue );
}

// ----------------------------------------------------------------------
// CancelSetting()
// ----------------------------------------------------------------------
function CancelSetting()
{
	//Log( "CancelSetting() (SaveValue=" $ SaveValue $ ")", Class.Name );

	Player.UpdateSensitivity( SaveValue );
}

// ----------------------------------------------------------------------
// ResetToDefault()
// ----------------------------------------------------------------------
function ResetToDefault()
{
	//Log( "CancelSetting() (SaveValue=" $ DefaultValue $ ")", Class.Name );

	Player.UpdateSensitivity( DefaultValue );
	SetValue( 9 );
}

// ----------------------------------------------------------------------
// SetEnumerators()
// ----------------------------------------------------------------------
function SetEnumerators()
{
	local int i;

	// 0.1 to 0.9 in 0.1 steps.
	for ( i=0; i<9; i++ )
		SetEnumeration( i, "0."$(i+1) );

	// 1 to 10 in 1 steps.
	for ( i=9; i<19; i++ )
		SetEnumeration( i, (i-8) );
}

// ----------------------------------------------------------------------
// ScalePositionChanged() 
//
// Update the Mouse Sensitivity value.
// ----------------------------------------------------------------------
event bool ScalePositionChanged( Window Scale, int NewTickPosition, float NewValue, bool bFinal )
{
	local float Value;

	// Don't do anything while initializing as we get several 
	// ScalePositionChanged() events before LoadSetting() is called.
	if ( bInitializing )
		return False;

	if ( NewTickPosition<9 )
		Value = (float(NewTickPosition)+1.0)/10.0;
	else
		Value = float(NewTickPosition)-8.0;

	//Log( "ScalePositionChanged() (NewTickPosition="$NewTickPosition$",Value="$Value$")", Class.Name );

	Player.UpdateSensitivity( Value );
	return False;
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
    numTicks=19
    startValue=0.10
    defaultValue=1.00
    HelpText="Modifies the mouse sensitivity"
    actionText="Mouse |&Sensitivity"
}
