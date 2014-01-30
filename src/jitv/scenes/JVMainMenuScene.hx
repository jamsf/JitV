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
 * JVMainMenuScene
 * Game scene for navigation of the main menu
 * Created by Fletcher 11/3/2013, Ported by Fletcher 12/8/2013
 */
class JVMainMenuScene extends EXTScene
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
		var backgroundImage:Image = new Image("gfx/backgrounds/menu_background_1.png");
		backgroundImage.x = screenSize.x / 2;
		backgroundImage.y = screenSize.y / 2;
		backgroundImage.centerOrigin();
		this.addGraphic(backgroundImage);
		
		// UI
		var titleDialog:JVExampleDialog = new JVExampleDialog(new Point(0, -80), new Point(250, 60));
		titleDialog.offsetAlignmentForSelf = EXTOffsetType.BOTTOM_CENTER;
		var titleText:Text = new Text("Journey into the Void", 0, 0, { "size" : 19, "color" : 0xEEEEEE });
		var titleLabel:UILabel = new UILabel(EXTUtility.ZERO_POINT, titleText);
		titleDialog.addSubview(titleLabel);
		
		var menuDialog:JVExampleDialog = new JVExampleDialog(new Point(0, -80), new Point(200, 220));
		menuDialog.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
		
		// Toggle button
		_toggleButton = new JVExampleMenuButton(new Point(0, 35), "toggle", toggleButtonCallback);
		_toggleButton.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
		_toggleButton.offsetAlignmentInParent = EXTOffsetType.TOP_CENTER;
		_toggleButton.selectable = true;
		menuDialog.addSubview(_toggleButton);
		
		// Play button
		_playButton = new JVExampleMenuButton(new Point(0, _toggleButton.position.y + _toggleButton.size.y + 15), "play", playButtonCallback);
		_playButton.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
		_playButton.offsetAlignmentInParent = EXTOffsetType.TOP_CENTER;
		_playButton.enabled = false;
		menuDialog.addSubview(_playButton);
		
		// Configure button
		_configureButton = new JVExampleMenuButton(new Point(0, _playButton.position.y + _playButton.size.y + 15), "configure", configureButtonCallback);
		_configureButton.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
		_configureButton.offsetAlignmentInParent = EXTOffsetType.TOP_CENTER;
		menuDialog.addSubview(_configureButton);
		
		this.staticUiController.rootView.addSubview(titleDialog);
		this.staticUiController.rootView.addSubview(menuDialog);
	}
	
	public function toggleButtonCallback(args:Array<Dynamic>):Void
	{
		_playButton.enabled = !_playButton.enabled;
	}
	
	public function playButtonCallback(args:Array<Dynamic>):Void
	{
		JVSceneManager.sharedInstance().goToLevelSelectScene();
	}
	
	public function configureButtonCallback(args:Array<Dynamic>):Void
	{
		JVSceneManager.sharedInstance().goToButonSelectScene();
	}
	
	/**
	 * Private
	 */
	private var _toggleButton:JVExampleMenuButton;
	private var _playButton:JVExampleMenuButton;
	private var _configureButton:JVExampleMenuButton;
}
