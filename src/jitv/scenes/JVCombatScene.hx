package jitv.scenes;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Spritemap;
import extendedhxpunk.ext.EXTScene;
import extendedhxpunk.ext.EXTOffsetType;
import extendedhxpunk.ext.EXTUtility;
import extendedhxpunk.ext.EXTTimer;
import jitv.datamodel.proceduraldata.JVLevel;
import jitv.effects.JVStarEmitter;
import jitv.entities.JVEnemyEntity;
import jitv.entities.JVPlayerShipEntity;
import jitv.ui.JVHudView;
import jitv.JVConstants;

/**
 * JVCombatScene
 * A scene which represents a combat level in the game; the player(s) 
 * fly around shooting enemies.
 * Created by Fletcher 11/3/13, Ported by Fletcher 12/15/13
 */
class JVCombatScene extends EXTScene
{
	public function new(level:JVLevel) 
	{
		super();
		_levelData = level;
	}
	
	override public function begin():Void
	{
		//HXP.screen.color = 0x26B0E9;
		
		this.staticUiController.rootView.addSubview(new JVHudView(this.worldCamera));
		//this.addWaves();
		_starEmitter = new JVStarEmitter();
		this.add(_starEmitter);
		
		_playerShip = new JVPlayerShipEntity();
		_playerShip.x = 320;
		_playerShip.y = 240;
		this.add(_playerShip);
		
		_levelEndsTimer = EXTTimer.createTimer(20, false, goToLevelSelectScene);
		_levelEndsTimer.paused = true;
	}
	
	override public function update():Void
	{
		super.update();
		
		/*
		// Update background waves
		var mapMovement:Float = 1.0 * HXP.elapsed * JVConstants.ASSUMED_FPS_FOR_PHYSICS;
		for (map in _waveMaps)
		{
			map.y += mapMovement;
			if (map.y > 32)
				map.y = 0;
		}
		*/
		
		// Spawn enemies
		if (_spawnTimesCompleted < _levelData.spawnTimes.length)
		{
			var nextSpawnTimeInt:Int = _levelData.spawnTimes[_spawnTimesCompleted];
			var nextSpawnTime:Float = nextSpawnTimeInt / 10.0;

			if (_time >= nextSpawnTime)
			{
				++_spawnTimesCompleted;

				for (enemy in _levelData.enemiesForTimes[nextSpawnTimeInt])
				{
					var enemyShip:JVEnemyEntity = new JVEnemyEntity(enemy);
					this.add(enemyShip);
				}
			}
		}
		else
		{	
			// Go to level select 20 seconds after all enemy waves have spawned
			_levelEndsTimer.paused = false;
			//EXTTimer.createTimer(5, false, goToLevelSelectScene);
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

		_time += HXP.elapsed;
	}
	
	public function goToLevelSelectScene(timer:EXTTimer):Void
	{
		JVSceneManager.sharedInstance().goToLevelSelectScene();
	}
	
	/**
	 * Private
	 */
	private var _time:Float = 0.0;
	private var _starEmitter:JVStarEmitter;
	private var _playerShip:JVPlayerShipEntity;
	private var _levelData:JVLevel;
	private var _spawnTimesCompleted:Int = 0;
	private var _levelEndsTimer:EXTTimer;
	

	
	/*
	private function addWaves():Void
	{
		_waveMaps = new Array();
		var indexArray:Array<Int> = [0, 1, 2, 3];
		
		var i:Int = 0;
		while (i * 32 < HXP.screen.width)
		{
			var j:Int = 0;
			while (j * 32 < HXP.screen.height + 32)
			{
				var wavesMap:Spritemap = new Spritemap("gfx/misc/waves.png", 32, 32);
				wavesMap.add("animate", indexArray, 1.0);
				wavesMap.play("animate");
				var waveEntity:Entity = new Entity(i * 32, j * 32 - 32, wavesMap);
				this.add(waveEntity);
				_waveMaps.push(wavesMap);
				
				++j;
			}
			
			++i;
		}
	}
	*/
}
