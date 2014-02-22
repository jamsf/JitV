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
 * Created by Gerrit 2/22/2014, Ported by Gerrit
 */
class JVCustomizeShipScene extends EXTScene
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
		var backgroundImage:Image = new Image("gfx/backgrounds/temp_ship_custom_background.png");
		backgroundImage.x = screenSize.x / 2;
		backgroundImage.y = screenSize.y / 2;
		backgroundImage.centerOrigin();
		this.addGraphic(backgroundImage);
		
		// UI
		var titleDialog:JVExampleDialog = new JVExampleDialog(new Point(0, -120), new Point(610, 60));
		titleDialog.offsetAlignmentForSelf = EXTOffsetType.BOTTOM_CENTER;
		var titleText:Text = new Text("Customize Ship", 0, 0, { "size" : 19, "color" : 0xEEEEEE });
		var titleLabel:UILabel = new UILabel(EXTUtility.ZERO_POINT, titleText);
		titleDialog.addSubview(titleLabel);
		
		var shipDialog:JVExampleDialog = new JVExampleDialog(new Point(-55, -115), new Point(500, 300));
		shipDialog.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
		var partDialog:JVExampleDialog = new JVExampleDialog(new Point(255, -115), new Point(100, 300));
		partDialog.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
		
		// Back button
		_backButton = new JVExampleMenuButton(new Point(-10, -10), "Finish", backButtonCallback);
		_backButton.offsetAlignmentForSelf = EXTOffsetType.BOTTOM_RIGHT;
		_backButton.offsetAlignmentInParent = EXTOffsetType.BOTTOM_RIGHT;
		shipDialog.addSubview(_backButton);
		
		this.staticUiController.rootView.addSubview(titleDialog);
		this.staticUiController.rootView.addSubview(shipDialog);
		this.staticUiController.rootView.addSubview(partDialog);
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