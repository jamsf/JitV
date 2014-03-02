package editor;

import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import extendedhxpunk.ext.EXTScene;
import jitv.datamodel.staticdata.JVEnemyPattern;
import editor.ui.JVEditorMainView;

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
		_dataHandler = new JVEditorDataHandler("./jsondata/" + JVEnemyPattern.DATA_TYPE_NAME + ".json");
		_dataHandler.loadPatternDataFromDisk();
		this.staticUiController.rootView.addSubview(new JVEditorMainView(_dataHandler, updatePatternDisplay));

		this.updatePatternDisplay(0);
	}

	override public function update():Void
	{
		super.update();
	}

	override public function render():Void
	{
		super.render();
	}
	
	public function updatePatternDisplay(patternIndex:Int):Void
	{
		_currentPatternIndex = patternIndex;
		var pattern:JVEnemyPattern = _dataHandler.patterns[_currentPatternIndex];

		for (i in 0..._grid.length)
		{
			this.remove(_grid[i]);
		}
		_grid.splice(0, _grid.length);

		var columns:Int = pattern.gridColumns;
		var rows:Int = pattern.gridRows;
		var image:Image = new Image("gfx/editor/editor_grid_space.png");
		image.scaledWidth = pattern.totalWidth / columns;// * 0.75;
		image.scaledHeight = pattern.totalHeight / rows;// * 0.75;

		for (x in 0...columns)
		{
			for (y in 0...rows)
			{
				var entity:Entity = new Entity(175 + x * image.scaledWidth, 50 + y * image.scaledHeight, image);
				this.add(entity);
				_grid.push(entity);
			}
		}
	}

	/**
	 * Private
	 */
	private var _dataHandler:JVEditorDataHandler;
	private var _currentPatternIndex:Int;
	private var _grid:Array<Entity>;
}
