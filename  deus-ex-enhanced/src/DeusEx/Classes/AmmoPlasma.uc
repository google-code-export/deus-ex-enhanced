//=============================================================================
// AmmoPlasma.
//=============================================================================
class AmmoPlasma extends DeusExAmmo;

// DJ: Doubled icon size values

defaultproperties
{
     bShowInfo=True
     AmmoAmount=12
     MaxAmmo=84
     ItemName="Plasma Clip"
     ItemArticle="a"
     PickupViewMesh=LodMesh'DeusExItems.AmmoPlasma'
     LandSound=Sound'DeusExSounds.Generic.PlasticHit2'
     Icon=Texture'DeusExUI.Icons.BeltIconAmmoPlasma'
     largeIconWidth=44
     largeIconHeight=92
     Description="A clip of extruded, magnetically-doped plastic slugs that can be heated and delivered with devastating effect using the plasma gun."
     beltDescription="PMA CLIP"
     Mesh=LodMesh'DeusExItems.AmmoPlasma'
     CollisionRadius=4.300000
     CollisionHeight=8.440000
     bCollideActors=True
}
