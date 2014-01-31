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
	
	// Fake database until we get sqlite or something set up
	public static var fakeDB:Map<String, Map<Int, JVDataObject>>;
	public static function setupFakeDB():Void
	{
		fakeDB = new Map();
		JVEnemyClass.setupFakeDB();
		JVEnemyPattern.setupFakeDB();
		JVJsonTestDataClass.setupFakeDB();
	}

	public static function lookupStaticDataObject(dataClass:String, dataId:Int):JVDataObject
	{
		var dataClassMap:Map<Int, JVDataObject> = fakeDB[dataClass];
		return dataClassMap != null ? dataClassMap[dataId] : null;
	}
}
