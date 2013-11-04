package jitv.ui 
{
	import flash.geom.Point;
	import net.flashpunk.FP;
	import net.extendedpunk.ui.UIView;
	import net.extendedpunk.ext.EXTUtility;
	import net.extendedpunk.ext.EXTOffsetType;
	import jitv.worlds.JVWorldManager;
	
	/**
	 * JVHudView
	 * The standard in-game HUD.
	 * Created by Fletcher 11/3/13
	 */
	public class JVHudView extends UIView 
	{
		public function JVHudView() 
		{
			super(EXTUtility.ZERO_POINT, new Point(FP.screen.width, FP.screen.height));
			
			var backButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(10, 10), "abort level", backButtonCallback);
			backButton.offsetAlignmentForSelf = EXTOffsetType.TOP_LEFT;
			backButton.offsetAlignmentInParent = EXTOffsetType.TOP_LEFT;
			this.addSubview(backButton);
		}
			
		public function backButtonCallback():void
		{
			JVWorldManager.sharedInstance.goToLevelSelectWorld();
		}
	}
}
