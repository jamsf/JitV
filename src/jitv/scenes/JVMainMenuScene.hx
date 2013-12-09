package jitv.scenes;

import com.haxepunk.graphics.Image;
import extendedhxpunk.ext.EXTScene;
import flash.geom.Point;

/**
 * JVMainMenuScene
 * Game scene for navigation of the main menu
 * Created by Fletcher 11/3/2013, Ported by Fletcher 12/8/2013
 */
class JVMainMenuScene extends EXTScene
{
	public function new() 
	{
		super();
	}
	
	override public function begin():Void
	{
		super.begin();
		
		// Background Image
		var screenSize:Point = this.worldCamera.currentViewSize();
		var backgroundImage:Image = new Image("gfx/backgrounds/menu_background_1.png");
		backgroundImage.x = screenSize.x / 2;
		backgroundImage.y = screenSize.y / 2;
		backgroundImage.centerOrigin();
		this.addGraphic(backgroundImage);
	}
	
	public function toggleButtonCallback():Void
	{
		
	}
	
	public function playButtonCallback():Void
	{
		
	}
	
	/**
	 * Protected
	 */
}
