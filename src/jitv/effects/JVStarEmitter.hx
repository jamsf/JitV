package jitv.effects;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import jitv.effects.JVStar;
import jitv.local.JVLocalData;
import jitv.local.JVColorPalette;

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
		image.scaledWidth = HXP.screen.width;
		image.scaledHeight = HXP.screen.height;
		image.color = JVLocalData.sharedInstance().currentColorPalette.colorForIndex(JVColorPalette.INDEX_BACKGROUND_1).webColor;
		
		graphic = image;
		this.layer = this.layer + 2;
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
		star.layer = star.layer + 1;
		HXP.scene.add(star);
		_starArray.push(star);
	}
	
	private var _starArray : Array<JVStar>;
	private var _starTimer : Int;
}