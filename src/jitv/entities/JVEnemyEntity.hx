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
		super.update();
		
		// Follow pattern
		if (!_hasSetUpPattern)
		{
			setupPatternMovement();
			_hasSetUpPattern = true;
		}
		else if (_patternStarted)
		{
			this.x += _patternMotion.x - _previousPoint.x;
			this.y += _patternMotion.y - _previousPoint.y;
			_previousPoint = new Point(_patternMotion.x, _patternMotion.y);
		}

		// Apply speed
		var horizontalSpeed:Float = HXP.elapsed * JVConstants.ASSUMED_FPS_FOR_PHYSICS;
		var verticalSpeed:Float = horizontalSpeed;
		if (_patternComplete)
		{
			horizontalSpeed *= _enemyData.enemyClass.speedAfterPattern.x;
			verticalSpeed *= _enemyData.enemyClass.speedAfterPattern.y;
		}
		else if (_patternStarted)
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
				HXP.scene.remove(this);
		}
		
		// Check if offscreen and remove
		if (this.y > HXP.screen.height + JVConstants.OFFSCREEN_DELETION_BUFFER)
			HXP.scene.remove(this);
	}

	public function pathStageComplete(_):Void
	{
		var previousKeyFrame:Int = _patternKeyFramesCompleted;
		++_patternKeyFramesCompleted;
		var startNewMotion:Bool = false;

		if (_patternKeyFramesCompleted < _enemyData.enemyPattern.keyFrameCount)
		{
			startNewMotion = true;
		}
		else if (_patternKeyFramesCompleted > 1 && _enemyData.enemyPattern.loops)
		{
			_patternKeyFramesCompleted = _enemyData.enemyPattern.loopIndex;
			startNewMotion = true;
		}

		if (startNewMotion)
		{
			var nextKeyFramePoint:Point = _enemyData.enemyPattern.keyFramePositions[_enemyData.indexInPattern][_patternKeyFramesCompleted];
			_patternMotion.setMotion(_previousPoint.x, _previousPoint.y, nextKeyFramePoint.x * this.width, nextKeyFramePoint.y * this.height, 
									 _enemyData.enemyPattern.keyFrameTimes[previousKeyFrame]);
		}
		else
		{
			_patternComplete = true;
		}
	}
	
	public function beginPatternMovement(timer:EXTTimer):Void
	{
		_patternStarted = true;
		_patternMotion = new LinearMotion(pathStageComplete, TweenType.Persist);
		this.pathStageComplete(null);
		this.addTween(_patternMotion);
	}
	
	public function fireBullet(timer:EXTTimer):Void
	{
		var bullet:JVBulletEntity = new JVBulletEntity(this.x, this.y, this.type);
		HXP.scene.add(bullet);
	}
	
	override public function removed():Void
	{
		_cooldownTimer.invalidate();
		
		if (_patternMotion != null)
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
	private var _patternStarted:Bool;
	private var _patternComplete:Bool;

	private function setupPatternMovement():Void
	{
		_previousPoint = _enemyData.enemyPattern.keyFramePositions[_enemyData.indexInPattern][0];
		_previousPoint = new Point(_previousPoint.x * this.width, _previousPoint.y * this.height);
		this.x += _previousPoint.x;
		this.y += _previousPoint.y;
		
		// Delay the start of the pattern execution if necessary
		if (_enemyData.enemyClass.patternDelay > 0)
			EXTTimer.createTimer(_enemyData.enemyClass.patternDelay, false, beginPatternMovement);
		else
			this.beginPatternMovement(null);
	}
}
