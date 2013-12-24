package jitv.entities;

import flash.geom.Point;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.masks.Hitbox;
import com.haxepunk.masks.Pixelmask;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import extendedhxpunk.ext.EXTKey;
import extendedhxpunk.ext.EXTMath;
import extendedhxpunk.ext.EXTTimer;
import jitv.JVConstants;

/**
 * JVPlayerShipEntity
 * Entity representing a player-controllable ship.
 * Created by Fletcher 11/3/13, Ported by Fletcher 12/15/13
 */
class JVPlayerShipEntity extends Entity
{
	public function new() 
	{
		super();
		
		var image:Image = new Image("gfx/entities/player_ship_entity.png");
		image.centerOrigin();
		this.graphic = image;
		
		this.mask = new Pixelmask("gfx/masks/player_ship_mask.png", Std.int(-image.width / 2), Std.int(-image.height / 2));
		this.type = "player";
		// this.width = 12;
		// this.height = 12;
		
		_cooldownTimer = EXTTimer.createTimer(FIRING_RATE, true, resetBulletCooldown);
		_cooldownTimer.paused = true;
	}
	
	override public function update():Void
	{
		// Movement
		var movementMagnitude:Float = JVConstants.BASE_SHIP_MOVEMENT_SPEED * HXP.elapsed * JVConstants.ASSUMED_FPS_FOR_PHYSICS;
		
		var horizontalMovement:Bool = false;
		var verticalMovement:Bool = false;
		var xMultiplier:Float = 1.0;
		var yMultiplier:Float = 1.0;
		
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
		
		if (horizontalMovement && verticalMovement)
		{
			xMultiplier *= EXTMath.SQRT2_2;
			yMultiplier *= EXTMath.SQRT2_2;
		}
		
		if (horizontalMovement)
			this.x += xMultiplier * movementMagnitude;
		if (verticalMovement)
			this.y += yMultiplier * movementMagnitude;
			
		// Primary Fire
		if (Input.check(Key.SPACE) && _cooldown == false)
		{
			fireBullet();
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
	 * Private
	 */
	private var _cooldownTimer:EXTTimer;
	private var _cooldown:Bool;
	private static inline var FIRING_RATE:Float = 0.167;
	
	private function fireBullet():Void
	{
		var bullet:JVBulletEntity = new JVBulletEntity(this.x, this.y, this.type);
		HXP.scene.add(bullet);
		_cooldown = true;
		_cooldownTimer.paused = false;
	}
}
