package jitv.entities;

import flash.geom.Point;
import com.haxepunk.Entity;
import extendedhxpunk.ext.EXTKey;
import extendedhxpunk.ext.EXTMath;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.masks.Hitbox;
import com.haxepunk.masks.Pixelmask;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
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
		
		this.mask = new Hitbox(12, 12, -6, -6);
		
		this.type = "player";
		this.width = 12;
		this.height = 12;
	}
	
	override public function update():Void
	{
		++_time;
		
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
			var bullet:JVBulletEntity = new JVBulletEntity(this.x, this.y, this.type);
			HXP.scene.add(bullet);
			_cooldown = true;
			_lastBulletFired = _time;
		}
		if (_cooldown == true)
		{
			if (_time - _lastBulletFired > FIRING_RATE)
				_cooldown = false;
		}
	}
	
	/**
	 * Private
	 */
	private var _lastBulletFired:Int;
	private var _cooldown:Bool;
	private var _time:Int;
	private static inline var FIRING_RATE:Int = 10;
}
