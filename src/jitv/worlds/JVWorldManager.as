package jitv.worlds 
{
	import net.extendedpunk.ext.EXTWorld;
	
	/**
	 * JVWorldManager
	 * Manages transitions between game worlds
	 * Created by Fletcher, 10/30/13
	 */
	public class JVWorldManager extends Object 
	{
		/**
		 * Singleton access
		 */
		public static const sharedInstance:JVWorldManager = new JVWorldManager();
		
		/**
		 * Labels for referring to world types
		 */
		//TODO - fcole - Create psuedo-enum for world type? Or probably better would be a data model class.
		public static const EXAMPLE_MENU_WORLD:uint = ++_worldTypeCount;
		public static const EXAMPLE_COMBAT_WORLD:uint = ++_worldTypeCount;
		
		/**
		 * Send us to another game world
		 */
		public function goToWorld(newWorld:uint)
		{
			switch (newWorld)
			{
				case EXAMPLE_MENU_WORLD:
					break;
				case EXAMPLE_COMBAT_WORLD:
					break;
				default:
					throw new Error("JVWorldManager - Invalid world type");
			}
		}
		
		/**
		 * Update either the current world or the transition between worlds
		 */
		public function update():void
		{
			
		}
		
		/**
		 * Private
		 * 
		 * Current world in play
		 */
		private var _currentGameWorld:EXTWorld = null;
		 
		/**
		 * Helper for assigning uints to worlds
		 */
		//TODO - fcole - Create psuedo-enum for world type? Or probably better would be a data model class.
		private static var _worldTypeCount:uint = 0;
		
		/**
		 * For singleton guarding
		 */
		private static var _created:Boolean = false;
		public function JVWorldManager() 
		{
			if (!_created)
				_created = true;
			else
				throw new Error("JVWorldManager is a singleton - should only be created once");
		}
	}
}
