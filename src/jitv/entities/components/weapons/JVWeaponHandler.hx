package jitv.entities.components.weapons;

import jitv.datamodel.persistentdata.JVShipWeapon;
import jitv.entities.components.weapons.JVStandardWeaponHandler;
import jitv.entities.components.weapons.JVSpreadWeaponHandler;

/**
 * ...
 * Created by Fletcher
 */
class JVWeaponHandler
{
	static var attackTypeMapping =
	[
		"standard" 	=> "JVStandardWeaponHandler",
		"spread"	=> "JVSpreadWeaponHandler"
	];
	
	/**
	 * Static factory function for generating weapon handlers from attack types
	 * @param	upgradeLevel
	 */
	public static function WeaponHandlerForShipWeapon(shipWeapon:JVShipWeapon):JVWeaponHandler
	{
		var attackType:String = shipWeapon.weaponClass.attackType;
		var attackClassName:String = "jitv.entities.components.weapons." + attackTypeMapping[attackType];
		var handlerClass:Class<Dynamic> = Type.resolveClass(attackClassName);
		return cast Type.createInstance(handlerClass, [shipWeapon]);
	}
	
	public function new(shipWeapon:JVShipWeapon) 
	{
		_shipWeapon = shipWeapon;
		_damage = shipWeapon.weaponClass.damage;
	}
	
	/**
	 * Fire an instance/volley/round of the weapon's attack
	 */
	public function fireFromLauncher(launcher:JVEntity):Void
	{
		
	}
	
	/**
	 * Private
	 */
	private var _shipWeapon:JVShipWeapon;
	private var _damage:Int;
}
