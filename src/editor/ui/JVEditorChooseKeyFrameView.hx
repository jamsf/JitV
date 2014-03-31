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
 * Created by Fletcher, 3/30/2014
 */
class JVEditorChooseKeyFrameView extends JVExampleDialog
{
	public function new(pattern:JVEnemyPattern, updateKeyFrameCallback:Int->Void)
	{
		super(EXTUtility.ZERO_POINT, new Point(600, 400));

		_updateKeyFrameCallback = updateKeyFrameCallback;

		if (pattern != null && pattern.keyFrameCount > 0)
		{
			var x:Int = 20;
			var y:Int = 20;
			
			var deselectKeyFramesButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(x, y), "show all", keyFrameButtonCallback, [ -1]);
			deselectKeyFramesButton.offsetAlignmentInParent = EXTOffsetType.TOP_LEFT;
			deselectKeyFramesButton.offsetAlignmentForSelf = EXTOffsetType.TOP_LEFT;
			this.addSubview(deselectKeyFramesButton);
			
			y += 40;
			
			for (i in 0...pattern.keyFrameCount)
			{
				var keyFrameButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(x, y), "frame" + i, keyFrameButtonCallback, [i]);
				keyFrameButton.offsetAlignmentInParent = EXTOffsetType.TOP_LEFT;
				keyFrameButton.offsetAlignmentForSelf = EXTOffsetType.TOP_LEFT;
				this.addSubview(keyFrameButton);
				
				y += 40;
				
				if (y > 380)
				{
					x += 80;
					y = 20;
				}
			}
		}
	}

	public function keyFrameButtonCallback(args:Array<Dynamic>):Void
	{
		_updateKeyFrameCallback(args[0]);
	}

	/**
	 * Private
	 */
	private var _updateKeyFrameCallback:Int->Void;
}
