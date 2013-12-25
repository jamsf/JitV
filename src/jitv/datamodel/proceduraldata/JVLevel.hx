package jitv.datamodel.proceduraldata;

import jitv.datamodel.JVDataObject;

/**
 * JVLevel
 * A data model class representing data for a combat level in the game.
 * Created by Fletcher, 11/3/13
 */
class JVLevel extends JVDataObject
{
	public var spawnTimes:Array<Float>; // An array of times (counting up from scene start) when enemies should appear
	public var enemiesForTimes:Map<Float, JVEnemy>; // Maps spawn times to the enemies to spawn at that time

	//TODO - fcole - Properties for type of environment, length, whether there's a boss, and anything else specific to different levels.
	public function new() { }
}
