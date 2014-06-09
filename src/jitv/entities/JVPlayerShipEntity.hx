package jitv.entities;

import com.haxepunk.utils.Joystick;
import extendedhxpunk.io.Gamepad;
import flash.geom.Point;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.masks.Hitbox;
import com.haxepunk.masks.Pixelmask;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import extendedhxpunk.ext.EXTKey;
import extendedhxpunk.ext.EXTMath;
import extendedhxpunk.ext.EXTTimer;
import jitv.entities.components.JVMovementComponent;
import jitv.entities.components.JVWeaponComponent;
import jitv.datamodel.persistentdata.JVShipWeapon;
import jitv.JVConstants;
import jitv.JVGlobals;
import jitv.entities.JVEntity;
import jitv.ui.JVHudView;
import jitv.local.JVLocalData;
import jitv.local.JVColorPalette;

/**
 * JVPlayerShipEntity
 * Entity representing a player-controllable ship.
 * Created by Fletcher 11/3/13, Ported by Fletcher 12/15/13
 */
class JVPlayerShipEntity extends JVEntity
{
	public function new(hud:JVHudView) 
	{
		super();
		
		var image:Image = new Image("gfx/entities/player_ship_entity.png");
		image.centerOrigin();
		image.color = JVLocalData.sharedInstance().currentColorPalette.colorForIndex(JVColorPalette.INDEX_PLAYER_SHIP_1).webColor;
		this.graphic = image;
		
		this.mask = new Pixelmask("gfx/masks/player_ship_mask.png", Std.int(-image.width / 2), Std.int(-image.height / 2));
		this.type = "player";
		_lifeCount = JVConstants.START_LIVES;
		_invincible = false;
		
		_hud = hud;
		
		// Hardcoded gamepad to be 0th one
		_gamepad = new Gamepad(0);
		_hud.updateLivesCount(_lifeCount);
		
		// Add component for movement
		this.components.push(new JVMovementComponent(this, _gamepad));
		
		// Temporary hardcoded weapons
		var tempPrimaryWeapon:JVShipWeapon = new JVShipWeapon();
		tempPrimaryWeapon.weaponClassId = 0;
		tempPrimaryWeapon.level = 1;
		var tempSecondaryWeapon:JVShipWeapon = new JVShipWeapon();
		tempSecondaryWeapon.weaponClassId = 1;
		tempSecondaryWeapon.level = 1;
		
		// Add components for weapons
		this.components.push(new JVWeaponComponent(this, tempPrimaryWeapon, Key.SPACE, XboxButton.A_BUTTON, _gamepad));
		this.components.push(new JVWeaponComponent(this, tempSecondaryWeapon, Key.X, XboxButton.B_BUTTON, _gamepad));
	}
	
	override public function update():Void
	{
		super.update();
		
		var playSpaceOffset:Point = JVGlobals.PLAY_SPACE_OFFSET;
		clampHorizontal(playSpaceOffset.x, playSpaceOffset.x + JVConstants.PLAY_SPACE_WIDTH);
		clampVertical(playSpaceOffset.y, playSpaceOffset.y + JVConstants.PLAY_SPACE_HEIGHT);
		
		// If powerups are within range, start to suck them up
		var inRangePowerups:Array<Entity> = new Array();
		HXP.scene.collideCircleInto("pwrup", this.x, this.y, JVConstants.POWERUP_ATTRACTION_DISTANCE, inRangePowerups);
		
		for (i in 0...inRangePowerups.length)
		{
			var collidedPwrup:JVPowerUpEntity = cast inRangePowerups[i];
			collidedPwrup.initiateConsumption(this, consumePowerup);
		}
	}
	
	/**
	 *	isHit 	- 	public mutator function; Logic that executes when ship is hit
	 *	PRECON:		this has just been hit by an opposing entity type
	 *	POSTCON:	logic that executes when ship is hit by an enemy in its current state
	 */
	public function isHit():Void
	{
		--_lifeCount;				
		_hud.updateLivesCount(_lifeCount);
	}
	
	public function activateInvincibility():Void // TODO - clem - change this to flashing white
	{
		_invincible = true;
		_invincibilityFlashTimer = EXTTimer.createTimer(0.2, true, toggleVisibility);
		_invincibilityOffTimer = EXTTimer.createTimer(2.5, false, invincibilityOff);
	}
	
	/**
	 *	getLives	- 	public accesor function; Retrieve number of player lives
	 *	PRECON:			N/A
	 *	POSTCON:		Return life count for this ship
	 */
	public function getLives():Int
	{
		return _lifeCount;
	}
	
	public function isInvincible():Bool
	{
		return _invincible;
	}
	
	public function consumePowerup(collided:JVEntity):Void
	{
		HXP.scene.remove(collided);
		
		// Call powerup logic here.
		++_lifeCount;
		_hud.updateLivesCount(_lifeCount);
	}
	
	/**
	 * Private
	 */
	private var _gamepad:Gamepad;
	private var _lifeCount:Int;
	private var _hud:JVHudView;
	private var _invincible:Bool;
	private var _invincibilityFlashTimer:EXTTimer;
	private var _invincibilityOffTimer:EXTTimer;
	
	private function toggleVisibility(timer:EXTTimer):Void
	{
		visible = !visible;
	}
	
	private function invincibilityOff(timer:EXTTimer):Void
	{
		_invincible = false;
		_invincibilityFlashTimer.invalidate();
		this.visible = true;
	}
}
