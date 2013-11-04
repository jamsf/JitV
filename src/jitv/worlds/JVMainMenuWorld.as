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
			
			// Toggle button
			toggleButton = new JVExampleMenuButton(new Point(0, 35), "toggle", toggleButtonCallback);
			toggleButton.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
			toggleButton.offsetAlignmentInParent = EXTOffsetType.TOP_CENTER;
			toggleButton.selectable = true;
			menuDialog.addSubview(toggleButton);
			
			// Play button
			playButton = new JVExampleMenuButton(new Point(0, toggleButton.position.y + toggleButton.size.y + 15), "play", playButtonCallback);
			playButton.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
			playButton.offsetAlignmentInParent = EXTOffsetType.TOP_CENTER;
			playButton.enabled = false;
			menuDialog.addSubview(playButton);
			
			this.staticUiController.rootView.addSubview(titleDialog);
			this.staticUiController.rootView.addSubview(menuDialog);
		}
		
		public function toggleButtonCallback():void
		{
			playButton.enabled = !playButton.enabled;
		}
		
		public function playButtonCallback():void
		{
			JVWorldManager.sharedInstance.goToLevelSelectWorld();
		}
		
		/**
		 * Protected
		 */
		protected var toggleButton:JVExampleMenuButton;
		protected var playButton:JVExampleMenuButton;
	}
}
