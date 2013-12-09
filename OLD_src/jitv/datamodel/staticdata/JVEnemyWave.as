package jitv.datamodel.staticdata
{
	import flash.utils.Dictionary;
	
	import jitv.datamodel.JVDataObject;

	public class JVEnemyWave extends JVDataObject
	{
		public var enemies:Vector.<uint>; // Enemy ids
		
		/**
		 * Private
		 */
		private static var DATA_TYPE_NAME:String = "enemy_wave";
		
		// Fake database setup
		public static function setupFakeDB():void
		{
			var dataDictionary:Dictionary = new Dictionary();
			JVDataObject.fakeDB[DATA_TYPE_NAME] = dataDictionary;
		}
	}
}
