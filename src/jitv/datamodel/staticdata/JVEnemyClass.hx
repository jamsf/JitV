package jitv.datamodel.staticdata;

import flash.geom.Point;
import jitv.datamodel.JVDataObject;
import extendedhxpunk.ext.EXTJsonSerialization;
import extendedhxpunk.ext.EXTConsole;

/**
 * JVEnemyClass
 * A data model class containing data for a type of enemy.
 * Created by Fletcher 11/30/13, Ported by Fletcher 12/15/13
 */
class JVEnemyClass extends JVDataObject
{
	// NOTE - Enemy type should probably be its own data model, and this property should be either an id or an array of ids
	public var type:String; // Could be used to indicate strengths and weaknesses to specific weapon types.
	public var difficulty:UInt;
	public var patternId:UInt;
	public var patternDelay:Float; // Seconds to delay execution of the pattern after spawn
	public var speedDuringPattern:Point; // Constant horizontal and vertical speed of the enemy, on top of any movement specified by the pattern
	public var speedBeforePattern:Point; // Speed to use before the pattern has started (if patternDelay > 0);
	public var speedAfterPattern:Point;  // Speed to use after the pattern is complete (if it's not a looping pattern)
	public var attackType:String;
	public var imageName:String;
	public var lootDropChance:Float; // Value 0 to 1 representing likelyhood to drop loot upon death
	
	// Data info
	public static var ENEMY_CLASS_IDS:Int = 0;
	public static inline var DATA_TYPE_NAME:String = "enemy_class";
	public function new() { }
	
	// Fake database setup
	public static function setupDB():Void
	{
		ENEMY_CLASS_IDS = JVDataObject.setupDbForDataType(DATA_TYPE_NAME);
	}
}
