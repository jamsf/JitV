package jitv.entities.components.weapons;

import com.haxepunk.HXP;
import extendedhxpunk.ext.EXTColor;
import jitv.datamodel.persistentdata.JVShipWeapon;
import jitv.entities.JVEntity;
import jitv.entities.JVBulletEntity;
import jitv.local.JVLocalData;
import jitv.local.JVColorPalette;

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
		var color:EXTColor = JVLocalData.sharedInstance().currentColorPalette.colorForIndex(JVColorPalette.INDEX_PLAYER_SHIP_1);
		var bullet:JVBulletEntity = new JVBulletEntity(launcher.x, launcher.y - launcher.halfHeight, "playerbullet", -.5, 10, _damage, color);
		bullet.y -= bullet.halfHeight / 3;
		HXP.scene.add(bullet);
	}
}
