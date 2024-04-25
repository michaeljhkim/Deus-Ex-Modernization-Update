//=============================================================================
// CinematicWindow.
//=============================================================================
class RFCinematicWindow extends CinematicWindow;

function SetRootViewport()
{
	local RootWindow root;
	local float      cinWidth, cinHeight;
	local float      cinX,     cinY;
	local float ratio;
	local RFPlayer 	 player;

	root      = GetRootWindow();

	player    = RFPlayer(GetPlayerPawn());
	// calculate the correct 16:9 ratio
	ratio = 0.5625 * (root.width / root.height);

	cinWidth  = root.width;
	cinHeight = root.height * ratio;

	// changes FOV to match aspect ratio
	if (ratio < 1) {
		cinHeight = root.height * ratio;
	}
	else {
		cinHeight = min(root.height - (root.height * 0.15), root.width * 0.5625);
	}
	cinX      = 0;
	cinY      = int(0.5 * (root.height - cinHeight));

	// make sure we don't invert the letterbox if the screen size is strange
	if (cinY < 0)
		root.ResetRenderViewport();
	else
		root.SetRenderViewport(cinX, cinY, cinWidth, cinHeight);
}

//Not totally sure if resetting FOV here is nessecary. This is just in case
function DestroyWindow()
{
	local RFPlayer player;

	player 			  = RFPlayer(GetPlayerPawn());
	player.DesiredFOV = player.Default.DesiredFOV;

	ResetRootViewport();
	Super.DestroyWindow();
}

defaultproperties
{
}
