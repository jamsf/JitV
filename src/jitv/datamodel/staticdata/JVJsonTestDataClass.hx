package jitv.datamodel.staticdata;

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
	
	public static inline var DATA_TYPE_NAME:String = "json_test_data_class";
	public function new() 
	{
	}
	
	public static function setupFakeDB():Void
	{
		var dataDictionary:Map<Int, JVDataObject> = new Map();
		JVDataObject.fakeDB[DATA_TYPE_NAME] = dataDictionary;
		
		var myData:JVJsonTestDataClass = EXTJsonSerialization.decode("{ myValue: 0 }", JVJsonTestDataClass); //cast TJSON.parse("{ myValue: 0}");
		
		dataDictionary[0] = cast myData;
	}
}
