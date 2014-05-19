package jitv.entities;

import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.masks.Pixelmask;
import jitv.JVConstants;
import jitv.entities.JVEntity;
import jitv.local.JVLocalData;
import jitv.local.JVColorPalette;

/**
 * JVPowerUpEntity.hx
 * Class represents power-up entities that spawn during gameplay.
 * 
 * @author Mark 
 * Created: 2013-01-19
 * Last Updated: 2013-01-23 by @author: Mark
 */
class JVPowerUpEntity extends JVEntity
{
	/**
	 * Public ctor func; default constructor
	 * @param	x		int; represents position along the x-axis
	 * @param	y		int; represents position along the y-axis
	 * @param	type	string; object type descriptor
	 */
	public function new(x:Float, y:Float, type:String) 
	{
		super();
		
		var image:Image = new Image("gfx/entities/pwrup_0_entity.png");
		image.centerOrigin();
		image.color = JVLocalData.sharedInstance().currentColorPalette.colorForIndex(JVColorPalette.INDEX_PLAYER_SHIP_1).webColor;
		this.graphic = image;
		
		var mask:Pixelmask = new Pixelmask("gfx/entities/pwrup_0_entity.png", Std.int(-image.width / 2), Std.int(-image.width / 2));
		this.mask = mask;
		
		this.type = "pwrup";
		this.width = image.width;
		this.height = image.height;
		this.x = x;
		this.y = y;
	}
	
	/**
	 * Update - Public Mutatator func; runs update loop on powerup entity
	 * PRECON:	N/A
	 * POSTCON:	Power-up Entity is updated.
	 */
	override public function update():Void
	{
		super.update();
		
		var movementMagnitude:Float = 3.0 * HXP.elapsed * JVConstants.ASSUMED_FPS_FOR_PHYSICS;
		
		this.y += movementMagnitude;
		
		if (this.x < 0 - JVConstants.BULLET_OFFSCREEN_DELETION_BUFFER ||
			this.y < 0 - JVConstants.BULLET_OFFSCREEN_DELETION_BUFFER ||
			this.x > JVConstants.PLAY_SPACE_WIDTH + JVConstants.BULLET_OFFSCREEN_DELETION_BUFFER ||
			this.y > JVConstants.PLAY_SPACE_HEIGHT + JVConstants.BULLET_OFFSCREEN_DELETION_BUFFER)
			HXP.scene.remove(this);
	}
	
}