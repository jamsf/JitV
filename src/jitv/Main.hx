package jitv;

import com.haxepunk.Engine;
import com.haxepunk.HXP;

/**
 * Main class for JitV
 * @author Fletcher
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
	}

	override public function init()
	{
#if debug
	#if flash
		if (flash.system.Capabilities.isDebugger)
	#end
		{
			HXP.console.enable();
		}
#end
		HXP.screen.color = kClearColor;
		HXP.screen.scale = 1;
//		HXP.world = new YourWorld();
	}

	public static function main()
	{
		var app = new Main();
	}
}
