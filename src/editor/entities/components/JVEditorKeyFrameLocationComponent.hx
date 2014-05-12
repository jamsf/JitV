package editor.entities.components;

import jitv.entities.components.JVEntityComponent;
import jitv.entities.JVEntity;
import editor.JVEditorStateHandler;

/**
 * ...
 * Created by Fletcher, 3/30/2014
 */
class JVEditorKeyFrameLocationComponent implements JVEntityComponent
{
	public function new(parentEntity:JVEntity, editorStateHandler:JVEditorStateHandler, shipIndex:Int, keyFrameIndex:Int) 
	{
		_parentEntity = parentEntity;
		_editorStateHandler = editorStateHandler;
		_shipIndex = shipIndex;
		_keyFrameIndex = keyFrameIndex;
	}
	
	public function update():Void
	{
		_parentEntity.visible = ((_editorStateHandler.currentShipIndex == -1 || 
								  _editorStateHandler.currentShipIndex == _shipIndex) &&
								 (_editorStateHandler.currentKeyFrameIndex == -1 || 
								  _editorStateHandler.currentKeyFrameIndex == _keyFrameIndex));
	}
	
	public function render():Void
	{
		
	}
	
	public function prepare():Void
	{
		
	}
	
	public function cleanup():Void
	{
		_parentEntity = null;
		_editorStateHandler = null;
	}
	
	/*
	 * Private
	 */
	private var _parentEntity:JVEntity;
	private var _editorStateHandler:JVEditorStateHandler;
	private var _shipIndex:Int;
	private var _keyFrameIndex:Int;
}
