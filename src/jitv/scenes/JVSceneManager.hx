package jitv.scenes;

import com.haxepunk.HXP;
import extendedhxpunk.ext.EXTScene;

/**
 * JVWorldManager
 * Manages transitions between game scenes
 * Created by Fletcher 10/30/13, Ported by Fletcher 12/8/2013
 */
class JVSceneManager
{
	/**
	 * Singleton access
	 */
	public static function sharedInstance():JVSceneManager
	{
		if (_Singleton == null)
			_Singleton = new JVSceneManager();
		return _Singleton;
	}
	
	/**
	 * Create the main menu scene and go to it.
	 */
	public function goToMainMenuScene():Void
	{
		clearScene();
		_currentGameScene = new JVMainMenuScene();
	}
	
	/**
	 * Create the level select world and go to it.
	 */
	public function goToLevelSelectScene():Void
	{
		clearScene();
		_currentGameScene = new JVLevelSelectScene();
	}
	
	/**
	 * Update either the current world or the transition between worlds
	 */
	public function update():Void
	{
		//TODO - fcole - Scene transitions
		if (HXP.scene != _currentGameScene)
			HXP.scene = _currentGameScene;
	}
	
	/**
	 * Private
	 * 
	 * Current world in play
	 */
	private var _currentGameScene:EXTScene = null;
	
	/**
	 * For singleton guarding
	 */
	private static var _Singleton:JVSceneManager = null;
	private function new() { }
	
	/*
	 * Run during scene transitions to prevent memory spike of having multiple scenes loaded
	 */
	private function clearScene():Void
	{
		HXP.scene = null;
		_currentGameScene = null;
#if flash
		flash.system.System.gc();
#elseif windows
		cpp.vm.Gc.run(true);
#end
	}
}
