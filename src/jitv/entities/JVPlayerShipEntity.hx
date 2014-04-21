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
import jitv.JVConstants;
import jitv.entities.JVEntity;
import jitv.ui.JVHudView;

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
		this.graphic = image;
		
		this.mask = new Pixelmask("gfx/masks/player_ship_mask.png", Std.int(-image.width / 2), Std.int(-image.height / 2));
		this.type = "player";
		this._lifeCount = JVConstants.START_LIVES;
		// this.width = 12;
		// this.height = 12;
		
		_hud = hud;
		
		_cooldownTimer = EXTTimer.createTimer(FIRING_RATE, true, resetBulletCooldown);
		_cooldownTimer.paused = true;
		
		// Hardcoded gamepad to be 0th one
		_gamepad = new Gamepad(0);
		_hud.updateLivesCount(_lifeCount);
	}
	
	override public function update():Void
	{
		super.update();
		
		// Movement
		var movementMagnitude:Float = JVConstants.BASE_SHIP_MOVEMENT_SPEED * HXP.elapsed * JVConstants.ASSUMED_FPS_FOR_PHYSICS;
		
		var horizontalMovement:Bool = false;
		var verticalMovement:Bool = false;
		var xMultiplier:Float = 1.0;
		var yMultiplier:Float = 1.0;
		
		// TODO - Have better checking for controller support
		if ((Math.abs(_gamepad.leftAnalogueX) > 0) || (Math.abs(_gamepad.leftAnalogueY) > 0))
		{
			if (Math.abs(_gamepad.leftAnalogueX) > 0)
			{
				horizontalMovement = true;
				xMultiplier = _gamepad.leftAnalogueX;
			}
			if (Math.abs(_gamepad.leftAnalogueY) > 0)
			{
				verticalMovement = true;
				yMultiplier = _gamepad.leftAnalogueY;
			}
		}
		else
		{
			if (Input.check(Key.RIGHT))
			{
				horizontalMovement = true;
			}
			if (Input.check(Key.LEFT))
			{
				horizontalMovement = !horizontalMovement;
				xMultiplier = -1.0;
			}
			if (Input.check(Key.DOWN))
			{
				verticalMovement = true;
			}
			if (Input.check(Key.UP))
			{
				verticalMovement = !verticalMovement;
				yMultiplier = -1.0;
			}
		}
		
		if (horizontalMovement && verticalMovement)
		{
			xMultiplier *= EXTMath.SQRT2_2;
			yMultiplier *= EXTMath.SQRT2_2;
		}
		
		if (horizontalMovement)
			this.x += xMultiplier * movementMagnitude;
		if (verticalMovement)
			this.y += yMultiplier * movementMagnitude;
		
		
		clampHorizontal(0, JVConstants.PLAY_SPACE_WIDTH);
		clampVertical(0, JVConstants.PLAY_SPACE_HEIGHT);
		
		// Primary Fire
		if ((Input.check(Key.SPACE) || (_gamepad != null && _gamepad.check(XboxButton.A_BUTTON))) && _cooldown == false)
		{
			fireBullet();
		}
		else if ((Input.check(Key.X) || (_gamepad != null && _gamepad.check(XboxButton.B_BUTTON))) && _cooldown == false)
		{
			fireBurstBullet();
		}
		
		//This is the logic that handles collision with a powerup.
		var collidedPwrup:Entity = this.collide("pwrup", this.x, this.y);
		if (collidedPwrup != null)
		{
			//Call pwrup logic here.
			++_lifeCount;
			_hud.updateLivesCount(_lifeCount);
			HXP.scene.remove(collidedPwrup);		
		}
	}
	
	public function resetBulletCooldown(timer:EXTTimer):Void
	{
		_cooldown = false;
		_cooldownTimer.paused = true;
	}
	
	override public function removed():Void
	{
		_cooldownTimer.invalidate();
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
	
	/**
	 *	getLives	- 	public accesor function; Retrieve number of player lives
	 *	PRECON:			N/A
	 *	POSTCON:		Return life count for this ship
	 */
	public function getLives():Int
	{
		return _lifeCount;
	}
	
	/**
	 * Private
	 */
	private var _cooldownTimer:EXTTimer;
	private var _cooldown:Bool;
	private var _gamepad:Gamepad;
	private var _lifeCount:Int;
	private var _hud:JVHudView;
	
	private static inline var FIRING_RATE:Float = 0.167;
	
	private function fireBullet():Void
	{
		var bullet:JVBulletEntity = new JVBulletEntity(this.x, this.y, "playerbullet", -.5, 6, 34);
		HXP.scene.add(bullet);
		_cooldown = true;
		_cooldownTimer.paused = false;
	}
	
	private function fireBurstBullet():Void
	{
		var bullet:JVBulletEntity = new JVBulletEntity(this.x, this.y, "playerbullet", -.5, 6, 20);
		HXP.scene.add(bullet);
		bullet = new JVBulletEntity(this.x, this.y, "playerbullet", -.6, 6, 20);
		HXP.scene.add(bullet);
		bullet = new JVBulletEntity(this.x, this.y, "playerbullet", -.4, 6, 20);
		HXP.scene.add(bullet);
		_cooldown = true;
		_cooldownTimer.paused = false;
	}
	
	private function updateMovement():Void
	{
		
	}
}
