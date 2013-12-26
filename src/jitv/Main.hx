package jitv;

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
	//TODO - fcole - Figure out we're gonna handle different screen sizes
	//NOTE - Screen size is also set in application.xml
	public static inline var kScreenWidth:Int = 640;
	public static inline var kScreenHeight:Int = 380;
	public static inline var kClearColor:Int = 0xff7777;
	public static inline var kProjectName:String = "JitV";

	function new()
	{
		super(kScreenWidth, kScreenHeight, JVConstants.FPS, true);
		JVDataObject.setupFakeDB();
	}

	override public function init()
	{
		EXTConsole.initializeConsole();
		HXP.screen.color = kClearColor;
		HXP.screen.scale = 1;
		
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
