package jitv.datamodel.staticdata;

import flash.geom.Point;
import jitv.datamodel.JVDataObject;
import tjson.TJSON;
import extendedhxpunk.ext.EXTJsonSerialization;

/**
 * ...
 * @author Fletcher
 */
class JVJsonTestDataClass extends JVDataObject
{
	public var myValue:Int;
	public var testObject:Point;
	
	public static inline var DATA_TYPE_NAME:String = "json_test_data_class";
	public function new() 
	{
	}
	
	public static function setupFakeDB():Void
	{
		var dataDictionary:Map<Int, JVDataObject> = new Map();
		JVDataObject.fakeDB[DATA_TYPE_NAME] = dataDictionary;
		
		var myData:JVJsonTestDataClass = EXTJsonSerialization.decode("{ myValue: 1, name: 'testdata1', id: 2 , testObject: { _explicitType: 'flash.geom.Point', x: 1, y: 2 } }", JVJsonTestDataClass);
		
		dataDictionary[0] = cast myData;
	}
}
