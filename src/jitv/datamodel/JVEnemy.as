package jitv.datamodel
{
	/**
	 * JVEnemy
	 * A data model class containing data for a type of enemy.
	 * Created by Fletcher, 11/30/13
	 */
	public class JVEnemy extends JVDataObject
	{
		public var type:String;
		public var difficulty:uint;
		public var pattern:JVEnemyPattern;
		public var imageName:String;
	}
}
