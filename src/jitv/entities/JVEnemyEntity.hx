package jitv.entities;

import flash.geom.Point;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.masks.Pixelmask;
import com.haxepunk.Tween;
import com.haxepunk.tweens.motion.*;
import extendedhxpunk.ext.EXTTimer;
import jitv.JVConstants;
import jitv.entities.JVEntity;
import jitv.datamodel.proceduraldata.JVEnemy;
import jitv.datamodel.staticdata.JVEnemyClass;
import jitv.datamodel.staticdata.JVEnemyPattern;
import jitv.entities.components.JVPatternComponent;

/**
 * JVEnemyEntity
 * Game entity representing an enemy in the scene.
 * Created by Fletcher
 */
class JVEnemyEntity extends JVEntity
{
	public function new(enemyData:JVEnemy) 
	{
		super();
		
		_enemyData = enemyData;

		var imagePath:String = "gfx/entities/" + _enemyData.enemyClass.imageName + ".png";
		var image:Image = new Image(imagePath);
		image.centerOrigin();
		this.graphic = image;
		
		var mask:Pixelmask = new Pixelmask(imagePath, Std.int(-image.width / 2), Std.int(-image.height / 2));
		this.mask = mask;
		
		this.type = "enemy";
		this.width = image.width;
		this.height = image.height;
		_patternComponent = new JVPatternComponent(this, enemyData.enemyPattern, enemyData.indexInPattern, enemyData.enemyClass.patternDelay);
		this.components.push(_patternComponent);
		
		_cooldownTimer = EXTTimer.createTimer(1.167, true, fireBullet); //TODO - fcole - Fire speed from data
	}
	
	override public function update():Void
	{
		super.update();

		// Apply speed
		var horizontalSpeed:Float = HXP.elapsed * JVConstants.ASSUMED_FPS_FOR_PHYSICS;
		var verticalSpeed:Float = horizontalSpeed;
		if (_patternComponent.complete)
		{
			horizontalSpeed *= _enemyData.enemyClass.speedAfterPattern.x;
			verticalSpeed *= _enemyData.enemyClass.speedAfterPattern.y;
		}
		else if (_patternComponent.started)
		{
			horizontalSpeed *= _enemyData.enemyClass.speedDuringPattern.x;
			verticalSpeed *= _enemyData.enemyClass.speedDuringPattern.y;
		}
		else
		{
			horizontalSpeed *= _enemyData.enemyClass.speedBeforePattern.x;
			verticalSpeed *= _enemyData.enemyClass.speedBeforePattern.y;
		}
		this.moveBy(horizontalSpeed, verticalSpeed, null, true);
		
		// Check for collisions
		var collidedEntity:Entity = this.collide("player", this.x, this.y);
		if (collidedEntity != null)
		{
			_health -= 34;
			HXP.scene.remove(collidedEntity);
			
			if (_health <= 0)
			{
				killed();
				HXP.scene.remove(this);
			}
		}
		
		// Check if offscreen and remove
		if (this.x < 0 - JVConstants.ENEMY_OFFSCREEN_DELETION_BUFFER ||
			this.y < 0 - JVConstants.ENEMY_OFFSCREEN_DELETION_BUFFER ||
			this.x > JVConstants.PLAY_SPACE_WIDTH + JVConstants.ENEMY_OFFSCREEN_DELETION_BUFFER ||
			this.y > JVConstants.PLAY_SPACE_HEIGHT + JVConstants.ENEMY_OFFSCREEN_DELETION_BUFFER)
			HXP.scene.remove(this); //TODO: Account for things that might be going on with the ship if it hits this point.
	}

	public function fireBullet(timer:EXTTimer):Void
	{
		var bullet:JVBulletEntity = new JVBulletEntity(this.x, this.y, this.type);
		HXP.scene.add(bullet);
	}
	
	/**
	 * 	killed - public; Function that handles enemy ships dying.
	 *	PRECON:		this has fallen at or below 0 health
	 * 	POSTCON:	Enemy is no longer colidable, potentially a powerup has spawned, and eventually a death animation should play	
	 */
	public function killed():Void 
	{
		var pwrup:JVPowerUpEntity = new JVPowerUpEntity(this.x, this.y, this.type);
		if (true)
			HXP.scene.add(pwrup);
		//this.type = "dying_enemy"; //TODO: Implement death animations
	}
	
	override public function removed():Void
	{
		super.removed();
		_cooldownTimer.invalidate();
	}
	
	/**
	 * Private
	 */
	private var _enemyData:JVEnemy;
	private var _health:Int = 100;
	private var _cooldownTimer:EXTTimer;
	private var _patternComponent:JVPatternComponent;
}
