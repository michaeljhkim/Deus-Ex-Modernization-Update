//=============================================================================
// ConWindowActive
//
// Used for third-person, interactive conversations with the PC involved.
//=============================================================================

/*
This is from Kentie's Launcher Code. It automatically fixes the widescreen cinematic subtitles not being shown.
The way that it worked in the original game was that the cinematic was redered in widescreen, counting on the fact that 
you had a resolution with a shorter width. 
*/

class RFConWindowActive2 extends ConWindowActive;

//OTHER PROBLEM: AFTER INTRO, IT JUST KEEPS ZOOMING IN AND IN
//MOST LIKELY, MUST RESET FOV IN CINMEATIC WINDOW!!!


function CalculateWindowSizes()
{
	local float lowerHeight;
	local float upperHeight;
	local float lowerCurrentPos;
	local float upperCurrentPos;
	local float recWidth, recHeight;
	local float cinHeight;
	local float ratio;
	local RootWindow root;
	local float minLowerHeight; //MKE

	root = GetRootWindow();

	//Kenties fix for widescreen cinematic subtitles only kicks in if screen is 16:9 or greater 
	// Determine the height of the convo windows, based on available space
	if (bForcePlay)
	{

		// calculate the correct 16:9 ratio
		ratio = 0.5625 * (root.width / root.height);
		
		//if resolution was less than 16:9
		//Adjusts fov to match 16:9 proportions as well. Must figure out how to make this optional
		if (ratio < 1) {
			player.DesiredFOV = player.Default.DesiredFOV * (0.5625 / (root.height / root.width));
			cinHeight = root.height * ratio;
		}
		//if resolution was 16:9 or greater
		//MKE
		else {
			minLowerHeight = int(height * lowerFinalHeightPercent); //Taken from 'normal' convo. lowerFinalHeightPercent=0.21
			cinHeight = min(root.height - minLowerHeight, root.width * 0.5625);
		}

		upperCurrentPos = 0;
		upperHeight     = int(0.5 * (root.height - cinHeight));
		lowerCurrentPos = upperHeight + cinHeight;
		lowerHeight     = upperHeight;

		// make sure we don't invert the letterbox if the screen size is strange
		if (upperHeight < 0)
			root.ResetRenderViewport();
		else
			root.SetRenderViewport(0, upperHeight, width, cinHeight);

	}	
	else
	{
		upperHeight = int(height * upperFinalHeightPercent);
		lowerHeight = int(height * lowerFinalHeightPercent);

		// Compute positions for the convo windows
		lowerCurrentPos = int(height - (lowerHeight*currentWindowPos));
		upperCurrentPos = int(-upperHeight * (1.0-currentWindowPos));

		// Squeeze the rendered area
		if (root != None)
			root.SetRenderViewport(0, upperCurrentPos+upperHeight,
		                       width, lowerCurrentPos-(upperCurrentPos+upperHeight));
	}

	// Configure conversation windows
	if (upperConWindow != None)
		upperConWindow.ConfigureChild(0, upperCurrentPos, width, upperHeight);
	if (lowerConWindow != None)
		lowerConWindow.ConfigureChild(0, lowerCurrentPos, width, lowerHeight);

	// Configure Received Window
	if (winReceived != None)
	{
		winReceived.QueryPreferredSize(recWidth, recHeight);
		winReceived.ConfigureChild(10, lowerCurrentPos - recHeight - 5, recWidth, recHeight);
	}

	ConfigureCameraWindow(lowerCurrentPos);
}

//This resets the FOV after cutscenes
event DestroyWindow()
{
	Super.DestroyWindow();
	player.DesiredFOV = player.Default.DesiredFOV;
}

defaultproperties
{
}
