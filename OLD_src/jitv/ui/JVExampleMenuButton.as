package jitv.ui
{
	import flash.geom.Point;
	import net.flashpunk.graphics.Text;
	import net.extendedpunk.ui.UISmartStretchButton;
	import jitv.Assets;
	
	public class JVExampleMenuButton extends UISmartStretchButton
	{
		public function JVExampleMenuButton(position:Point, textString:String = null, callback:Function = null, callbackArgument:* = null)
		{
			var basicSize:Point = new Point(100, 30);
			var enabledText:Text = new Text(textString, 0, 0, { "size" : 16, "color" : 0x101010 });
			super(position, basicSize, 
				Assets.UI_BUTTON_ENABLED,
				Assets.UI_BUTTON_DISABLED,
				Assets.UI_BUTTON_HOVERING,
				Assets.UI_BUTTON_PRESSED,
				Assets.UI_BUTTON_SELECTED,
				Assets.UI_BUTTON_SELECTED_HOVERING,
				enabledText, callback, callbackArgument);
			this.disabledText = new Text(textString, 0, 0, { "size" : 16, "color" : 0x777777 });
			this.selectedText = new Text(textString, 0, 0, { "size" : 16, "color" : 0x404040 });
			this.pressedText = this.selectedText;
		}
	}
}
