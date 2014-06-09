package jitv.entities;

import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.masks.Pixelmask;
import com.haxepunk.math.Vector;
import jitv.entities.components.JVFollowComponent;
import jitv.JVConstants;
import jitv.JVGlobals;
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
		
		var mask:Pixelmask = new Pixelmask("gfx/masks/pwrup_0_mask.png", Std.int(-image.width / 2), Std.int(-image.height / 2));
		this.mask = mask;
		
		_following = false;
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
		
		if (_followComponent == null || !_followComponent.enabled)
		{
			if (_following)
			{
				this.type = "pwrup";
				_following = false;
				_followComponent = null;
			}
			
			var movementMagnitude:Float = JVConstants.BASE_POWERUP_SPEED * HXP.elapsed * JVConstants.ASSUMED_FPS_FOR_PHYSICS;
			
			this.y += movementMagnitude;
			
			if (this.x < JVGlobals.PLAY_SPACE_OFFSET.x - JVConstants.ENEMY_OFFSCREEN_DELETION_BUFFER ||
				this.y < JVGlobals.PLAY_SPACE_OFFSET.y - JVConstants.ENEMY_OFFSCREEN_DELETION_BUFFER ||
				this.x > JVGlobals.PLAY_SPACE_OFFSET.x + JVConstants.PLAY_SPACE_WIDTH + JVConstants.ENEMY_OFFSCREEN_DELETION_BUFFER ||
				this.y > JVGlobals.PLAY_SPACE_OFFSET.y + JVConstants.PLAY_SPACE_HEIGHT + JVConstants.ENEMY_OFFSCREEN_DELETION_BUFFER)
				HXP.scene.remove(this);
		}
		else
		{
			_followComponent.force += 0.1 * HXP.elapsed * JVConstants.ASSUMED_FPS_FOR_PHYSICS;
		}
	}
	
	public function initiateConsumption(consumer:JVEntity, completion:JVEntity->Void):Void
	{
		this.type = "pwrup_disabled";
		_following = true;
		_followComponent = new JVFollowComponent(this, consumer, completion, 3.0, new Vector(0, 1.0), 0.4, 9.0);
		this.components.push(_followComponent);
	}
	
	/**
	 * Private
	 */
	private var _followComponent:JVFollowComponent;
	private var _following:Bool;
}
