package jitv.entities.components.weapons;

import com.haxepunk.HXP;
import jitv.datamodel.persistentdata.JVShipWeapon;
import jitv.entities.JVEntity;
import jitv.entities.JVBulletEntity;

/**
 * JVSpreadWeaponHandler
 * Weapon handler for "spread" attack type
 * Created by Fletcher, 5/11/2014
 */
class JVSpreadWeaponHandler extends JVWeaponHandler
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
		var bullet:JVBulletEntity = new JVBulletEntity(launcher.x, launcher.y - launcher.halfHeight, "playerbullet", -.5, 6, 20);
		HXP.scene.add(bullet);
		bullet = new JVBulletEntity(launcher.x, launcher.y - launcher.halfHeight, "playerbullet", -.6, 6, 20);
		HXP.scene.add(bullet);
		bullet = new JVBulletEntity(launcher.x, launcher.y - launcher.halfHeight, "playerbullet", -.4, 6, 20);
		HXP.scene.add(bullet);
	}
}
