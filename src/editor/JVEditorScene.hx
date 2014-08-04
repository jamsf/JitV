package editor;

import flash.geom.Point;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import extendedhxpunk.ext.EXTScene;
import extendedhxpunk.ext.EXTOffsetType;
import jitv.datamodel.staticdata.JVEnemyPattern;
import jitv.entities.JVEntity;
import jitv.JVConstants;
import editor.ui.JVEditorMainView;
import editor.entities.components.JVEditorKeyFrameLocationComponent;
import editor.entities.JVEditorGridSpaceEntity;

class JVEditorScene extends EXTScene
{	
	public function new()
	{
		HXP.resizeStage(JVEditorConstants.EDITOR_SCREEN_WIDTH , JVEditorConstants.EDITOR_SCREEN_HEIGHT);
		super();
	}

	override public function begin():Void
	{
		super.begin();
		
		_grid = new Array();
		_keyFrameLocationEntities = new Array();
		_dataHandler = new JVEditorDataHandler("./jsondata/" + JVEnemyPattern.DATA_TYPE_NAME + ".json");
		_dataHandler.loadPatternDataFromDisk();
		_stateHandler = new JVEditorStateHandler(this, _dataHandler);
		this.staticUiController.rootView.addSubview(new JVEditorMainView(_dataHandler, _stateHandler));

		this.loadPatternForDisplay(_dataHandler.patterns[0]);
	}

	override public function update():Void
	{
		super.update();
	}

	override public function render():Void
	{
		super.render();
		var gfx = HXP.scene.getSpriteByLayer(9999).graphics;
		gfx.beginFill(0x700000, 1.0);
		gfx.drawRect(JVEditorConstants.EDITOR_PREVIEW_SPACE_OFFSET_X, JVEditorConstants.EDITOR_PREVIEW_SPACE_OFFSET_Y, JVConstants.PLAY_SPACE_WIDTH, JVConstants.PLAY_SPACE_HEIGHT);
	}
	
	
	/*
	 * UI Callbacks
	 */
	public function toggleGridVisibility(visible:Bool):Void
	{
		for (i in 0..._grid.length)
		{
			_grid[i].visible = visible;
		}
	}
	
	public function loadPatternForDisplay(pattern:JVEnemyPattern):Void
	{
		// Clean up display data from previous pattern
		for (i in 0..._grid.length)
		{
			this.remove(_grid[i]);
		}
		for (i in 0..._keyFrameLocationEntities.length)
		{
			this.remove(_keyFrameLocationEntities[i]);
		}
		_grid.splice(0, _grid.length);
		_keyFrameLocationEntities.splice(0, _keyFrameLocationEntities.length);
		
		// Gather data for this pattern
		var columns:Int = pattern.gridColumns;
		var rows:Int = pattern.gridRows;
		var columnWidth:Int = cast(pattern.totalWidth / columns);
		var rowHeight:Int = cast(pattern.totalHeight / rows);
		//var gridSpaceImage:Image = new Image("gfx/editor/editor_grid_space.png");
		//gridSpaceImage.scaledWidth = columnWidth;
		//gridSpaceImage.scaledHeight = rowHeight;
		
		var initialPoint:Point = getInitialGridPoint(pattern);
		var initialX:Int = cast initialPoint.x;
		var initialY:Int = cast initialPoint.y;
		
		// Setup the grid
		for (x in 0...columns)
		{
			for (y in 0...rows)
			{
				//var entity:Entity = new Entity(initialX + x * gridSpaceImage.scaledWidth, 
											   //initialY + y * gridSpaceImage.scaledHeight, 
											   //gridSpaceImage);
				var entity:Entity = new JVEditorGridSpaceEntity(initialX + x * columnWidth, 
																initialY + y * rowHeight,
																columnWidth,
																rowHeight);
				this.add(entity);
				_grid.push(entity);
			}
		}
		
		// Setup the keyframe location images
		var shipLocationImage:Image = new Image("gfx/editor/editor_key_frame_location.png");
		if (columnWidth < rowHeight)
		{
			shipLocationImage.scaledWidth = columnWidth - 4;
			shipLocationImage.scaledHeight = columnWidth - 4;
		}
		else
		{
			shipLocationImage.scaledWidth = rowHeight - 4;
			shipLocationImage.scaledHeight = rowHeight - 4;
		}
		shipLocationImage.centerOrigin();
		
		for (i in 0...pattern.keyFramePositions.length)
		{
			var keyframesForShip:Array<Point> = pattern.keyFramePositions[i];
			
			for (j in 0...keyframesForShip.length)
			{
				var keyframe:Point = keyframesForShip[j];
				var gridSpaceEntity:Entity = this.gridSpaceEntityForLocation(cast keyframe.x, cast keyframe.y);
				var keyFrameLocationEntity:JVEntity = new JVEntity();
				keyFrameLocationEntity.x = gridSpaceEntity.x + (columnWidth / 2);
				keyFrameLocationEntity.y = gridSpaceEntity.y + (rowHeight / 2);
				keyFrameLocationEntity.graphic = shipLocationImage;
				keyFrameLocationEntity.components.push(new JVEditorKeyFrameLocationComponent(keyFrameLocationEntity, _stateHandler, i, j));
				keyFrameLocationEntity.type = "key_frame_location";
				this.add(keyFrameLocationEntity);
				_keyFrameLocationEntities.push(keyFrameLocationEntity);
			}
		}
	}
	
