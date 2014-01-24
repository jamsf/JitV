package jitv.effects;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

import jitv.effects.JVStar;

/**
 * ...
 * @author Jams
 */
class JVStarEmitter extends Entity
{
	public static inline var STAR_LIMIT : Int = 50;
	public static inline var STAR_TIMER : Int = 10;
	public static inline var BACKGROUND_LAYER : Int = 20;
	
	public function new() 
	{
		super();
		x = 0; y = 0;
		_starArray = new Array<JVStar>();
		_starTimer = 0;
		
		// Set background image
		var image:Image = new Image("gfx/entities/particle_entity.png");
		image.scale = HXP.screen.width;
		image.color = 0x000000;
		
		graphic = image;
	}
	
	override public function update():Void 
	{
		super.update();
		
		if (_starArray.length < STAR_LIMIT)
		{
			if (_starTimer > 10)
			{
				addStar();
				_starTimer = 0;
			}
			++_starTimer;
		}
	}
	
	private function addStar()
	{
		var star : JVStar = new JVStar();
		HXP.scene.add(star);
		_starArray.push(star);
	}
	
	private var _starArray : Array<JVStar>;
	private var _starTimer : Int;
}