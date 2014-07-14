package jitv.ui;

import flash.geom.Point;
import extendedhxpunk.ext.EXTColor;
import extendedhxpunk.ui.UISmartStretchButton;
import com.haxepunk.graphics.Text;
import jitv.JVGlobals;
import jitv.local.JVLocalData;
import jitv.local.JVColorPalette;

/**
 * JVExampleMenuButton
 * A sample button class with all image states used
 * Created by Fletcher
 */
class JVExampleMenuButton extends UISmartStretchButton
{
	public function new(position:Point, textString:String = null, cb:Array<Dynamic>->Void = null, cbArgs:Array<Dynamic> = null, colorFill:EXTColor = null) 
	{
		var basicSize:Point = new Point(130, 42);
		var pointSize:Int = cast (16 * JVGlobals.TOTAL_GAME_SCALE);
		var enabledText:Text = new Text(textString, 0, 0, { "size" : pointSize }); //, "color" : 0x101010
		super(position, basicSize, 
			"gfx/ui/button_enabled_32x32.png",
			"gfx/ui/button_disabled_32x32.png",
			"gfx/ui/button_hover_32x32.png",
			"gfx/ui/button_pressed_32x32.png",
			"gfx/ui/button_selected_32x32.png",
			"gfx/ui/button_selected_hover_32x32.png",
			enabledText, cb, cbArgs);
		this.disabledText = new Text(textString, 0, 0, { "size" : pointSize }); //, "color" : 0x777777
		this.selectedText = new Text(textString, 0, 0, { "size" : pointSize }); //, "color" : 0x404040
		this.pressedText = this.selectedText;
		this.fillColor = JVLocalData.sharedInstance().currentColorPalette.colorForIndex(JVColorPalette.INDEX_BACKGROUND_2);
	}
}
