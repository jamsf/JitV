package jitv.datamodel;

import haxe.Resource;
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
		JVBossClass.setupDB();
	}

	public static function lookupStaticDataObject(dataClass:String, dataId:Int):JVDataObject
	{
		var dataClassMap:Map<Int, JVDataObject> = DB[dataClass];
		return dataClassMap != null ? dataClassMap[dataId] : null;
	}
	
	/**
	 * Private
	 */
	private static function setupDbForDataType(dataType:String):Int
	{
		var dataDictionary:Map<Int, JVDataObject> = new Map();
		JVDataObject.DB[dataType] = dataDictionary;
		
		var fileContent:String = Resource.getString(dataType);
		var dataArray:Array<JVEnemyClass> = EXTJsonSerialization.decode(fileContent, Array);
		
		for (i in 0...dataArray.length)
			dataDictionary[i] = cast dataArray[i];
		
		return dataArray.length;
	}
}
