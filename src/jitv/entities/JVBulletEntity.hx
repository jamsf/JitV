package jitv.entities;

import com.haxepunk.debug.Console;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.masks.Pixelmask;
import com.haxepunk.math.Vector;
import jitv.JVConstants;
import jitv.entities.JVEntity;

/**
 * JVPlayerShipEntity
 * Entity representing a player-controllable ship.
 * Created by Clement 12/8/13, Ported by Fletcher 12/15/13
 */
class JVBulletEntity extends JVEntity
{
	var vel:Vector;
	var movementMagnitude:Float;
	
	public function new(x:Float, y:Float, type:String, angle:Float, velocity:Float) 
	{
		super();
		
		var image:Image = new Image("gfx/entities/bullet_0_entity.png");
		image.centerOrigin();
		this.graphic = image;
		
		var mask:Pixelmask = new Pixelmask("gfx/entities/bullet_0_entity.png", Std.int(-image.width / 2), Std.int(-image.width / 2));
		this.mask = mask;
		
		this.type = type;
		this.width = image.width;
		this.height = image.height;
		this.x = x;
		this.y = y;
		vel = JVUtil.createVector(angle, velocity);
	}
	
	override public function update():Void
	{
		super.update();
		
		movementMagnitude = HXP.elapsed * JVConstants.ASSUMED_FPS_FOR_PHYSICS;
		
		this.x += vel.x * movementMagnitude;
		this.y += vel.y * movementMagnitude;
		
		if (this.x < 0 - JVConstants.BULLET_OFFSCREEN_DELETION_BUFFER ||
			this.y < 0 - JVConstants.BULLET_OFFSCREEN_DELETION_BUFFER ||
			this.x > JVConstants.PLAY_SPACE_WIDTH + JVConstants.BULLET_OFFSCREEN_DELETION_BUFFER ||
			this.y > JVConstants.PLAY_SPACE_HEIGHT + JVConstants.BULLET_OFFSCREEN_DELETION_BUFFER)
			HXP.scene.remove(this);
	}
}
