package jitv.datamodel.staticdata;

import flash.geom.Point;
import jitv.datamodel.JVDataObject;
import extendedhxpunk.ext.EXTJsonSerialization;
import extendedhxpunk.ext.EXTConsole;

/**
 * JVWeaponClass
 * Static data class representing a type of weapon
 * Created by Fletcher, 5/11/2014
 */
class JVWeaponClass extends JVDataObject
{
	public var imageName:String; // Name of the image to use for this part
	public var damage:Int; // The damage this weapon deals to enemies
	public var fireRate:Float; // Fire rate of the weapon
	public var ammoCost:Int; // Ammo cost for using this weapon
	public var attackType:String; // String indicating the attack type of this weapon, eg "spread" or "laser"
	public var projectileImageNames:Array<String>; // Array of image names for the attack components necessary for the given attack type
	
	// Data info
	public static var WEAPON_CLASS_IDS:Int = 0;
	public static inline var DATA_TYPE_NAME:String = "weapon_class";
	public function new() { }
	
	// Fake database setup
	public static function setupDB():Void
	{
		WEAPON_CLASS_IDS = JVDataObject.setupDbForDataType(DATA_TYPE_NAME);
	}
}
