package jitv.datamodel.persistentdata;

import jitv.datamodel.JVDataObject;
import jitv.datamodel.staticdata.JVWeaponClass;

/**
 * JVShipWeapon
 * Data for a weapon ship part
 * Created by Fletcher, 12/23/13
 */
class JVShipWeapon extends JVDataObject
{
	public var weaponClassId:Int; // Id of weapon class
	public var level:Int; // Upgrade level of this weapon
	
	public function new()
	{
	}
	
	// Helpers
	public var weaponClass(get, never):JVWeaponClass;
	
	public function get_weaponClass():JVWeaponClass
	{
		return cast JVDataObject.lookupStaticDataObject(JVWeaponClass.DATA_TYPE_NAME, this.weaponClassId);
	}
}
