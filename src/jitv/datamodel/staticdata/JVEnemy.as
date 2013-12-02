package jitv.datamodel.staticdata
{
	import flash.utils.Dictionary;
	
	import jitv.datamodel.JVDataObject;

	/**
	 * JVEnemy
	 * A data model class containing data for a type of enemy.
	 * Created by Fletcher, 11/30/13
	 */
	public class JVEnemy extends JVDataObject
	{
		public var type:String; // Enemy type should probably be its own data model, and this property should be either an id or an array of ids
		public var difficulty:uint;
		public var patternId:uint;
		public var imageName:String;
		
		/**
		 * Private
		 */
		private static var DATA_TYPE_NAME:String = "enemy";
		
		// Fake database setup
		public static function setupFakeDB():void
		{
			var dataDictionary:Dictionary = new Dictionary();
			JVDataObject.fakeDB[DATA_TYPE_NAME] = dataDictionary;
			
			for (var i:uint = 0; i < 10; ++i)
			{
				var enemy:JVEnemy = new JVEnemy();
				enemy.type = "";
				enemy.difficulty = 0;
				enemy.patternId = 0;
				enemy.imageName = "ENEMY_0_ENTITY";
				dataDictionary[i] = enemy;
			}
		}
	}
}