	public function gridSpaceEntityForLocation(x:Int, y:Int):Entity
	{
		var currentPattern:JVEnemyPattern = _dataHandler.patterns[_stateHandler.currentPatternIndex];
		return _grid[(x * currentPattern.gridRows) + y];
	}

	/**
	 * Private
	 */
	private var _stateHandler:JVEditorStateHandler;
	private var _dataHandler:JVEditorDataHandler;
	private var _grid:Array<Entity>;
	private var _keyFrameLocationEntities:Array<Entity>;
	
	private function getInitialGridPoint(pattern:JVEnemyPattern):Point
	{
		var x:Float = JVEditorConstants.EDITOR_PREVIEW_SPACE_OFFSET_X;
		var y:Float = JVEditorConstants.EDITOR_PREVIEW_SPACE_OFFSET_Y;
		
		if (pattern.spawnAnchor == EXTOffsetType.CENTER)
		{
			x += (JVConstants.PLAY_SPACE_WIDTH / 2) - (pattern.totalWidth / 2);
			y += (JVConstants.PLAY_SPACE_HEIGHT / 2) - (pattern.totalHeight / 2);
		}
		else if (pattern.spawnAnchor == EXTOffsetType.TOP_LEFT)
		{
			// No x change
			// No y change
		}
		else if (pattern.spawnAnchor == EXTOffsetType.TOP_CENTER)
		{
			x += (JVConstants.PLAY_SPACE_WIDTH / 2) - (pattern.totalWidth / 2);
			// No y change
		}
		else if (pattern.spawnAnchor == EXTOffsetType.TOP_RIGHT)
		{
			x += JVConstants.PLAY_SPACE_WIDTH - pattern.totalWidth;
			// No y change
		}
		else if (pattern.spawnAnchor == EXTOffsetType.BOTTOM_LEFT)
		{
			// No x change
			y += JVConstants.PLAY_SPACE_HEIGHT - pattern.totalHeight;
		}
		else if (pattern.spawnAnchor == EXTOffsetType.BOTTOM_CENTER)
		{
			x += (JVConstants.PLAY_SPACE_WIDTH / 2) - (pattern.totalWidth / 2);
			y += JVConstants.PLAY_SPACE_HEIGHT - pattern.totalHeight;
		}
		else if (pattern.spawnAnchor == EXTOffsetType.BOTTOM_RIGHT)
		{
			x += JVConstants.PLAY_SPACE_WIDTH - pattern.totalWidth;
			y += JVConstants.PLAY_SPACE_HEIGHT - pattern.totalHeight;
		}
		
		return new Point(x, y);
	}
}
