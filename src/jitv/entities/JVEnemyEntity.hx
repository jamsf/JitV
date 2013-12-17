package jitv.entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.masks.Pixelmask;
import jitv.JVConstants;

/**
 * JVEnemyEntity
 * Game entity representing an enemy in the scene.
 * Created by Fletcher
 */
class JVEnemyEntity extends Entity
{
	public function new() 
	{
		super();
		
		var image:Image = new Image("gfx/entities/enemy_0_entity.png");
		image.centerOrigin();
		this.graphic = image;
		
		var mask:Pixelmask = new Pixelmask("gfx/entities/enemy_0_entity.png", Std.int(-image.width / 2), Std.int(-image.height / 2));
		this.mask = mask;
		
		this.type = "enemy";
		this.width = image.width;
		this.height = image.height;
	}
	
	override public function update():Void
	{
		++_time;
		
		// Move down
		this.y += 2;
		
		// Fire a bullet
		if (_time % 70 == 0)
		{
			var bullet:JVBulletEntity = new JVBulletEntity(this.x, this.y, this.type);
			HXP.scene.add(bullet);
		}
		
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
	
	/**
	 * Private
	 */
	private var _health:Int = 100;
	private var _time:Int;
}
