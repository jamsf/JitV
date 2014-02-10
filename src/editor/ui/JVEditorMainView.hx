package editor.ui;

import flash.geom.Point;
import com.haxepunk.*;
import extendedhxpunk.ui.*;
import extendedhxpunk.ext.*;
import jitv.ui.*;
import jitv.scenes.JVSceneManager;

class JVEditorMainView extends UIView
{
	public function new()
	{
		super(EXTUtility.ZERO_POINT, new Point(HXP.screen.width, HXP.screen.height));
		var exitButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(10, 10), "exit editor", exitButtonCallback, null);
		exitButton.offsetAlignmentInParent = EXTOffsetType.TOP_LEFT;
		exitButton.offsetAlignmentForSelf = EXTOffsetType.TOP_LEFT;
		this.addSubview(exitButton);
	}

	public function exitButtonCallback(args:Array<Dynamic>):Void
	{
		JVSceneManager.sharedInstance().goToMainMenuScene();
	}
}
