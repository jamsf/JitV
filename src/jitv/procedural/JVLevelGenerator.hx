package jitv.procedural;

import jitv.datamodel.JVDataObject;
import jitv.datamodel.proceduraldata.JVLevel;
import jitv.datamodel.proceduraldata.JVEnemy;
import jitv.datamodel.staticdata.JVEnemyClass;
import jitv.datamodel.staticdata.JVEnemyPattern;

/**
 * JVLevelGenerator
 * Generates JVLevel procedural data objects
 * Created by Fletcher, 12/25/2013 - Merry Christmas!
 */
class JVLevelGenerator
{
	/**
	 * Singleton access
	 */
	public static function sharedInstance():JVLevelGenerator
	{
		if (_Singleton == null)
			_Singleton = new JVLevelGenerator();
		return _Singleton;
	}

	/**
	 * Generates a level data object for the given parameters
	 * @param difficulty		How hard this level should be
	 * @param campaignProgress	How much progress has been made in the campaign
	 * @param levelTypes		Strings describing the type of level this is
	 */
	public function generateLevel(difficulty:Int, campaignProgress:Int, levelTypes:Array<String>):JVLevel
	{
		//NOTE - fcole - Temp logic
		var level:JVLevel = new JVLevel();
		level.spawnTimes = [20, 50, 80, 100, 120, 140, 160, 180, 200, 220, 240, 250, 260, 270, 290, 300, 310, 320, 330, 335, 340];
		level.enemiesForTimes = new Map();

		var id:Int = 0;
		var classIdCounter:Int = 0;

		for (spawnTime in level.spawnTimes)
		{
			if (level.enemiesForTimes[spawnTime] == null)
				level.enemiesForTimes[spawnTime] = new Array();

			classIdCounter = Std.int(Math.random() * JVEnemyClass.ENEMY_CLASS_IDS);
			var classId:Int = classIdCounter % JVEnemyClass.ENEMY_CLASS_IDS; 
			var enemy:JVEnemy = new JVEnemy();
			enemy.id = id++;
			enemy.name = "Enemy Instance " + id;
			enemy.spawnTime = spawnTime;
			enemy.enemyClassId = classId;
			enemy.indexInPattern = 0;
			level.enemiesForTimes[spawnTime].push(enemy);

			var enemyPattern:JVEnemyPattern = enemy.enemyPattern;

			for (i in 1...enemyPattern.shipCount)
			{
				enemy = new JVEnemy();
				enemy.id = id++;
				enemy.name = "Enemy Instance " + id;
				enemy.spawnTime = spawnTime;
				enemy.enemyClassId = classId;
				enemy.indexInPattern = i;
				level.enemiesForTimes[spawnTime].push(enemy);
			}

			// ++classIdCounter;
		}

		return level;
	}

	/**
	 * For singleton guarding
	 */
	private static var _Singleton:JVLevelGenerator = null;
	private function new() { }
}
