package jitv.datamodel.proceduraldata;

import jitv.datamodel.JVDataObject;
import jitv.datamodel.staticdata.JVEnemyWave;

/**
 * JVLevelWave
 * Procedural data tying an Enemy Wave to a spawn time, and any
 * other data unique to a specific instance of a wave
 * Created by Fletcher
 */
class JVLevelWave extends JVDataObject
{
	public var spawnFrame:UInt;
	public var enemyWave:JVEnemyWave;
}
