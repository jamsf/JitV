package jitv.worlds 
{
	import net.extendedpunk.ext.EXTWorld;
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
			var goBackButton:JVExampleMenuButton = new JVExampleMenuButton(EXTUtility.ZERO_POINT, "go back", buttonCallback, "go_back_button");
			this.staticUiController.rootView.addSubview(goBackButton);
		}
		
		public function buttonCallback(buttonName:String):void
		{
			if (buttonName == "go_back_button")
				JVWorldManager.sharedInstance.goToMainMenuWorld();
		}
	}
}
