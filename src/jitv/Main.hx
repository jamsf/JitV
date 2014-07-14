package jitv;

import flash.geom.Point;
import com.haxepunk.Engine;
import com.haxepunk.HXP;
import extendedhxpunk.ext.EXTConsole;
import jitv.scenes.JVSceneManager;
import jitv.datamodel.JVDataObject;

/**
 * Main class for JitV's HaXe project
 * Created by Fletcher 12/8/2013
 */
class Main extends Engine 
{
	public static inline var kProjectName:String = "JitV";

	function new()
	{
		super(JVConstants.PLAY_SPACE_WIDTH, JVConstants.PLAY_SPACE_HEIGHT, JVConstants.FPS, false);
		JVGlobals.TOTAL_GAME_WIDTH = JVConstants.PLAY_SPACE_WIDTH;
		JVGlobals.TOTAL_GAME_HEIGHT = JVConstants.PLAY_SPACE_HEIGHT;
		JVGlobals.TOTAL_GAME_SCALE = 1.0;
		JVGlobals.PLAY_SPACE_OFFSET = new Point(0.0, 0.0);
		HXP.defaultFont = JVConstants.STANDARD_FONT;
		
		JVDataObject.setupDB();
	}

	override public function init()
	{
		EXTConsole.initializeConsole();
		JVSceneManager.sharedInstance().goToMainMenuScene();
	}
	
	override public function update():Void
	{
		super.update();
		JVSceneManager.sharedInstance().update();
#if debug
		EXTConsole.update();
#end
	}
	
	public static function main()
	{
		var app = new Main();
	}
}
