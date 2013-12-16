package jitv.scenes;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Spritemap;
import extendedhxpunk.ext.EXTScene;
import jitv.datamodel.proceduraldata.JVLevel;
import jitv.entities.JVEnemyEntity;
import jitv.entities.JVPlayerShipEntity;
import jitv.ui.JVHudView;

/**
 * JVCombatWorld
 * A world which represents a combat level in the game; the player(s) 
 * fly around shooting enemies.
 * Created by Fletcher 11/3/13, Ported by Fletcher 12/15/13
 */
class JVCombatScene extends EXTScene
{
	public function new(level:JVLevel) 
	{
		super();
		
		this.staticUiController.rootView.addSubview(new JVHudView());
		this.addWaves();
		
		_playerShip = new JVPlayerShipEntity();
		_playerShip.x = 320;
		_playerShip.y = 240;
		this.add(_playerShip);
		
//			this.worldCamera.zoomWithAnchor(0.25, this.worldCamera.currentPosition(EXTOffsetType.CENTER, true), EXTOffsetType.CENTER);
	}
	
	override public function update():Void
	{
		super.update();
		
		++_time;
		
		// Update background waves
		for (map in _waveMaps)
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
			enemyShip.y = -enemyShip.height - 2 - 1;
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
	private var _time:UInt;
	private var _waveMaps:Array<Spritemap> = new Array();
	private var _playerShip:JVPlayerShipEntity;
	
	private function addWaves():Void
	{
		var indexArray:Array = new Array(0, 1, 2, 3);
		
		for (i in 0...FP.screen.width)
		//for (var i:Number = 0; i * 32 < FP.screen.width; ++i)
		{
			for (j in 0...FP.screen.height)
			//for (var j:Number = 0; j * 32 < FP.screen.height + 32; ++j)
			{
				var wavesMap:Spritemap = new Spritemap("gfx/misc/waves.png", 32, 32);
				wavesMap.add("animate", indexArray, 0.05);
				wavesMap.play("animate");
				var waveEntity:Entity = new Entity(i * 32, j * 32 - 32, wavesMap);
				this.add(waveEntity);
				_waveMaps.push(wavesMap);
			}
		}
	}
}
