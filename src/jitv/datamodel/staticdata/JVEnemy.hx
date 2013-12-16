package jitv.datamodel.staticdata;

import jitv.datamodel.JVDataObject;

/**
 * JVEnemy
 * A data model class containing data for a type of enemy.
 * Created by Fletcher 11/30/13, Ported by Fletcher 12/15/13
 */
class JVEnemy extends JVDataObject
{
	public var type:String; // Enemy type should probably be its own data model, and this property should be either an id or an array of ids
	public var difficulty:UInt;
	public var patternId:UInt;
	public var imageName:String;
	
	/**
	 * Private
	 */
	private static inline var DATA_TYPE_NAME:String = "enemy";
	public function new() { }
	
	// Fake database setup
	public static function setupFakeDB():Void
	{
		var dataDictionary:Map<Int, JVDataObject> = new Map();
		JVDataObject.fakeDB[DATA_TYPE_NAME] = dataDictionary;
		
		for (i in 0...10)
		{
			var enemy:JVEnemy = new JVEnemy();
			enemy.id = i;
			enemy.type = "";
			enemy.difficulty = 0;
			enemy.patternId = 0;
			enemy.imageName = "ENEMY_0_ENTITY";
			dataDictionary[i] = cast enemy;
		}
	}
}
