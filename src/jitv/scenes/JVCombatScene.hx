package jitv.scenes;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
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
	
	/**
	 * Void:onPause
	 * This function is called when the player wishes to pause the game. A Bool paused is passed in as an argument for the function. If true, the game pauses. If false, the game resumes from a pause.
	 * PRECON:		A player has triggered the key bind for pausing the game. 
	 * POSTCON:		The game screen is paused if paused is true, otherwise the game returns and resumes.
	 * 
	 * @param	paused
	 */
	public function onPause(paused:Bool):Void
	{
		_paused = paused;
	}
	
	override public function begin():Void
	{
		//HXP.screen.color = 0x26B0E9;
		
		_hudView = new JVHudView(this.worldCamera);
		this.staticUiController.rootView.addSubview(_hudView);
		//this.addWaves();
		_starEmitter = new JVStarEmitter();
		this.add(_starEmitter);
		
		_playerShip = new JVPlayerShipEntity(_hudView);
		_playerShip.x = 320;
		_playerShip.y = 240;
		this.add(_playerShip);
		
		_levelEndsTimer = EXTTimer.createTimer(8, false, goToLevelSelectScene);
		_levelEndsTimer.paused = true;
		
		_gameover = false;
	}
	
	override public function update():Void
	{
		if (Input.released(Key.ESCAPE))
			onPause(!_paused);

		if (_paused)
			return;

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
		if (_playerShip != null && !_playerShip.isInvincible())
		{
			var collidedEnemy:Entity = _playerShip.collide("enemy", _playerShip.x, _playerShip.y);
			if (collidedEnemy != null)
			{
				this.remove(collidedEnemy);
				//DESC: Remove the player ship if there are no more lives. Otherwise call method for the ship being hit.
				if (_playerShip.getLives() == 0)
				{
					this.remove(_playerShip);
					_playerShip = null;
					_gameover = true;
				}
				else
				{
					_playerShip.isHit();
					this.remove(_playerShip);
					_playerRespawnTimer = EXTTimer.createTimer(3, false, respawnPlayer);
				}
			}
		}
		
		// If player has died start the end level timer
		if (_gameover)
		{
			_levelEndsTimer.paused = false;
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
	private var _paused:Bool = false;
	private var _starEmitter:JVStarEmitter;
	private var _playerShip:JVPlayerShipEntity;
	private var _levelData:JVLevel;
	private var _spawnTimesCompleted:Int = 0;
	private var _levelEndsTimer:EXTTimer;
	private var _playerRespawnTimer:EXTTimer;
	private var _hudView:JVHudView;
	private var _gameover:Bool;
	
	private function respawnPlayer(timer:EXTTimer):Void
	{
		_playerShip.x = 320;
		_playerShip.y = 240;
		this.add(_playerShip);
		_playerShip.activateInvincibility();
	}

	
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
