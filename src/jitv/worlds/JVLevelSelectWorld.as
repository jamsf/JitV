package jitv.worlds 
{
	import flash.geom.Point;
	import jitv.datamodel.proceduraldata.JVLevel;
	import net.extendedpunk.ext.EXTWorld;
	import net.extendedpunk.ext.EXTOffsetType;
	import net.extendedpunk.ext.EXTUtility;
	import jitv.ui.JVExampleMenuButton;
	
	/**
	 * JVLevelSelectWorld
	 * A world in which the player can create ship specs, upgrade ship parts, and visit different levels.
	 * Created by Fletcher, 11/3/13
	 */
	public class JVLevelSelectWorld extends EXTWorld 
	{
		public function JVLevelSelectWorld() 
		{
			super();
		}
		
		override public function begin():void
		{
			var startLevelButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(0, -10), "start level", buttonCallback, START_LEVEL_NAME);
			startLevelButton.offsetAlignmentForSelf = EXTOffsetType.BOTTOM_CENTER;
			var goBackButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(0, 10), "go back", buttonCallback, BACK_BUTTON_NAME);
			goBackButton.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
			
			this.staticUiController.rootView.addSubview(startLevelButton);
			this.staticUiController.rootView.addSubview(goBackButton);
		}
		
		public function buttonCallback(buttonName:String):void
		{
			if (buttonName == START_LEVEL_NAME)
				JVWorldManager.sharedInstance.goToWorldForCombatLevel(new JVLevel());
			else if (buttonName == BACK_BUTTON_NAME)
				JVWorldManager.sharedInstance.goToMainMenuWorld();
		}
		
		/**
		 * Private
		 */
		private var START_LEVEL_NAME:String = "start_level";
		private var BACK_BUTTON_NAME:String = "back_button";
	}
}
