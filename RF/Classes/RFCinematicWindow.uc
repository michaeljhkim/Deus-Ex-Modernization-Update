//=============================================================================
// CinematicWindow.
//=============================================================================
class RFCinematicWindow extends CinematicWindow;


function SetRootViewport()
{
	local RootWindow root;
	local float      cinWidth, cinHeight;
	local float      cinX,     cinY;
	local float      ratio;
	local RFPlayer 	 player;
	
	root      = GetRootWindow();
	player    = RFPlayer(GetPlayerPawn());

	
	// Changed the code to be more like the one in RFConWindowActive2.uc, therefore not causing the split second resolution change at the start of cutscenes 
	// calculate the correct 16:9 ratio
	ratio = 0.5625 * (root.width / root.height);

	// if resolution was less than 16:9, then original code occurs
	if (ratio < 1) {
		player.DesiredFOV = player.Default.DesiredFOV * (0.5625 / (root.height / root.width));
		cinHeight = root.height * ratio;
	}
	// if resolution was 16:9 or greater, cutscene fix occurs
	else {
	// value 0.21 was taken from 'normal' convo in RFConWindowActive2.uc (lowerFinalHeightPercent = 0.21)
		cinHeight = min(root.height - (root.height * 0.21), root.width * 0.5625);
	}
	cinY = int(0.5 * (root.height - cinHeight));

	// make sure we don't invert the letterbox if the screen size is strange
	if (cinY < 0)
		root.ResetRenderViewport();
	else
		root.SetRenderViewport(0, cinY, root.width, cinHeight);
}

//Not totally sure if resetting FOV here is nessecary. This is just in case
function DestroyWindow()
{
	local RFPlayer 	 player;

	player 			  = RFPlayer(GetPlayerPawn());
	player.DesiredFOV = player.Default.DesiredFOV;

	ResetRootViewport();
	Super.DestroyWindow();
}

defaultproperties
{
}
