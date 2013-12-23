package jitv.datamodel.proceduraldata;

import jitv.datamodel.JVDataObject;

/**
 * JVShipWeapon
 * Data for a weapon ship part
 * Created by Fletcher, 12/23/13
 */
class JVShipWeapon extends JVDataObject
{
	public var imageName:String; // Name of the image to use for this part
	public var damage:Int; // The damage this weapon deals to enemies
	public var fireRate:Int; // Fire rate of the weapon
	public var ammoCost:Int; // Ammo cost for using this weapon
	public var attackType:String; // String indicating the attack type of this weapon, eg "spread" or "laser"
	public var projectileImageNames:Array<String>; // Array of image names for the attack components necessary for the given attack type
}
