package editor.entities;

import com.haxepunk.Entity;
import com.haxepunk.utils.Draw;
import jitv.entities.JVEntity;

/**
 * Represents a grid space in the enemy pattern editor
 * Created by Fletcher 8/3/2014
 */
class JVEditorGridSpaceEntity extends JVEntity
{
	public function new(x:Float, y:Float, w:Int, h:Int) 
	{
		super();
		this.x = x;
		this.y = y;
		this.width = w;
		this.height = h;
		
		_leftX = cast x;
		_rightX = cast (x + w);
		_upY = cast y;
		_downY = cast (y + h);
		
		_color = 0x000000;
		_lineWidth = 4.0;
	}
	
	override public function render():Void
	{
		Draw.linePlus(_leftX, _upY, _rightX, _upY, _color, 1, _lineWidth);
		Draw.linePlus(_rightX, _upY, _rightX, _downY, _color, 1, _lineWidth);
		Draw.linePlus(_rightX, _downY, _leftX, _downY, _color, 1, _lineWidth);
		Draw.linePlus(_leftX, _downY, _leftX, _upY, _color, 1, _lineWidth);
	}
	
	/**
	 * Private
	 */
	private var _leftX:Int;
	private var _rightX:Int;
	
	private var _upY:Int;
	private var _downY:Int;
	
	private var _color:Int;
	private var _lineWidth:Float;
}
