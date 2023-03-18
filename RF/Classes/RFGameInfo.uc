//=============================================================================
// RFGameInfo.
//=============================================================================
class RFGameInfo expands DeusExGameInfo;

// ----------------------------------------------------------------------
// ApproveClass()
//
// Approve DefaultPlayerClass and Spectators.
// ----------------------------------------------------------------------
function bool ApproveClass( class<Playerpawn> SpawnClass )
{
	if (SpawnClass==DefaultPlayerClass)
		return True;

	if (ClassIsChildOf(SpawnClass, Class'Spectator'))
	{
		Log("Approved Spectator"@SpawnClass ,'DevDemo');
		return True;
	}

	return False;
}

// ----------------------------------------------------------------------
// InitGame()
//
// Initialize the game.
// warning: this is called before actors' PreBeginPlay.
// Bjorn: Fixing broken filtering that was in vanilla...
// ----------------------------------------------------------------------
event InitGame( string Options, out string Error )
{
	local string InOpt;
	local float TempDifficulty;
		
	Super.InitGame(Options, Error);
		
	//Bjorn: We need to convert the CombatDifficulty to match the Difficulty var that the engine uses for filter out stuff on difficulty.
	//Just converting the CombatDifficulty to an int WILL NOT WORK!
	InOpt = ParseOption(Options, "Difficulty");
	if(InOpt != "")
		TempDifficulty = float(InOpt);
	
	if (TempDifficulty == 1.0)
		Difficulty = 0;
	else if (TempDifficulty == 1.5)
		Difficulty = 1;
	else if (TempDifficulty == 2.0)
		Difficulty = 2;
	else if (TempDifficulty == 4.0)
		Difficulty = 3;		
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
    DefaultPlayerClass=Class'RFJCDentonMale'
}
