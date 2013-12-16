package jitv.datamodel;

import flash.utils.Dictionary;
import jitv.datamodel.staticdata.*;

/**
 * JVDataObject
 * Super class for our data models, contains values necessary for all data.
 * Created by Fletcher 11/30/13, Ported by Fletcher 12/15/2013
 */
class JVDataObject
{
	public var id:UInt;
	public var name:String;
	
	// Fake database until we get sqlite or something set up
	public static var fakeDB:Dictionary;
	public static function setupFakeDB():Void
	{
		fakeDB = new Dictionary();
		//JVEnemy.setupFakeDB();
		//JVEnemyPattern.setupFakeDB();
		//JVEnemyWave.setupFakeDB();
	}
}
