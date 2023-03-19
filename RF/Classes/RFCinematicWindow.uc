//=============================================================================
// CinematicWindow.
//=============================================================================
class RFCinematicWindow extends CinematicWindow;

function SetRootViewport()
{
	local RootWindow root;
	local float      cinWidth, cinHeight;
	local float      cinX,     cinY;
	local float 	 upperHeight;
	local float ratio;

	root      = GetRootWindow();

	/*MenuChoice_Resolution
	// calculate the correct 16:9 ratio
	ratio = 0.5625 * (root.width / root.height);

	cinWidth  = root.width;
	cinHeight = root.height * ratio;
	cinX      = 0;
	cinY      = int(0.5 * (root.height - cinHeight));

	// make sure we don't invert the letterbox if the screen size is strange
	if (cinY < 0)
		root.ResetRenderViewport();
	else
		root.SetRenderViewport(cinX, cinY, cinWidth, cinHeight);
	*/

//Changed the code to be more like the one in RFConWindowActive2, therefore not causing the split second change thingy
	// calculate the correct 16:9 ratio
	ratio = 0.5625 * (root.width / root.height);
	
	//if resolution was less than 16:9, then original code occurs
	if (ratio < 1) {
		cinHeight = root.height * ratio;
	}
	//if resolution was 16:9 or greater, cutscene fix occurs
	else {
		cinHeight = min(root.height - (root.height * 0.21), root.width * 0.5625);
	}
	upperHeight = int(0.5 * (root.height - cinHeight));

	// make sure we don't invert the letterbox if the screen size is strange
	if (cinY < 0)
		root.ResetRenderViewport();
	else
		root.SetRenderViewport(0, upperHeight, root.width, cinHeight);
}

defaultproperties
{
}
