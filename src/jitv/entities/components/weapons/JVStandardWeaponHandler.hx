package jitv.entities.components.weapons;

import com.haxepunk.HXP;
import jitv.datamodel.persistentdata.JVShipWeapon;
import jitv.entities.JVEntity;
import jitv.entities.JVBulletEntity;

/**
 * JVStandardWeaponHandler
 * Weapon handler for "standard" attack type
 * Created by Fletcher, 5/11/2014
 */
class JVStandardWeaponHandler extends JVWeaponHandler
{
	public function new(shipWeapon:JVShipWeapon) 
	{
		super(shipWeapon);
	}
	
	/**
	 * Fire an instance/volley/round of the weapon's attack
	 */
	override public function fireFromLauncher(launcher:JVEntity):Void
	{
		var bullet:JVBulletEntity = new JVBulletEntity(launcher.x, launcher.y - launcher.halfHeight, "playerbullet", -.5, 8, 34);
		HXP.scene.add(bullet);
	}
}
