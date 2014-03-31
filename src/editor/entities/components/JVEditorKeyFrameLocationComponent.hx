package editor.entities.components;

import jitv.entities.components.JVEntityComponent;
import jitv.entities.JVEntity;
import editor.JVEditorScene;

/**
 * ...
 * Created by Fletcher, 3/30/2014
 */
class JVEditorKeyFrameLocationComponent implements JVEntityComponent
{
	public function new(parentEntity:JVEntity, editor:JVEditorScene, shipIndex:Int, keyFrameIndex:Int) 
	{
		_parentEntity = parentEntity;
		_editor = editor;
		_shipIndex = shipIndex;
		_keyFrameIndex = keyFrameIndex;
	}
	
	public function update():Void
	{
		_parentEntity.visible = ((_editor.currentShipIndex == -1 || _editor.currentShipIndex == _shipIndex) &&
			(_editor.currentKeyFrameIndex == -1 || _editor.currentKeyFrameIndex == _keyFrameIndex));
	}
	
	public function render():Void
	{
		
	}
	
	public function cleanup():Void
	{
		
	}
	
	/*
	 * Private
	 */
	private var _parentEntity:JVEntity;
	private var _editor:JVEditorScene;
	private var _shipIndex:Int;
	private var _keyFrameIndex:Int;
}
