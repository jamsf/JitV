package jitv.datamodel;

import jitv.datamodel.staticdata.*;
import extendedhxpunk.ext.EXTJsonSerialization;

/**
 * JVDataObject
 * Super class for our data models, contains values necessary for all data.
 * Created by Fletcher 11/30/13, Ported by Fletcher 12/15/2013
 */
class JVDataObject
{
	public var id:UInt;
	public var name:String;
	
	// Map of all our data objects
	public static var DB:Map<String, Map<Int, JVDataObject>>;
	public static function setupDB():Void
	{
		DB = new Map();
		JVEnemyClass.setupDB();
		JVEnemyPattern.setupDB();
		JVWeaponClass.setupDB();
	}

	public static function lookupStaticDataObject(dataClass:String, dataId:Int):JVDataObject
	{
		var dataClassMap:Map<Int, JVDataObject> = DB[dataClass];
		return dataClassMap != null ? dataClassMap[dataId] : null;
	}
}
