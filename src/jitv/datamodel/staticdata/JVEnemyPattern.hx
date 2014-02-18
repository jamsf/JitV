package jitv.datamodel.staticdata;

import flash.geom.Point;
import haxe.Resource;
import extendedhxpunk.ext.EXTJsonSerialization;
import extendedhxpunk.ext.EXTOffsetType;
import jitv.datamodel.JVDataObject;
import jitv.JVJsonMappings;

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
	public var totalWidth:Int;				// Pixel width of the entire pattern
	public var totalHeight:Int;				// Pixel height of the entire pattern
	public var gridColumns:Int;				// Number of columns in the pattern grid
	public var gridRows:Int;				// Number of rows in the column grid
	public var rawSpawnAnchor:String;
	
	// Data info
	public function get_spawnAnchor():EXTOffsetType
	{
		var offset:EXTOffsetType = Type.createEnum(EXTOffsetType, rawSpawnAnchor);
		return offset;
	}
	public static inline var DATA_TYPE_NAME:String = "enemy_pattern";
	public function new() { }

	// Fake database setup
	public static function setupDB():Void
	{
		var dataDictionary:Map<Int, JVDataObject> = new Map();
		JVDataObject.DB[DATA_TYPE_NAME] = dataDictionary;
		
		var fileContent:String = Resource.getString(DATA_TYPE_NAME);
		var dataArray:Array<JVEnemyPattern> = EXTJsonSerialization.decode(fileContent, Array);
		
		for (i in 0...dataArray.length)
			dataDictionary[i] = cast dataArray[i];
		
		//var mapping = JVJsonMappings.explicitTypeMapping;
		var mapping2 = JVJsonMappings.fieldMapping;
		
		var encodablePattern = JVJsonMappings.createEncodable(dataDictionary[0]);
		var string0:String = EXTJsonSerialization.encode(encodablePattern);
		trace(string0);
		
		//var fakePoint:Point = new Point();
		//fakePoint.length = 5;
		//try
		//{
			//Reflect.setProperty(fakePoint, "length", 5);
		//}
		//catch (msg:String)
		//{
			//trace(msg);
		//}
		//var populatedDynamic
		//var string0:String = EXTJsonSerialization.encode(dataDictionary[0]);
		//trace(string0);
	}
}
