package jitv.datamodel.staticdata;

import flash.geom.Point;
import extendedhxpunk.ext.EXTOffsetType;
import jitv.datamodel.JVDataObject;
import jitv.JVConstants;

/**
 * JVEnemyPattern
 * A data model class specifying an attack pattern type for enemies.
 * Created by Fletcher, 11/30/13
 */
class JVEnemyPattern extends JVDataObject
{
	public var shipCount:Int; // Number of ships in this pattern
	public var keyFrameCount:Int; // Number of keyframes in the pattern data
	public var keyFramePositions:Array<Array<Point>>; // Each element is an array of keyframes of positions for the ship at that index
	public var keyFrameTimes:Array<Float>; // Each element is the time between the keyframe for that index, and the next one
	public var loops:Bool; // Whether this pattern loops, or if enemies just maintain their final position until they exit the screen
	public var loopIndex:Int; // Which keyframe to loop back to if this pattern loops
	public var spawnAnchor:EXTOffsetType;
	public var totalWidth:Int;
	public var totalHeight:Int;
	public var gridColumns:Int;
	public var gridRows:Int;
	
	// Data info
	public static inline var DATA_TYPE_NAME:String = "enemy_pattern";
	public function new() { }

	// Fake database setup
	public static function setupFakeDB():Void
	{
		var dataDictionary:Map<Int, JVDataObject> = new Map();
		JVDataObject.fakeDB[DATA_TYPE_NAME] = dataDictionary;

		// ID 0
		dataDictionary[0] = cast JVEnemyPattern.enemyPatternFromString(
			4,
			8,
			[
				("0___1___2___3" +
				 "_____________" +
				 "_____________" +
				 "_____________" +
				 "_____________"),

				("_____________" +
				 "_0__1___2__3_" +
				 "_____________" +
				 "_____________" +
				 "_____________"),

				("_____________" +
				 "_____________" +
				 "__0_1___2_3__" +
				 "_____________" +
				 "_____________"),

				("_____________" +
				 "_____________" +
				 "_____________" +
				 "___01___23___" +
				 "_____________"),

				("_____________" +
				 "_____________" +
				 "___10___32___" +
				 "_____________" +
				 "_____________"),

				("_____________" +
				 "_____________" +
				 "__1__0_3__2__" +
				 "_____________" +
				 "_____________"),

				("_____________" +
				 "_____________" +
				 "_____________" +
				 "_1___3_0___2_" +
				 "_____________"),

				("_____________" + 
				 "_____________" +
				 "_____________" +
				 "_____________" +
				 "__1_3___0_2__")
			],
			[
				0.5,
				0.5,
				0.5,
				0.5,
				0.5,
				0.5,
				0.5,
				0.5
			],
			false,
			-1,
			JVConstants.PLAY_SPACE_WIDTH,
			JVConstants.PLAY_SPACE_HEIGHT,
			13,
			5,
			EXTOffsetType.TOP_CENTER
			);

		// ID 1
		dataDictionary[1] = cast JVEnemyPattern.enemyPatternFromString(
			5,
			8,
			[
				("_____________" +
				 "____01234____" +
				 "_____________" +
				 "_____________" +
				 "_____________"),

				("_____________" +
				 "_____________" +
				 "_____________" +
				 "____01234____" +
				 "_____________"),

				("_____________" +
				 "_____________" +
				 "_____________" +
				 "_____________" +
				 "____01234____"),

				("_____________" +
				 "_____________" +
				 "_____________" +
				 "_____________" +
				 "____01234____"),

				("_____________" +
				 "______2______" +
				 "__0_1___3_4__" +
				 "_____________" +
				 "_____________"),

				("0_1___2___3_4" +
				 "_____________" +
				 "_____________" +
				 "_____________" +
				 "_____________"),

				("_____________" +
				 "_____________" +
				 "_____________" +
				 "_____________" +
				 "____41230____"),

				("_____________" + 
				 "_____________" +
				 "_____________" +
				 "_____________" +
				 "____41230____")
			],
			[
				0.5,
				0.5,
				0.5,
				0.5,
				0.5,
				0.5,
				0.5,
				0.5
			],
			false,
			-1,
			JVConstants.PLAY_SPACE_WIDTH,
			JVConstants.PLAY_SPACE_HEIGHT,
			13,
			5,
			EXTOffsetType.TOP_CENTER
			);

		// ID 2
		dataDictionary[2] = cast JVEnemyPattern.enemyPatternFromString(
			5,
			2,
			[
				("____________0" +
				 "____________1" +
				 "____________2" +
				 "____________3" +
				 "____________4"),

				("0____________" +
				 "1____________" +
				 "2____________" +
				 "3____________" +
				 "4____________"),

				("____________0" +
				 "____________1" +
				 "____________2" +
				 "____________3" +
				 "____________4")
			],
			[
				2.5,
				2.5,
				2.5
			],
			true,
			0,
			JVConstants.PLAY_SPACE_WIDTH,
			JVConstants.PLAY_SPACE_HEIGHT,
			13,
			5,
			EXTOffsetType.TOP_CENTER
			);
	}

	private static function enemyPatternFromString(shipCount:Int, 
												   keyFrameCount:Int, 
												   stringData:Array<String>, 
												   timeData:Array<Float>,
												   shouldLoop:Bool,
												   loopToIndex:Int,
												   totalWidth:Int,
												   totalHeight:Int,
												   gridColumns:Int,
												   gridRows:Int,
												   spawnAnchor:EXTOffsetType):JVEnemyPattern
	{
		var enemyPattern:JVEnemyPattern = new JVEnemyPattern();
		enemyPattern.keyFrameCount = keyFrameCount;
		enemyPattern.loops = shouldLoop;
		enemyPattern.loopIndex = loopToIndex;
		enemyPattern.keyFramePositions = new Array();
		enemyPattern.keyFrameTimes = new Array();
		enemyPattern.shipCount = shipCount;
		enemyPattern.totalWidth = totalWidth;
		enemyPattern.totalHeight = totalHeight;
		enemyPattern.spawnAnchor = spawnAnchor;
		enemyPattern.gridColumns = gridColumns;
		enemyPattern.gridRows = gridRows;

		var stringToIndexMap:Map<String, Int> = new Map();
		for (i in 0...shipCount)
		{
			var stringIndex:String = i + "";
			stringToIndexMap[stringIndex] = i;
			enemyPattern.keyFramePositions.push(new Array());
		}

		for (i in 0...keyFrameCount)
		{
			var keyFrameString:String = stringData[i];

			var xModifier:Int = -6;
			var yModifier:Int = -2;
			var xOffset:Int = 0;
			var yOffset:Int = 0;
			for (character in keyFrameString.split(""))
			{
				if (character != "_")
				{
					var shipIndex:Int = stringToIndexMap[character];
					enemyPattern.keyFramePositions[shipIndex].push(new Point(xOffset + xModifier, yOffset + yModifier));
				}

				++xOffset;
				if (xOffset == gridColumns)
				{
					xOffset = 0;
					++yOffset;
				}
			}

			enemyPattern.keyFrameTimes.push(timeData[i]);
		}

		return enemyPattern;
	}
}
