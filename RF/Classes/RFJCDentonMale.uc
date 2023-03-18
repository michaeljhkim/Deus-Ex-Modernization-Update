//=============================================================================
// RFJCDentonMale.
//
// Replacement player for vanilla/mods that use the default player class.
//=============================================================================
class RFJCDentonMale extends RFPlayer;

// ----------------------------------------------------------------------
// TravelPostAccept()
// ----------------------------------------------------------------------
event TravelPostAccept()
{
	Super.TravelPostAccept();

	switch(PlayerSkin)
	{
		case 0:	MultiSkins[0] = Texture'JCDentonTex0'; break;
		case 1:	MultiSkins[0] = Texture'JCDentonTex4'; break;
		case 2:	MultiSkins[0] = Texture'JCDentonTex5'; break;
		case 3:	MultiSkins[0] = Texture'JCDentonTex6'; break;
		case 4:	MultiSkins[0] = Texture'JCDentonTex7'; break;
	}
}

// ----------------------------------------------------------------------
// UpdateTranslucency()
// DEUS_EX AMSD Try to make the player harder to see if he is in darkness.
//
// Overridden to check for our player class.
// ----------------------------------------------------------------------
function UpdateTranslucency(float DeltaTime)
{
	local float DarkVis;
	local float CamoVis;
	local AdaptiveArmor armor;
	local bool bMakeTranslucent;
	local DeusExMPGame Game;

	// Don't do it in singleplayer.
	if (Level.NetMode == NM_Standalone)
		return;

	Game = DeusExMPGame(Level.Game);
	if (Game == None)
		return;

	bMakeTranslucent = false;

	//DarkVis = AIVisibility(TRUE);
	DarkVis = 1.0;

	CamoVis = 1.0;

	//Check cloaking.
	if (AugmentationSystem.GetAugLevelValue(class'AugCloak') != -1.0)
	{
		bMakeTranslucent = TRUE;
		CamoVis = Game.CloakEffect;
	}

	// If you have a weapon out, scale up the camo and turn off the cloak.
	// Adaptive armor leaves you completely invisible, but drains quickly.
	if (inHand != None && inHand.IsA('DeusExWeapon') && CamoVis < 1.0)
	{
		CamoVis = 1.0;
		bMakeTranslucent=FALSE;
		ClientMessage(WeaponUnCloak);
		AugmentationSystem.FindAugmentation(class'AugCloak').Deactivate();
	}

	// go through the actor list looking for owned AdaptiveArmor
	// since they aren't in the inventory anymore after they are used
	if (UsingChargedPickup(class'AdaptiveArmor'))
	{
		CamoVis = CamoVis * Game.CloakEffect;
		bMakeTranslucent = TRUE;
	}

	ScaleGlow = Default.ScaleGlow * CamoVis * DarkVis;

	//Translucent is < 0.1, untranslucent if > 0.2, not same edge to prevent sharp breaks.
	if (bMakeTranslucent)
	{
		Style = STY_Translucent;
		MultiSkins[6] = Texture'BlackMaskTex';
		MultiSkins[7] = Texture'BlackMaskTex';
	}
	else if (Game.bDarkHiding)
	{
		if (CamoVis * DarkVis < Game.StartHiding)
			Style = STY_Translucent;
		if (CamoVis * DarkVis > Game.EndHiding)
			Style = Default.Style;
	}
	else if (!bMakeTranslucent)
	{
		MultiSkins[6] = Default.MultiSkins[6];
		MultiSkins[7] = Default.MultiSkins[7];
		Style = Default.Style;
	}
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
    CarcassType=Class'DeusEx.JCDentonMaleCarcass'
    JumpSound=Sound'DeusExSounds.Player.MaleJump'
    HitSound1=Sound'DeusExSounds.Player.MalePainSmall'
    HitSound2=Sound'DeusExSounds.Player.MalePainMedium'
    Land=Sound'DeusExSounds.Player.MaleLand'
    Die=Sound'DeusExSounds.Player.MaleDeath'
    Mesh=LodMesh'DeusExCharacters.GM_Trench'
    MultiSkins(0)=Texture'DeusExCharacters.Skins.JCDentonTex0'
    MultiSkins(1)=Texture'DeusExCharacters.Skins.JCDentonTex2'
    MultiSkins(2)=Texture'DeusExCharacters.Skins.JCDentonTex3'
    MultiSkins(3)=Texture'DeusExCharacters.Skins.JCDentonTex0'
    MultiSkins(4)=Texture'DeusExCharacters.Skins.JCDentonTex1'
    MultiSkins(5)=Texture'DeusExCharacters.Skins.JCDentonTex2'
    MultiSkins(6)=Texture'DeusExCharacters.Skins.FramesTex4'
    MultiSkins(7)=Texture'DeusExCharacters.Skins.LensesTex5'
}
