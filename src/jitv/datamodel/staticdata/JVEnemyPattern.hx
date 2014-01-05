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
	public var shipCount:Int; 		// Number of ships in this pattern
	public var keyFrameCount:Int; 	// Number of keyframes in the pattern data
	public var keyFramePositions:Array<Array<Point>>; // Each element is an array of keyframes of positions for the ship at that index
	public var keyFrameTimes:Array<Float>; 	// Each element is the time between the keyframe for that index, and the next one
	public var loops:Bool; 					// Whether this pattern loops, or if enemies just maintain their final position until they exit the screen
	public var loopIndex:Int; 				// Which keyframe to loop back to if this pattern loops
	public var spawnAnchor:EXTOffsetType; 	// How to anchor this pattern in the screen
	public var initialPositionOffset:Point; // Position offset from the anchor
	public var totalWidth:Int;				// Pixel width of the entire pattern
	public var totalHeight:Int;				// Pixel height of the entire pattern
	public var gridColumns:Int;				// Number of columns in the pattern grid
	public var gridRows:Int;				// Number of rows in the column grid
	
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
			new Point(0, -JVConstants.PLAY_SPACE_HEIGHT / 5),
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
			new Point(0, -JVConstants.PLAY_SPACE_HEIGHT / 5 * 2),
			EXTOffsetType.TOP_CENTER
			);

		// ID 2
		dataDictionary[2] = cast JVEnemyPattern.enemyPatternFromString(
			5,
			4,
			[
				("______________0" +
				 "______________1" +
				 "______________2" +
				 "______________3" +
				 "______________4"),
				 
				("_____________0_" +
				 "_____________1_" +
				 "_____________2_" +
				 "_____________3_" +
				 "_____________4_"),

				("_0_____________" +
				 "_1_____________" +
				 "_2_____________" +
				 "_3_____________" +
				 "_4_____________"),

				("_____________0_" +
				 "_____________1_" +
				 "_____________2_" +
				 "_____________3_" +
				 "_____________4_")
			],
			[
				0.2,
				2.5,
				2.5,
				2.5
			],
			true,
			2,
			cast (JVConstants.PLAY_SPACE_WIDTH + JVConstants.PLAY_SPACE_WIDTH / 13 * 2),
			JVConstants.PLAY_SPACE_HEIGHT,
			15,
			5,
			new Point(0, 0),
			EXTOffsetType.TOP_CENTER
			);
		
		// ID 3
		dataDictionary[3] = cast JVEnemyPattern.enemyPatternFromString(
			3,
			4,
			[
				("___0" +
				 "____" +
				 "____" +
				 "2__1"),
				 
				("0__1" +
				 "____" +
				 "____" +
				 "___2"),

				("1__2" +
				 "____" +
				 "____" +
				 "0___"),

				("2___" +
				 "____" +
				 "____" +
				 "1__0"),
			],
			[
				1.5,
				1.5,
				1.5,
				1.5
			],
			false,
			0,
			cast (JVConstants.PLAY_SPACE_WIDTH * 0.25),
			cast (JVConstants.PLAY_SPACE_WIDTH * 0.25),
			4,
			4,
			new Point(32, 0),
			EXTOffsetType.TOP_RIGHT
			);
		
		// ID 4
		dataDictionary[4] = cast JVEnemyPattern.enemyPatternFromString(
			3,
			4,
			[
				("0___" +
				 "____" +
				 "____" +
				 "1__2"),
				 
				("1__0" +
				 "____" +
				 "____" +
				 "2___"),

				("2__1" +
				 "____" +
				 "____" +
				 "___0"),

				("___2" +
				 "____" +
				 "____" +
				 "0__1"),
			],
			[
				1.5,
				1.5,
				1.5,
				1.5
			],
			false,
			0,
			cast (JVConstants.PLAY_SPACE_WIDTH * 0.25),
			cast (JVConstants.PLAY_SPACE_WIDTH * 0.25),
			4,
			4,
			new Point(-32, 0),
			EXTOffsetType.TOP_LEFT
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
												   initialPositionOffset:Point,
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
		enemyPattern.initialPositionOffset = initialPositionOffset;

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
			
			var xOffset:Int = 0;
			var yOffset:Int = 0;
			for (character in keyFrameString.split(""))
			{
				if (character != "_")
				{
					var shipIndex:Int = stringToIndexMap[character];
					enemyPattern.keyFramePositions[shipIndex].push(new Point(xOffset, yOffset));
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
