package editor;

import com.haxepunk.HXP;
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
		
		_dataHandler = new JVEditorDataHandler("./jsondata/" + JVEnemyPattern.DATA_TYPE_NAME + ".json");
		_dataHandler.loadPatternDataFromDisk();
		this.staticUiController.rootView.addSubview(new JVEditorMainView(_dataHandler));
	}

	override public function update():Void
	{
		super.update();
	}

	override public function render():Void
	{
		super.render();
	}
	
	/**
	 * Private
	 */
	private var _dataHandler:JVEditorDataHandler;
}
