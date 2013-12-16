package jitv.entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.masks.Pixelmask;
import jitv.JVConstants;

/**
 * JVPlayerShipEntity
 * Entity representing a player-controllable ship.
 * Created by Clement 12/8/13, Ported by Fletcher 12/15/13
 */
class JVBulletEntity extends Entity
{
	public function new(x:Float, y:Float) 
	{
		super();
		
		var image:Image = new Image("gfx/ui/bullet_0_entity.png");
		image.centerOrigin();
		this.graphic = image;
		
		var mask:Pixelmask = new Pixelmask("gfx/ui/bullet_0_entity.png", -image.width / 2, -image.width / 2);
		this.mask = mask;
		
		this.type = "player";
		this.width = image.width;
		this.height = image.height;
		this.x = x;
		this.y = y;
	}
	
	override public function update():Void
	{
		var movementMagnitude:Float = 6.0 * HXP.elapsed * JVConstants.ASSUMED_FPS_FOR_PHYSICS;
		
		// only travels vertically for now
		//if (horizontalMovement)
		//	this.x += xMultiplier * movementMagnitude;
		//if (verticalMovement)
		
		this.y -= 1 * movementMagnitude;	
		
		// Check if offscreen
		if (this.y < 0 - JVConstants.OFFSCREEN_DELETION_BUFFER)
			HXP.world.remove(this);
	}
}
