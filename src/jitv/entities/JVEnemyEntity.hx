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
		
		var image:Image = new Image("gfx/ui/enemy_0_entity.png");
		image.centerOrigin();
		this.graphic = image;
		
		var mask:Pixelmask = new Pixelmask("gfx/ui/enemy_0_entity.png", Std.int(-image.width / 2), Std.int(-image.height / 2));
		this.mask = mask;
		
		this.type = "enemy";
		this.width = image.width;
		this.height = image.height;
	}
	
	override public function update():Void
	{
		this.y += 2;
		
		// Check if offscreen
		if (this.y > HXP.screen.height + JVConstants.OFFSCREEN_DELETION_BUFFER)
			HXP.world.remove(this);
	}
}
