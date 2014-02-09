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
		dataDictionary[id] = cast enemy;
		++id;
		
		enemy = EXTJsonSerialization.decode(
		"{" +
			"id: " + id                + ", " +
			"name: 'Enemy " + id + "'" + ", " +
			"type: ''"                 + ", " +
			"difficulty: 0"            + ", " +
			"patternId: 1"             + ", " +
			"patternDelay: 1"          + ", " +
			"speedDuringPattern: { _explicitType: 'flash.geom.Point', x: 0, y: 0 }" + ", " +
			"speedBeforePattern: { _explicitType: 'flash.geom.Point', x: 0, y: 2 }" + ", " +
			"speedAfterPattern:  { _explicitType: 'flash.geom.Point', x: 0, y: 2 }" + ", " +
			"attackType: 'standard'"   + ", " +
			"imageName: 'enemy_0_entity'" +
		"}", JVEnemyClass);
		dataDictionary[id] = cast enemy;
		++id;
		
		enemy = EXTJsonSerialization.decode(
		"{" +
			"id: " + id                + ", " +
			"name: 'Enemy " + id + "'" + ", " +
			"type: ''"                 + ", " +
			"difficulty: 0"            + ", " +
			"patternId: 2"             + ", " +
			"patternDelay: 0"          + ", " +
			"speedDuringPattern: { _explicitType: 'flash.geom.Point', x: 0, y: 1 }" + ", " +
			"speedBeforePattern: { _explicitType: 'flash.geom.Point', x: 0, y: 1 }" + ", " +
			"speedAfterPattern:  { _explicitType: 'flash.geom.Point', x: 0, y: 1 }" + ", " +
			"attackType: 'standard'"   + ", " +
			"imageName: 'enemy_0_entity'" +
		"}", JVEnemyClass);
		dataDictionary[id] = cast enemy;
		++id;
		
		enemy = EXTJsonSerialization.decode(
		"{" +
			"id: " + id                + ", " +
			"name: 'Enemy " + id + "'" + ", " +
			"type: ''"                 + ", " +
			"difficulty: 0"            + ", " +
			"patternId: 3"             + ", " +
			"patternDelay: 2"          + ", " +
			"speedDuringPattern: { _explicitType: 'flash.geom.Point', x: 0, y: 0 }" + ", " +
			"speedBeforePattern: { _explicitType: 'flash.geom.Point', x: -2, y: 0 }" + ", " +
			"speedAfterPattern:  { _explicitType: 'flash.geom.Point', x: 2, y: 0 }" + ", " +
			"attackType: 'standard'"   + ", " +
			"imageName: 'enemy_1_entity'" +
		"}", JVEnemyClass);
		dataDictionary[id] = cast enemy;
		++id;
		
		enemy = EXTJsonSerialization.decode(
		"{" +
			"id: " + id                + ", " +
			"name: 'Enemy " + id + "'" + ", " +
			"type: ''"                 + ", " +
			"difficulty: 0"            + ", " +
			"patternId: 4"             + ", " +
			"patternDelay: 2"          + ", " +
			"speedDuringPattern: { _explicitType: 'flash.geom.Point', x: 0, y: 0 }" + ", " +
			"speedBeforePattern: { _explicitType: 'flash.geom.Point', x: 2, y: 0 }" + ", " +
			"speedAfterPattern:  { _explicitType: 'flash.geom.Point', x: -2, y: 0 }" + ", " +
			"attackType: 'standard'"   + ", " +
			"imageName: 'enemy_1_entity'" +
		"}", JVEnemyClass);
		dataDictionary[id] = cast enemy;
		++id;
		
		ENEMY_CLASS_IDS = id;
	}
}
