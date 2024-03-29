package jitv.effects;

import com.haxepunk.graphics.Image;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import jitv.JVConstants;
import jitv.JVGlobals;
import jitv.local.JVLocalData;
import jitv.local.JVColorPalette;

/**
 * ...
 * @author Jams
 */
class JVStar extends Entity
{
	public static inline var BACKGROUND_LAYER : Int = 10;
	public static inline var VELOCITY_MULTIPLIER : Int = 3;
	public static inline var SIZE_MULTIPLIER : Int = 4;
	
	public function new() 
	{
		super();
		
		var ran : Float = Math.random();
		
		resetPos();
		layer = BACKGROUND_LAYER;
		
		var image:Image = new Image("gfx/entities/particle_entity.png");
		image.color = JVLocalData.sharedInstance().currentColorPalette.colorForIndex(JVColorPalette.INDEX_BACKGROUND_2).webColor;
		
		// Set size and velocity
		image.scale = ran * SIZE_MULTIPLIER;
		_vel = ran * VELOCITY_MULTIPLIER;
		
		image.centerOrigin();
		
		this.graphic = image;
	}
	
	public function resetPos()
	{
		x = JVGlobals.PLAY_SPACE_OFFSET.x + (Math.random() * JVConstants.PLAY_SPACE_WIDTH);
		y = -6;
	}
	
	override public function update():Void 
	{
		super.update();
		
		y += _vel;
		if (y > HXP.screen.height)
			resetPos();
	}
	
	private var _vel : Float;
}