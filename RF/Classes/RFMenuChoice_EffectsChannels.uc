//=============================================================================
// RFMenuChoice_EffectsChannels
//
// Created for the Revision Framework, and may be used according to the project license.
//
// Notes:
//  - Actually it's not the right spot to change title of parent window.
//=============================================================================
/** Fixes the wrong number of maximum channels for ALAudio and crappy Galaxy. Also display affected audio device in title. */
class RFMenuChoice_EffectsChannels extends MenuUIChoiceSlider;

var bool bGalaxy;

// ----------------------------------------------------------------------
// InitWindow()
// ----------------------------------------------------------------------

event InitWindow()
{
	local String LeftS, RightS;
	local MenuUIWindow MP;
	local PlayerPawn P;	

	P = GetPlayerPawn();
	if ( P==None )
		return;

	// Update Maximum EffectsChannels.
	EndValue = int(P.ConsoleCommand("MaxEffectsChannels"));
	// Assume Galaxy.
	if ( endValue<=0 )
		bGalaxy = True;
		
	Super.InitWindow();
}

// ----------------------------------------------------------------------
// SetEnumerators()
// ----------------------------------------------------------------------

function SetEnumerators()
{
	local int EnumIndex;
	local int Counter;
	local int StepSize;

	Counter = 0;
	
	if(bGalaxy)
	{
		StepSize = 1;
		EndValue = 28;
	}
	else
	{
		StepSize = (EndValue+0.5)/32.0;
		StartValue = Max(4,StepSize);
		NumTicks = 33-(StartValue/StepSize);
	}
	
	BtnSlider.SetTicks( NumTicks, StartValue, EndValue );
	for( EnumIndex=StartValue; EnumIndex<EndValue+4; EnumIndex=EnumIndex+StepSize )
		SetEnumeration( Counter++, EnumIndex );
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     numTicks=29
     startValue=3.000000
     endValue=32.000000
     defaultValue=26.000000
     HelpText="Number of sound effects channels"
     actionText="E|&ffects Channels"
     configSetting="ini:Engine.Engine.AudioDevice EffectsChannels"
}
