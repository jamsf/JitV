package jitv.worlds 
{
	import jitv.entities.JVPlayerShipEntity;
	import net.extendedpunk.ext.EXTWorld;
	import jitv.ui.JVHudView;
	import jitv.datamodel.JVLevel;
	
	/**
	 * JVCombatWorld
	 * A world which represents a combat level in the game; the player(s) 
	 * fly around shooting enemies.
	 * Created by Fletcher, 11/3/13
	 */
	public class JVCombatWorld extends EXTWorld 
	{
		public function JVCombatWorld(level:JVLevel) 
		{
			this.staticUiController.rootView.addSubview(new JVHudView());
			
			var playerShip:JVPlayerShipEntity = new JVPlayerShipEntity();
			playerShip.x = 320;
			playerShip.y = 240;
			this.add(playerShip);
			
		}
	}
}
