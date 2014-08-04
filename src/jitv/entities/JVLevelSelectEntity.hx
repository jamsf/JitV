package jitv.entities;

import com.haxepunk.Entity;
import com.haxepunk.utils.Draw;
import extendedhxpunk.ext.EXTColor;
import jitv.JVGlobals;
import jitv.local.JVLocalData;
import jitv.local.JVColorPalette;

/**
 * Represents a selectable level on the level-select map
 * Created by Fletcher 8/3/2014
 */
class JVLevelSelectEntity extends JVEntity
{
	public function new(x:Float, y:Float, width:Int, height:Int) 
	{
		super();
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		//this.centerOrigin();
		
		_centerX = cast(x * JVGlobals.TOTAL_GAME_SCALE);
		_leftX = cast((x - this.halfWidth) * JVGlobals.TOTAL_GAME_SCALE);
		_rightX = cast((x + this.halfWidth) * JVGlobals.TOTAL_GAME_SCALE);
		
		_centerY = cast(y * JVGlobals.TOTAL_GAME_SCALE);
		_upY = cast((y - this.halfHeight) * JVGlobals.TOTAL_GAME_SCALE);
		_downY = cast((y + this.halfHeight) * JVGlobals.TOTAL_GAME_SCALE);
		
		_color = JVLocalData.sharedInstance().currentColorPalette.colorForIndex(JVColorPalette.INDEX_BACKGROUND_2).webColor;
		_lineWidth = 8.0 * JVGlobals.TOTAL_GAME_SCALE;
	}
	
	override public function render():Void
	{
		Draw.linePlus(_leftX, _centerY, _centerX, _upY, _color, 1, _lineWidth);
		Draw.linePlus(_centerX, _upY, _rightX, _centerY, _color, 1, _lineWidth);
		Draw.linePlus(_rightX, _centerY, _centerX, _downY, _color, 1, _lineWidth);
		Draw.linePlus(_centerX, _downY, _leftX, _centerY, _color, 1, _lineWidth);
		
		//Draw.linePlus(_centerX, _upY, _leftX, _centerY, _color, 1, _lineWidth);
		//Draw.linePlus(_rightX, _centerY, _centerX, _upY, _color, 1, _lineWidth);
		//Draw.linePlus(_centerX, _downY, _rightX, _centerY, _color, 1, _lineWidth);
		//Draw.linePlus(_leftX, _centerY, _centerX, _downY, _color, 1, _lineWidth);
	}
	
	/**
	 * Private
	 */
	private var _centerX:Int;
	private var _leftX:Int;
	private var _rightX:Int;
	
	private var _centerY:Int;
	private var _upY:Int;
	private var _downY:Int;
	
	private var _color:Int;
	private var _lineWidth:Float;
}
