package jitv.worlds
{
	import jitv.datamodel.proceduraldata.*;
	import jitv.datamodel.staticdata.*;
	
	/**
	 * JVLevelGenerator
	 * Generates JVLevel data
	 * Created by Fletcher 11/30/13
	 */
	public class JVLevelGenerator extends Object
	{
		/**
		 * Singleton access
		 */
		public static const sharedInstance:JVLevelGenerator = new JVLevelGenerator();
		
		
		/**
		 * For singleton guarding
		 */
		private static var _created:Boolean = false;
		public function JVLevelGenerator()
		{
			if (!_created)
				_created = true;
			else
				throw new Error("JVLevelGenerator is a singleton - should only be created once");
		}
	}
}
