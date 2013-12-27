package jitv.entities;

import flash.geom.Point;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.masks.Pixelmask;
import com.haxepunk.Tween;
import com.haxepunk.tweens.motion.*;
import extendedhxpunk.ext.EXTTimer;
import jitv.JVConstants;
import jitv.datamodel.proceduraldata.JVEnemy;
import jitv.datamodel.staticdata.JVEnemyClass;
import jitv.datamodel.staticdata.JVEnemyPattern;

import extendedhxpunk.ext.EXTConsole;

/**
 * JVEnemyEntity
 * Game entity representing an enemy in the scene.
 * Created by Fletcher
 */
class JVEnemyEntity extends Entity
{
	public function new(enemyData:JVEnemy) 
	{
		super();
		
		_enemyData = enemyData;

		var image:Image = new Image("gfx/entities/enemy_0_entity.png");
		image.centerOrigin();
		this.graphic = image;
		
		var mask:Pixelmask = new Pixelmask("gfx/entities/enemy_0_entity.png", Std.int(-image.width / 2), Std.int(-image.height / 2));
		this.mask = mask;
		
		this.type = "enemy";
		this.width = image.width;
		this.height = image.height;
		
		_cooldownTimer = EXTTimer.createTimer(1.167, true, fireBullet); //TODO - fcole - Fire speed from data
	}
	
	override public function update():Void
	{
		// Follow pattern
		if (!_hasSetUpPattern)
		{
			setupPatternMovement();
			_hasSetUpPattern = true;
		}
		else
		{
			this.x += _patternMotion.x - _previousPoint.x;
			this.y += _patternMotion.y - _previousPoint.y;
			_previousPoint = new Point(_patternMotion.x, _patternMotion.y);
		}

		// Move down
		var movementMagnitude:Float = _enemyData.enemyClass.speed * HXP.elapsed * JVConstants.ASSUMED_FPS_FOR_PHYSICS;
		this.moveBy(0, movementMagnitude, null, true);
		
		// Check for collisions
		var collidedEntity:Entity = this.collide("player", this.x, this.y);
		if (collidedEntity != null)
		{
			_health -= 25;
			HXP.scene.remove(collidedEntity);
			
			if (_health <= 0)
				HXP.scene.remove(this);
		}
		
		// Check if offscreen and remove
		if (this.y > HXP.screen.height + JVConstants.OFFSCREEN_DELETION_BUFFER)
			HXP.scene.remove(this);
	}

	public function pathStageComplete(_):Void
	{
		++_patternKeyFramesCompleted;
		if (_patternKeyFramesCompleted < _enemyData.enemyPattern.keyFrameCount)
		{
			var nextKeyFramePoint:Point = _enemyData.enemyPattern.keyFramePositions[_enemyData.indexInPattern][_patternKeyFramesCompleted];
			_patternMotion.setMotion(_previousPoint.x, _previousPoint.y, nextKeyFramePoint.x * this.width, nextKeyFramePoint.y * this.height, 
									 _enemyData.enemyPattern.keyFrameTimes[_patternKeyFramesCompleted - 1]);
		}
	}
	
	public function fireBullet(timer:EXTTimer):Void
	{
		var bullet:JVBulletEntity = new JVBulletEntity(this.x, this.y, this.type);
		HXP.scene.add(bullet);
	}
	
	override public function removed():Void
	{
		_cooldownTimer.invalidate();
		this.removeTween(_patternMotion);
	}
	
	/**
	 * Private
	 */
	private var _enemyData:JVEnemy;
	private var _health:Int = 100;
	private var _hasSetUpPattern:Bool = false;
	private var _cooldownTimer:EXTTimer;

	private var _patternKeyFramesCompleted:Int = 0;
	private var _patternMotion:LinearMotion;
	private var _previousPoint:Point;

	private function setupPatternMovement():Void
	{
		_previousPoint = _enemyData.enemyPattern.keyFramePositions[_enemyData.indexInPattern][0];
		_previousPoint = new Point(_previousPoint.x * this.width, _previousPoint.y * this.height);
		this.x += _previousPoint.x;
		this.y += _previousPoint.y;

		_patternMotion = new LinearMotion(pathStageComplete, TweenType.Persist);
		this.pathStageComplete(null);
		this.addTween(_patternMotion);
	}
}
