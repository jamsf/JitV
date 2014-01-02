package jitv.entities;

import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.masks.Pixelmask;
import jitv.JVConstants;
import jitv.entities.JVEntity;

/**
 * JVPlayerShipEntity
 * Entity representing a player-controllable ship.
 * Created by Clement 12/8/13, Ported by Fletcher 12/15/13
 */
class JVBulletEntity extends JVEntity
{
	public function new(x:Float, y:Float, type:String) 
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
	}
	
	override public function update():Void
	{
		super.update();
		
		var movementMagnitude:Float = 6.0 * HXP.elapsed * JVConstants.ASSUMED_FPS_FOR_PHYSICS;
		
		if (type == "player")
		{
			this.y -= movementMagnitude;
			
			if (this.y < 0 - JVConstants.OFFSCREEN_DELETION_BUFFER)
				HXP.scene.remove(this);
		}
		else if (type == "enemy")
		{
			this.y += movementMagnitude;
			
			if (this.y > HXP.screen.height + JVConstants.OFFSCREEN_DELETION_BUFFER)
				HXP.scene.remove(this);
		}
	}
}
