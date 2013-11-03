package jitv.worlds
{
	import flash.geom.Point;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.extendedpunk.ext.EXTOffsetType;
	import net.extendedpunk.ext.EXTUtility;
	import net.extendedpunk.ext.EXTWorld;
	import net.extendedpunk.ui.UILabel;
	import jitv.ui.*;
	import jitv.Assets;
	
	public class JVMainMenuWorld extends EXTWorld
	{
		public function JVMainMenuWorld()
		{
			super();
		}
		
		override public function begin():void
		{
			super.begin();
			
			// Background Image
			var screenSize:Point = this.worldCamera.currentViewSize();
			var backgroundImage:Image = new Image(Assets.BG_MENU_1);
			backgroundImage.x = screenSize.x / 2;
			backgroundImage.y = screenSize.y / 2;
			backgroundImage.centerOrigin();
			this.addGraphic(backgroundImage);
			
			// UI
			var titleDialog:JVExampleDialog = new JVExampleDialog(new Point(0, -80), new Point(250, 60));
			titleDialog.offsetAlignmentForSelf = EXTOffsetType.BOTTOM_CENTER;
			var titleText:Text = new Text("Journey into the Void", 0, 0, { "size" : 19 });
			var titleLabel:UILabel = new UILabel(EXTUtility.ZERO_POINT, titleText);
			titleDialog.addSubview(titleLabel);
			
			var menuDialog:JVExampleDialog = new JVExampleDialog(new Point(0, -80), new Point(200, 220));
			menuDialog.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
			
			button1 = new JVExampleMenuButton(new Point(0, 35), "toggle", buttonCallback, "button1");
			button1.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
			button1.offsetAlignmentInParent = EXTOffsetType.TOP_CENTER;
			button1.selectable = true;
			menuDialog.addSubview(button1);
			
			button2 = new JVExampleMenuButton(new Point(0, button1.position.y + button1.size.y + 15), "play", buttonCallback, "button2");
			button2.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
			button2.offsetAlignmentInParent = EXTOffsetType.TOP_CENTER;
			button2.enabled = false;
			menuDialog.addSubview(button2);
			
			this.staticUiController.rootView.addSubview(titleDialog);
			this.staticUiController.rootView.addSubview(menuDialog);
		}
		
		public function buttonCallback(buttonName:String):void
		{
			if (buttonName == "button1")
				button2.enabled = !button2.enabled;
			else if (buttonName == "button2")
				JVWorldManager.sharedInstance.goToLevelSelectWorld();
		}
		
		/**
		 * Protected
		 */
		protected var button1:JVExampleMenuButton;
		protected var button2:JVExampleMenuButton;
	}
}
