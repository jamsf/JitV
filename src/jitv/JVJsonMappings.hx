package jitv;

/**
 * ...
 * Created by Fletcher, 2/17/2014
 */
class JVJsonMappings
{
	//public static var explicitTypeMapping = 
	//{ 
		//"Point" : "flash.geom.Point",
		//"JVEnemyClass" : "jitv.datamodel.staticdata.JVEnemyClass",
		//"JVEnemyPattern" : "jitv.datamodel.staticdata.JVEnemyPattern"
	//};
	
	public static var fieldMapping = 
	{ 
		"flash.geom.Point" : ["x", "y"]
	};
	
	public static function createEncodable(objectToEncode:Dynamic):Dynamic
	{
		var type = Type.getClass(objectToEncode);
		var typeName:String = null;
		if (type != null)
		{
			typeName = Type.getClassName(type);
			//if (Reflect.hasField(explicitTypeMapping, typeName))
				//Reflect.setField(encodable, "_explicitType", Reflect.field(explicitTypeMapping, typeName));
		}
		
		if (typeName == "Array")
		{
			var encodableArray:Array<Dynamic> = new Array();
			var objectArray:Array<Dynamic> = cast objectToEncode;
			
			for (i in 0...objectArray.length)
			{
				var value = objectArray[i];
				
				if (isEncodable(value))
				{
					var valueTypeString:String = Type.getClassName(Type.getClass(value));
					var isValueObject:Bool = (Reflect.isObject(value) && valueTypeString != "String") || (valueTypeString == "Array");
					
					if (isValueObject)
					{
						var encodableValue = createEncodable(value);
						encodableArray.push(encodableValue);
					}
					else
					{
						encodableArray.push(value);
					}
				}
			}
			
			return encodableArray;
		}
		else
		{
			var encodable:Dynamic = { };
			if (typeName != null)
				Reflect.setField(encodable, "_explicitType", typeName);
			
			var fields:Array<String> = JVJsonMappings.getFields(objectToEncode);
			for (field in fields)
			{
				var value = Reflect.field(objectToEncode, field);
				
				if (isEncodable(value))
				{
					var valueTypeString:String = Type.getClassName(Type.getClass(value));
					var isValueObject:Bool = (Reflect.isObject(value) && valueTypeString != "String") || (valueTypeString == "Array");
					if (isValueObject)
					{
						var encodableValue = createEncodable(value);
						Reflect.setField(encodable, field, encodableValue);
					}
					else
					{
						Reflect.setField(encodable, field, value);
					}
				}
			}
			
			return encodable;
		}
	}
	
	public static function isEncodable(obj:Dynamic):Bool
	{
		return !Reflect.isFunction(obj) && !Std.is(obj, Enum);
	}
	
	public static function getFields(obj:Dynamic):Array<String>
	{
		var type = Type.getClass(obj);
		var typeName:String = null;
		if (type != null)
			typeName = Type.getClassName(Type.getClass(obj));
		
		//if (typeName != null && Reflect.hasField(explicitTypeMapping, typeName) && Reflect.hasField(fieldMapping, Reflect.field(explicitTypeMapping, typeName)))
		//{
			//return Reflect.field(fieldMapping, Reflect.field(explicitTypeMapping, typeName));
		//}
		if (typeName != null && Reflect.hasField(fieldMapping, typeName))
		{
			return Reflect.field(fieldMapping, typeName);
		}
		else if (isAnonymous(obj))
		{
			return Reflect.fields(obj);
		}
		else if (type != null)
		{
			return Type.getInstanceFields(type);
		}
		else
		{
			throw "Could not get fields for object";
			return null;
		}
	}
	
	public static function isAnonymous(obj:Dynamic):Bool
	{
		return Type.typeof(obj) == TObject && !Std.is(obj, Class) && !Std.is(obj, Enum);
	}
}
