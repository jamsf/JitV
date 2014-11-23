package jitv.datamodel.staticdata;

import flash.geom.Point;
import extendedhxpunk.ext.EXTJsonSerialization;
import extendedhxpunk.ext.EXTOffsetType;
import jitv.datamodel.JVDataObject;
import jitv.JVJsonMappings;
import jitv.JVConstants;

/**
 * JVEnemyPattern
 * A data model class specifying an attack pattern type for enemies.
 * Created by Fletcher, 11/30/13
 */
class JVEnemyPattern extends JVDataObject
{
	public var shipCount:Int; 		// Number of ships in this pattern
	public var keyFrameCount:Int; 	// Number of keyframes in the pattern data
	public var keyFramePositions:Array<Array<Point>>; // Each element is an array of keyframes of positions for the ship at that index
	public var keyFrameTimes:Array<Float>; 	// Each element is the time between the keyframe for that index, and the next one
	public var loops:Bool; 					// Whether this pattern loops, or if enemies just maintain their final position until they exit the screen
	public var loopIndex:Int; 				// Which keyframe to loop back to if this pattern loops
	public var spawnAnchor(get, never):EXTOffsetType; 	// How to anchor this pattern in the screen
	public var initialPositionOffset:Point; // Position offset from the anchor
	public var totalWidth:Int;	// Pixel width of the entire pattern
	public var totalHeight:Int;	// Pixel height of the entire pattern
	public var gridColumns:Int;				// Number of columns in the pattern grid
	public var gridRows:Int;				// Number of rows in the column grid
	public var rawSpawnAnchor:String;
	
	// Data info
	public function get_spawnAnchor():EXTOffsetType
	{
		var offset:EXTOffsetType = Type.createEnum(EXTOffsetType, rawSpawnAnchor);
		return offset;
	}
	
	//public function set_totalWidth(w:Int):Int
	//{
		//return totalWidth = w < 0 ? JVConstants.PLAY_SPACE_WIDTH : w;
	//}
	//
	//public function set_totalHeight(h:Int):Int
	//{
		//return totalHeight = h < 0 ? JVConstants.PLAY_SPACE_HEIGHT : h;
	//}
	
	public static inline var DATA_TYPE_NAME:String = "enemy_pattern";
	public function new() { }

	// Fake database setup
	public static function setupDB():Void
	{
		JVDataObject.setupDbForDataType(DATA_TYPE_NAME);
	}
}
