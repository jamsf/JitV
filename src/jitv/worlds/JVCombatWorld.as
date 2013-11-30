package jitv.worlds 
{
	import jitv.Assets;
	import jitv.datamodel.JVLevel;
	import jitv.entities.JVEnemyEntity;
	import jitv.entities.JVPlayerShipEntity;
	import jitv.ui.JVHudView;
	
	import net.extendedpunk.ext.EXTConsole;
	import net.extendedpunk.ext.EXTOffsetType;
	import net.extendedpunk.ext.EXTWorld;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Anim;
	import net.flashpunk.graphics.Spritemap;
	
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
			this.addWaves();
			
			_playerShip = new JVPlayerShipEntity();
			_playerShip.x = 320;
			_playerShip.y = 240;
			this.add(_playerShip);
			
//			this.worldCamera.zoomWithAnchor(0.25, this.worldCamera.currentPosition(EXTOffsetType.CENTER, true), EXTOffsetType.CENTER);
		}
		
		override public function update():void
		{
			super.update();
			
			++_time;
			
			// Update background waves
			for (var i:Number = 0; i < _waveMaps.length; ++i)
			{
				var map:Spritemap = _waveMaps[i];
				map.y += 1;
				if (map.y > 32)
					map.y = 0;
			}
			
			// Spawn enemies
			if (_time % 100 == 0)
			{
				var enemyShip:JVEnemyEntity = new JVEnemyEntity();
				enemyShip.x = Math.random() * FP.screen.width;
				enemyShip.y = -32;
				this.add(enemyShip);
			}
			
			// Check collisions
			if (_playerShip != null)
			{
				var collidedEnemy:Entity = _playerShip.collide("enemy", _playerShip.x, _playerShip.y);
				if (collidedEnemy != null)
				{
					this.remove(collidedEnemy);
					this.remove(_playerShip);
					_playerShip = null;
				}
			}
		}
		
		/**
		 * Private
		 */
		private var _time:int;
		private var _waveMaps:Vector.<Spritemap> = new Vector.<Spritemap>();
		private var _playerShip:JVPlayerShipEntity;
		
		private function addWaves():void
		{
			var indexArray:Array = new Array(0, 1, 2, 3);
			
			for (var i:Number = 0; i * 32 < FP.screen.width; ++i)
			{
				for (var j:Number = 0; j * 32 < FP.screen.height + 32; ++j)
				{
					var wavesMap:Spritemap = new Spritemap(Assets.WAVES_ENTITY, 32, 32);
					wavesMap.add("animate", indexArray, 0.05);
					wavesMap.play("animate");
					var waveEntity:Entity = new Entity(i * 32, j * 32 - 32, wavesMap);
					this.add(waveEntity);
					_waveMaps.push(wavesMap);
				}
			}
		}
	}
}
