package jitv.datamodel.staticdata;

import jitv.datamodel.JVDataObject;

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
	public var speed:Int; // Constant vertical speed of enemy, in addition to any movement specified by the enemy pattern
	public var attackType:String;
	public var imageName:String;

	// Data info
	public static inline var DATA_TYPE_NAME:String = "enemy_class";
	public function new() { }
	
	// Fake database setup
	public static function setupFakeDB():Void
	{
		var dataDictionary:Map<Int, JVDataObject> = new Map();
		JVDataObject.fakeDB[DATA_TYPE_NAME] = dataDictionary;
		
		for (i in 0...10)
		{
			var enemy:JVEnemyClass = new JVEnemyClass();
			enemy.id = i;
			enemy.name = "Enemy " + i;
			enemy.type = "";
			enemy.difficulty = 0;
			enemy.patternId = 0;
			enemy.speed = i + 1;
			enemy.attackType = "standard";
			enemy.imageName = "ENEMY_0_ENTITY";
			dataDictionary[i] = cast enemy;
		}
	}
}
