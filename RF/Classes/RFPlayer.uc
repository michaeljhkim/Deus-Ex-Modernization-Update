//=============================================================================
// RFPlayer
//
// Created for the Revision Framework, and may be used according to the project license.
//=============================================================================
class RFPlayer extends Human;


 // Scale:
 //	-1  : Relaxed V
 // 0   : Auto
 // +1  : Forced 1x
 // +2  : Forced 2x
 // etc.
var globalconfig int ScaleMode;

// Used because FlashFog gets reset if under a threshold.
var Vector CurrentFlashFog;

//replaced both UpdateEyeHeight events in both PlayerPawn and in DeusExPlayer
//had to do it like this because FOV changes otherwise
event UpdateEyeHeight(float DeltaTime)
{
	local float smooth, bound;

	// smooth up/down stairs
	If( (Physics==PHYS_Walking) && !bJustLanded )
	{
		smooth = FMin(1.0, 10.0 * DeltaTime/Level.TimeDilation);
		EyeHeight = (EyeHeight - Location.Z + OldLocation.Z) * (1 - smooth) + ( ShakeVert + BaseEyeHeight) * smooth;
	}
	else
	{
		smooth = FClamp(10.0 * DeltaTime/Level.TimeDilation, 0.35,1.0);
		bJustLanded = false;
		EyeHeight = EyeHeight * ( 1 - smooth) + (BaseEyeHeight + ShakeVert) * smooth;
	}

	// teleporters affect your FOV, so adjust it back down
	// Only when there is no cutscene (this is the added part)
	// THIS IS LITERALLY THE ONLY THING THAT NEEDED TO BE CHANGED
	if ( (FOVAngle != DesiredFOV) && (conPlay == None))
	{
		if ( FOVAngle > DesiredFOV )
			FOVAngle = FOVAngle - FMax(7, 0.9 * DeltaTime * (FOVAngle - DesiredFOV)); 
		else 
			FOVAngle = FOVAngle - FMin(-7, 0.9 * DeltaTime * (FOVAngle - DesiredFOV)); 
		if ( Abs(FOVAngle - DesiredFOV) <= 10 )
			FOVAngle = DesiredFOV;
	}
	//Super.UpdateEyeHeight(DeltaTime);

	// adjust FOV for weapon zooming
	if ( bZooming )
	{	
		ZoomLevel += DeltaTime * 1.0;
		if (ZoomLevel > 0.9)
			ZoomLevel = 0.9;
		DesiredFOV = FClamp(90.0 - (ZoomLevel * 88.0), 1, 170);
	} 

	//FROM DeusExPlayer
	if (JoltMagnitude != 0)
	{
		if ((Physics == PHYS_Walking) && (Bob != 0))
			EyeHeight += (JoltMagnitude * 5);
		JoltMagnitude = 0;
	}
}


// ----------------------------------------------------------------------
// ViewFlash()
// Fixed because FlashFog gets reset if under a threshold.
// ----------------------------------------------------------------------
function ViewFlash(float DeltaTime)
{
	local float Delta, Goalscale, ReductionFactor;
	local Vector GoalFog;

	ReductionFactor = 2;

	if ( FlashTimer>0 )
	{
		if ( FlashTimer<Deltatime )
		{
			FlashTimer = 0;
		}
		else
		{
			ReductionFactor = 0;
			FlashTimer -= Deltatime;
		}
	}

	if ( bNoFlash )
	{
		InstantFlash = 0;
		InstantFog = vect(0,0,0);
	}

	Delta              = FMin(0.1, DeltaTime);
	GoalScale          = 1 + DesiredFlashScale + ConstantGlowScale + HeadRegion.Zone.ViewFlash.X; 
	GoalFog            = DesiredFlashFog + ConstantGlowFog + HeadRegion.Zone.ViewFog;
	DesiredFlashScale -= DesiredFlashScale * ReductionFactor * Delta;  
	DesiredFlashFog   -= DesiredFlashFog * ReductionFactor * Delta;
	FlashScale.X      += (GoalScale - FlashScale.X + InstantFlash) * 10 * Delta;
	//FlashFog          += (GoalFog - FlashFog + InstantFog) * 10 * Delta;
	CurrentFlashFog   += (goalFog - CurrentFlashFog + InstantFog) * 10 * delta;

	InstantFlash = 0;
	InstantFog = vect(0,0,0);

	if ( FlashScale.X > 0.981 )
		FlashScale.X = 1;
	FlashScale = FlashScale.X * vect(1,1,1);

	FlashFog = CurrentFlashFog;
	if ( FlashFog.X < 0.019 )
		FlashFog.X = 0;
	if ( FlashFog.Y < 0.019 )
		FlashFog.Y = 0;
	if ( FlashFog.Z < 0.019 )
		FlashFog.Z = 0;
}

event string VersionString()
{
	//To be overridden by subclass, constructs a version string that will be printed in the log by the game engine.
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     ScaleMode=1
}
