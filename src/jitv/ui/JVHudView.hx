package jitv.ui;

import flash.geom.Point;
import com.haxepunk.HXP;
import extendedhxpunk.ui.UIView;
import extendedhxpunk.ext.EXTUtility;
import extendedhxpunk.ext.EXTOffsetType;
import jitv.scenes.JVSceneManager;

/**
 * JVHudView
 * The standard in-game HUD.
 * Created by Fletcher 11/3/13
 */
class JVHudView extends UIView
{
	public function new() 
	{
		super(EXTUtility.ZERO_POINT, new Point(HXP.screen.width, HXP.screen.height));
		
		var backButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(10, 10), "abort level", backButtonCallback);
		backButton.offsetAlignmentForSelf = EXTOffsetType.TOP_LEFT;
		backButton.offsetAlignmentInParent = EXTOffsetType.TOP_LEFT;
		this.addSubview(backButton);
	}
	
	public function backButtonCallback(args:Array<Dynamic>):Void
	{
		JVSceneManager.sharedInstance().goToLevelSelectScene();
	}
}
