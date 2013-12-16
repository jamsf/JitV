package jitv.datamodel.staticdata;

import flash.utils.Dictionary;
import jitv.datamodel.JVDataObject;

/**
 * JVEnemyWave
 * Data for a static class of a wave of enemies
 * Created by Fletcher
 */
class JVEnemyWave extends JVDataObject
{
	public var enemies:Array<UInt>; // Enemy ids
	
	/**
	 * Private
	 */
	private static inline var DATA_TYPE_NAME:String = "enemy_wave";
	
	// Fake database setup
	public static function setupFakeDB():Void
	{
		var dataDictionary:Dictionary = new Dictionary();
		JVDataObject.fakeDB[DATA_TYPE_NAME] = dataDictionary;
	}
}
