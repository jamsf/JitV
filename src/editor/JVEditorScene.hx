package editor;

import com.haxepunk.*;
import extendedhxpunk.ui.*;
import extendedhxpunk.ext.*;
import editor.ui.*;

class JVEditorScene extends EXTScene
{
	public function new()
	{
		HXP.resizeStage(1000, 600);
		super();
	}

	override public function begin():Void
	{
		super.begin();
		
		this.staticUiController.rootView.addSubview(new JVEditorMainView());
	}

	override public function update():Void
	{
		super.update();
	}

	override public function render():Void
	{
		super.render();
	}
}
