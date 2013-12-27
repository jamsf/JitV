package jitv.entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.masks.Pixelmask;
import extendedhxpunk.ext.EXTTimer;
import jitv.JVConstants;
import jitv.datamodel.proceduraldata.JVEnemy;
import jitv.datamodel.staticdata.JVEnemyClass;
import jitv.datamodel.staticdata.JVEnemyPattern;

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
		
		_cooldownTimer = EXTTimer.createTimer(1.167, true, fireBullet);
	}
	
	override public function update():Void
	{
		var movementMagnitude:Float = _enemyData.enemyClass.speed * HXP.elapsed * JVConstants.ASSUMED_FPS_FOR_PHYSICS;
		
		// Move down
		this.y += movementMagnitude;
		
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
	
	public function fireBullet(timer:EXTTimer):Void
	{
		var bullet:JVBulletEntity = new JVBulletEntity(this.x, this.y, this.type);
		HXP.scene.add(bullet);
	}
	
	override public function removed():Void
	{
		_cooldownTimer.invalidate();
	}
	
	/**
	 * Private
	 */
	private var _enemyData:JVEnemy;
	private var _health:Int = 100;
	private var _cooldownTimer:EXTTimer;
}
