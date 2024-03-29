//=============================================================================
// WeaponHideAGun.
//=============================================================================

//Modified -- Y|yukichigai

class WeaponHideAGun extends DeusExWeapon;

//Upped the amount of damage it does from 50 to 75
//Changed ReloadCount and PickupAmmoCount from 0
//Added in InventoryGroup=20

// DJ: Doubled icon size values

defaultproperties
{
     LowAmmoWaterMark=0
     GoverningSkill=Class'DeusEx.SkillWeaponPistol'
     NoiseLevel=0.010000
     Concealability=CONC_All
     ShotTime=0.300000
     reloadTime=0.000000
     HitDamage=75
     ProjectileDamage=75
     maxRange=24000
     AccurateRange=14400
     BaseAccuracy=0.000000
     bHasMuzzleFlash=False
     bEmitWeaponDrawn=False
     bUseAsDrawnWeapon=False
     AmmoName=Class'DeusEx.AmmoNone'
     ReloadCount=0
     FireOffset=(X=-20.000000,Y=10.000000,Z=16.000000)
     ProjectileClass=Class'DeusEx.PlasmaBolt'
     shakemag=50.000000
     FireSound=Sound'DeusExSounds.Weapons.PlasmaRifleFire'
     SelectSound=Sound'DeusExSounds.Weapons.HideAGunSelect'
     ItemName="PS20"
     PlayerViewOffset=(X=20.000000,Y=-10.000000,Z=-16.000000)
     PlayerViewMesh=LodMesh'DeusExItems.HideAGun'
     PickupViewMesh=LodMesh'DeusExItems.HideAGunPickup'
     ThirdPersonMesh=LodMesh'DeusExItems.HideAGun3rd'
     Icon=Texture'DeusExUI.Icons.BeltIconHideAGun'
     largeIcon=Texture'DeusExUI.Icons.LargeIconHideAGun'
     largeIconWidth=58
     largeIconHeight=94
     Description="The PS20 is a disposable, plasma-based weapon developed by an unknown security organization as a next generation stealth pistol.  Unfortunately, the necessity of maintaining a small physical profile restricts the weapon to a single shot.  Despite its limited functionality, the PS20 is lethal under most circumstances."
     beltDescription="PS20"
     Mesh=LodMesh'DeusExItems.HideAGunPickup'
     CollisionRadius=3.300000
     CollisionHeight=0.600000
     Mass=5.000000
     Buoyancy=2.000000
}
