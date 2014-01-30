package jitv.scenes;

import flash.geom.Point;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import extendedhxpunk.ext.EXTScene;
import extendedhxpunk.ext.EXTOffsetType;
import extendedhxpunk.ext.EXTUtility;
import extendedhxpunk.ui.*;
import jitv.ui.JVExampleDialog;
import jitv.ui.JVExampleMenuButton;
import jitv.scenes.JVSceneManager;

/**
 * JVButtonSelectScene
 * Game scene for navigation of the main menu
 * Created by Gerrit 1/29/201, Ported by Gerrit
 */
class JVButtonSelectScene extends EXTScene
{

	public function new() 
	{
		super();
	}
	
		override public function begin():Void
	{
		super.begin();
		
		// Background Image
		var screenSize:Point = this.worldCamera.currentViewSize();
		var backgroundImage:Image = new Image("gfx/backgrounds/temp_buttons_backgroud.png");
		backgroundImage.x = screenSize.x / 2;
		backgroundImage.y = screenSize.y / 2;
		backgroundImage.centerOrigin();
		this.addGraphic(backgroundImage);
		
		// UI
		var titleDialog:JVExampleDialog = new JVExampleDialog(new Point(0, -120), new Point(250, 60));
		titleDialog.offsetAlignmentForSelf = EXTOffsetType.BOTTOM_CENTER;
		var titleText:Text = new Text("Configure Buttons", 0, 0, { "size" : 19, "color" : 0xEEEEEE });
		var titleLabel:UILabel = new UILabel(EXTUtility.ZERO_POINT, titleText);
		titleDialog.addSubview(titleLabel);
		
		var menuDialog:JVExampleDialog = new JVExampleDialog(new Point(0, -115), new Point(600, 300));
		menuDialog.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
		
		// Back button
		_backButton = new JVExampleMenuButton(new Point(-10, -10), "back", backButtonCallback);
		_backButton.offsetAlignmentForSelf = EXTOffsetType.BOTTOM_RIGHT;
		_backButton.offsetAlignmentInParent = EXTOffsetType.BOTTOM_RIGHT;
		menuDialog.addSubview(_backButton);
		
		this.staticUiController.rootView.addSubview(titleDialog);
		this.staticUiController.rootView.addSubview(menuDialog);
	}
	
	public function backButtonCallback(args:Array<Dynamic>):Void
	{
		JVSceneManager.sharedInstance().goToMainMenuScene();
	}
	
	 /**
	 * Private
	 */
	private var _backButton:JVExampleMenuButton;
}