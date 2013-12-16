package jitv.datamodel.staticdata;

import flash.utils.Dictionary;
import jitv.datamodel.JVDataObject;

/**
 * JVEnemyPattern
 * A data model class specifying an attack pattern type for enemies.
 * Created by Fletcher, 11/30/13
 */
class JVEnemyPattern extends JVDataObject
{
	//TODO - fcole - Properties describing movement speed, path, and attack types for enemies in the pattern
	
	/**
	 * Private
	 */
	private static inline var DATA_TYPE_NAME:String = "enemy_pattern";
	
	// Fake database setup
	public static function setupFakeDB():Void
	{
		var dataDictionary:Dictionary = new Dictionary();
		JVDataObject.fakeDB[DATA_TYPE_NAME] = dataDictionary;
	}
}
