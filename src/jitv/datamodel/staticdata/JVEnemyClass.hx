package jitv.datamodel.staticdata;

import flash.geom.Point;
import jitv.datamodel.JVDataObject;
import extendedhxpunk.ext.EXTJsonSerialization;

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

	//(get, never)
	// For setting properties from json
	
	
	// Data info
	public static var ENEMY_CLASS_IDS:Int = 0;
	public static inline var DATA_TYPE_NAME:String = "enemy_class";
	public function new() { }
	
	// Fake database setup
	public static function setupFakeDB():Void
	{
		var dataDictionary:Map<Int, JVDataObject> = new Map();
		JVDataObject.fakeDB[DATA_TYPE_NAME] = dataDictionary;
		
		var id:Int = 0;
		var enemy:JVEnemyClass;
		
		enemy = EXTJsonSerialization.decode(
		"{" +
			"id: " + id                + ", " +
			"name: 'Enemy " + id + "'" + ", " +
			"type: ''"                 + ", " +
			"difficulty: 0"            + ", " +
			"patternId: 0"             + ", " +
			"patternDelay: 1"          + ", " +
			"speedDuringPattern: { _explicitType: 'flash.geom.Point', x: 0, y: 0 }" + ", " +
			"speedBeforePattern: { _explicitType: 'flash.geom.Point', x: 0, y: 2 }" + ", " +
			"speedAfterPattern:  { _explicitType: 'flash.geom.Point', x: 0, y: 2 }" + ", " +
			"attackType: 'standard'"   + ", " +
			"imageName: 'enemy_0_entity'" +
		"}", JVEnemyClass);

		//enemy = new JVEnemyClass();
		//enemy.id = id;
		//enemy.name = "Enemy " + id;
		//enemy.type = "";
		//enemy.difficulty = 0;
		//enemy.patternId = 0;
		//enemy.patternDelay = 1;
		//enemy.speedDuringPattern = new Point(0, 0);
		//enemy.speedBeforePattern = new Point(0, 2);
		//enemy.speedAfterPattern = new Point(0, 2);
		//enemy.attackType = "standard";
		//enemy.imageName = "enemy_0_entity";
		dataDictionary[id] = cast enemy;
		++id;
		
		enemy = new JVEnemyClass();
		enemy.id = id;
		enemy.name = "Enemy " + id;
		enemy.type = "";
		enemy.difficulty = 0;
		enemy.patternId = 1;
		enemy.patternDelay = 1;
		enemy.speedDuringPattern = new Point(0, 0);
		enemy.speedBeforePattern = new Point(0, 2);
		enemy.speedAfterPattern = new Point(0, 2);
		enemy.attackType = "standard";
		enemy.imageName = "enemy_0_entity";
		dataDictionary[id] = cast enemy;
		++id;
		
		enemy = new JVEnemyClass();
		enemy.id = id;
		enemy.name = "Enemy " + id;
		enemy.type = "";
		enemy.difficulty = 0;
		enemy.patternId = 2;
		enemy.patternDelay = 0;
		enemy.speedDuringPattern = new Point(0, 1);
		enemy.speedBeforePattern = enemy.speedDuringPattern;
		enemy.speedAfterPattern = enemy.speedDuringPattern;
		enemy.attackType = "standard";
		enemy.imageName = "enemy_0_entity";
		dataDictionary[id] = cast enemy;
		++id;
		
		enemy = new JVEnemyClass();
		enemy.id = id;
		enemy.name = "Enemy " + id;
		enemy.type = "";
		enemy.difficulty = 0;
		enemy.patternId = 3;
		enemy.patternDelay = 2;
		enemy.speedDuringPattern = new Point(0, 0);
		enemy.speedBeforePattern = new Point(-2, 0);
		enemy.speedAfterPattern = new Point(2, 0);
		enemy.attackType = "standard";
		enemy.imageName = "enemy_1_entity";
		dataDictionary[id] = cast enemy;
		++id;
		
		enemy = new JVEnemyClass();
		enemy.id = id;
		enemy.name = "Enemy " + id;
		enemy.type = "";
		enemy.difficulty = 0;
		enemy.patternId = 4;
		enemy.patternDelay = 2;
		enemy.speedDuringPattern = new Point(0, 0);
		enemy.speedBeforePattern = new Point(2, 0);
		enemy.speedAfterPattern = new Point(-2, 0);
		enemy.attackType = "standard";
		enemy.imageName = "enemy_1_entity";
		dataDictionary[id] = cast enemy;
		++id;
		
		ENEMY_CLASS_IDS = id;
	}
}
