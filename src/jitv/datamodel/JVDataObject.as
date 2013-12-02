package jitv.datamodel
{
	import flash.utils.Dictionary;
	import jitv.datamodel.staticdata.*;

	/**
	 * JVDataObject
	 * Super class for our data models, contains values necessary for all data.
	 * Created by Fletcher, 11/30/13
	 */
	public class JVDataObject extends Object
	{
		public var id:uint;
		public var name:String;
		
		// Fake database until we get sqlite or something set up
		public static var fakeDB:Dictionary;
		public static function setupFakeDB():void
		{
			fakeDB = new Dictionary();
			JVEnemy.setupFakeDB();
			JVEnemyPattern.setupFakeDB();
			JVEnemyWave.setupFakeDB();
		}
	}
}
