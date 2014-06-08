package jitv;

/**
 * JVConstants
 * Static class containing game-tuning constants
 * Created by Fletcher 11/3/2013, Ported by Fletcher 12/8/2013
 */
class JVConstants
{
#if flash
	public static inline var FPS:Int = 60;
#else
	public static inline var FPS:Int = 60;
#end
	public static inline var ASSUMED_FPS_FOR_PHYSICS:Int = 60;
	public static inline var ENEMY_OFFSCREEN_DELETION_BUFFER:Int = 128;
	public static inline var BULLET_OFFSCREEN_DELETION_BUFFER:Int = 32;
	
	public static inline var BASE_SHIP_MOVEMENT_SPEED:Float = 5.0;
	public static inline var BASE_POWERUP_SPEED:Float = 3.0f;
	public static inline var POWERUP_ATTRACTION_DISTANCE:Float = 64.0;
	
	//TODO - fcole - Figure out how we're gonna handle different screen sizes
	//NOTE - Screen size is set in application.xml
	public static inline var PLAY_SPACE_WIDTH:Int = 640;
	public static inline var PLAY_SPACE_HEIGHT:Int = 380;

	//Player Constants
	public static inline var START_LIVES:Int = 3;
}
