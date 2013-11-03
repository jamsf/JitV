package jitv.worlds 
{
	import jitv.datamodel.JVLevel;
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
		 * Create a world for a combat level, and go to it.
		 * @param	level	The data for the level, with which to generate a game world.
		 */
		public function goToWorldForCombatLevel(level:JVLevel):void
		{
			//TODO
		}
		
		/**
		 * Create the level select world and go to it.
		 */
		public function goToLevelSelectWorld():void
		{
			//TODO
		}
		
		/**
		 * Create the main menu world and go to it.
		 */
		public function goToMainMenuWorld():void
		{
			//TODO
		}
		
		/**
		 * Update either the current world or the transition between worlds
		 */
		public function update():void
		{
			//TODO
		}
		
		/**
		 * Private
		 * 
		 * Current world in play
		 */
		private var _currentGameWorld:EXTWorld = null;
		
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
