package jitv.ui;

import flash.geom.Point;
import extendedhxpunk.ui.UISmartStretchButton;
import com.haxepunk.graphics.Text;

/**
 * JVExampleMenuButton
 * A sample button class with all image states used
 * Created by Fletcher
 */
class JVExampleMenuButton extends UISmartStretchButton
{
	public function new(position:Point, textString:String = null, cb:Array<Dynamic>->Dynamic = null, cbArgs:Array<Dynamic> = null) 
	{
		var basicSize:Point = new Point(100, 30);
		var enabledText:Text = new Text(textString, 0, 0, { "size" : 16, "color" : 0x101010 });
		super(position, basicSize, 
			"gfx/ui/button_enabled_32x32.png",
			"gfx/ui/button_disabled_32x32.png",
			"gfx/ui/button_hover_32x32.png",
			"gfx/ui/button_pressed_32x32.png",
			"gfx/ui/button_selected_32x32.png",
			"gfx/ui/button_selected_hover_32x32.png",
			enabledText, cb, cbArgs);
		this.disabledText = new Text(textString, 0, 0, { "size" : 16, "color" : 0x777777 });
		this.selectedText = new Text(textString, 0, 0, { "size" : 16, "color" : 0x404040 });
		this.pressedText = this.selectedText;
	}
}
