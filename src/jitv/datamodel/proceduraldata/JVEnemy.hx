package jitv.datamodel.proceduraldata;

import jitv.datamodel.JVDataObject;
import jitv.datamodel.staticdata.JVEnemyClass;
import jitv.datamodel.staticdata.JVEnemyPattern;

/**
 * JVEnemy
 * Procedural data tying an Enemy to a spawn time, and any
 * other data unique to a specific instance of an enemy
 * Created by Fletcher, 12/25/2013
 */
class JVEnemy extends JVDataObject
{
	public var spawnTime:Float;
	public var indexInPattern:Int;
	public var enemyClassId:Int;

	// Helpers
	public var enemyClass(get, never):JVEnemyClass;
	public var enemyPattern(get, never):JVEnemyPattern;

	public function get_enemyClass():JVEnemyClass
	{
		return cast JVDataObject.lookupStaticDataObject(JVEnemyClass.DATA_TYPE_NAME, this.enemyClassId);
	}
	public function get_enemyPattern():JVEnemyPattern
	{
		return cast JVDataObject.lookupStaticDataObject(JVEnemyPattern.DATA_TYPE_NAME, this.enemyClass.patternId);
	}
}
