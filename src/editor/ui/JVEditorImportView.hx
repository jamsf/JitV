package editor.ui;

import flash.geom.Point;
import extendedhxpunk.ui.UIView;
import extendedhxpunk.ext.EXTUtility;
import extendedhxpunk.ext.EXTOffsetType;
import editor.JVEditorDataHandler;
import jitv.datamodel.staticdata.JVEnemyPattern;
import jitv.ui.JVExampleDialog;
import jitv.ui.JVExampleMenuButton;

/**
 * ...
 * Created by Fletcher, 3/2/2014
 */
class JVEditorImportView extends JVExampleDialog
{
	public function new(dataHandler:JVEditorDataHandler, updatePatternCallback:Array<Dynamic>->Void)
	{
		super(EXTUtility.ZERO_POINT, new Point(600, 400));

		_dataHandler = dataHandler;
		_updatePatternCallback = updatePatternCallback;

		if (_dataHandler.patterns != null)
		{
			var x:Int = 20;
			var y:Int = 20;
			for (i in 0..._dataHandler.patterns.length)
			{
				var pattern:JVEnemyPattern = _dataHandler.patterns[i];
				var patternButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(x, y), pattern.name, patternButtonCallback, [pattern]);
				patternButton.offsetAlignmentInParent = EXTOffsetType.TOP_LEFT;
				patternButton.offsetAlignmentForSelf = EXTOffsetType.TOP_LEFT;
				this.addSubview(patternButton);
				
				y += 40;

				if (y > 380)
				{
					x += 80;
					y = 20;
				}
			}
		}
	}

	public function patternButtonCallback(args:Array<Dynamic>):Void
	{
		_updatePatternCallback(args);
	}

	/**
	 * Private
	 */
	private var _dataHandler:JVEditorDataHandler;
	private var _updatePatternCallback:Array<Dynamic>->Void;
}
