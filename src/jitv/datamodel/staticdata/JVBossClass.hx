package jitv.datamodel.staticdata;

import jitv.datamodel.JVDataObject;

/**
 * JVBossClass
 * Created by Fletcher 11/22/2014
 */
class JVBossClass extends JVDataObject
{
	public var componentImageNames:Array<String>;
	public var projectileImageNames:Array<String>;
	public var unlockCondition:String;
	public var unlockParameters:Array<Dynamic>;
	public var behaviorName:String;
	public var favoredEnemyIds:Array<Int>;
	public var favoredWeaponDropIds:Array<Int>;
	public var specialTraits:Array<String>;
	
	// Data info
	public static var BOSS_CLASS_IDS:Int = 0;
	public static inline var DATA_TYPE_NAME:String = "boss_class";
	public function new() { }
	
	// Fake database setup
	public static function setupDB():Void
	{
		BOSS_CLASS_IDS = JVDataObject.setupDbForDataType(DATA_TYPE_NAME);
	}
}
