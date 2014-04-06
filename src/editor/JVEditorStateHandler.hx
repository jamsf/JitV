package editor;

import jitv.datamodel.staticdata.JVEnemyPattern;

/**
 * ...
 * Created by Fletcher 4/6/2014
 */
class JVEditorStateHandler
{
	public var currentPatternIndex(default, set):Int;
	public var currentKeyFrameIndex:Int; // Display all if -1
	public var currentShipIndex:Int; // Display all if -1
	public var gridVisible(default, set):Bool;
	
	public function new(scene:JVEditorScene, dataHandler:JVEditorDataHandler) 
	{
		_scene = scene;
		_dataHandler = dataHandler;
		this.currentKeyFrameIndex = -1;
		this.currentShipIndex = -1;
		this.gridVisible = true;
	}
	
	
	/**
	 * Accessors
	 */
	public function set_currentPatternIndex(index:Int):Int
	{
		currentPatternIndex = index;
		
		var pattern:JVEnemyPattern = _dataHandler.patterns[index];
		_scene.loadPatternForDisplay(pattern);
		
		return currentPatternIndex;
	}
	
	public function set_gridVisible(visible:Bool):Bool
	{
		gridVisible = visible;
		_scene.toggleGridVisibility(visible);
		return gridVisible;
	}
	
	
	/**
	 * Private
	 */
	private var _scene:JVEditorScene;
	private var _dataHandler:JVEditorDataHandler;
}
