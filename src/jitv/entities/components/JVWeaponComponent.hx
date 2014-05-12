package jitv.entities.components;

import com.haxepunk.utils.Key;
import com.haxepunk.utils.Input;
import extendedhxpunk.ext.EXTTimer;
import extendedhxpunk.io.Gamepad;
import jitv.entities.JVEntity;
import jitv.entities.components.weapons.JVWeaponHandler;
import jitv.datamodel.persistentdata.JVShipWeapon;

/**
 * JVWeaponComponent
 * An entity component which controls weapon cooldown and launching the appropriate attack type
 * Created by Fletcher, 5/11/2014
 */
class JVWeaponComponent implements JVEntityComponent
{
	public function new(parent:JVEntity, 
					shipWeapon:JVShipWeapon, 
					keyTrigger:UInt, 
				gamepadTrigger:XboxButton, 
					   gamepad:Gamepad) 
	{
		_parent = parent;
		_shipWeapon = shipWeapon;
		_keyTrigger = keyTrigger;
		_gamepadTrigger = gamepadTrigger;
		_gamepad = gamepad;
		
		_weaponHandler = JVWeaponHandler.WeaponHandlerForShipWeapon(shipWeapon);
		this.prepare();
	}
	
	public function update():Void 
	{
		if ((Input.check(_keyTrigger) || (_gamepad != null && _gamepad.check(_gamepadTrigger))) && _cooldown == false)
		{
			_weaponHandler.fireFromLauncher(_parent);
			_cooldown = true;
			_cooldownTimer.paused = false;
		}
	}
	
	public function render():Void 
	{
		
	}
	
	public function prepare():Void
	{
		if (_cooldownTimer == null)
			_cooldownTimer = EXTTimer.createTimer(_shipWeapon.weaponClass.fireRate, true, resetBulletCooldown);
		_cooldown = false;
		_cooldownTimer.paused = true;
	}
	
	public function cleanup():Void 
	{
		_cooldownTimer.invalidate();
		_cooldownTimer = null;
	}
	
	/**
	 * Private
	 */
	private var _shipWeapon:JVShipWeapon;
	private var _parent:JVEntity;
	private var _keyTrigger:UInt;
	private var _gamepadTrigger:XboxButton;
	private var _gamepad:Gamepad;
	private var _weaponHandler:JVWeaponHandler;
	private var _cooldownTimer:EXTTimer;
	private var _cooldown:Bool;
	
	private function resetBulletCooldown(timer:EXTTimer):Void
	{
		_cooldown = false;
		_cooldownTimer.paused = true;
	}
}
