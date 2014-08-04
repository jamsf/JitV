package jitv.scenes;

import flash.system.Capabilities;
import flash.geom.Point;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import extendedhxpunk.ext.EXTScene;
import extendedhxpunk.ext.EXTOffsetType;
import extendedhxpunk.ext.EXTUtility;
import extendedhxpunk.ui.*;
import jitv.ui.JVExampleDialog;
import jitv.ui.JVExampleMenuButton;
import jitv.scenes.JVSceneManager;
import jitv.local.JVLocalData;
import jitv.local.JVColorPalette;
import jitv.JVGlobals;

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
		//var backgroundImage:Image = new Image("gfx/backgrounds/menu_background_1.png");
		//backgroundImage.x = screenSize.x / 2;
		//backgroundImage.y = screenSize.y / 2;
		//backgroundImage.centerOrigin();
		
		var backgroundImage:Image = new Image("gfx/entities/particle_entity.png");
		backgroundImage.scaledWidth = screenSize.x;
		backgroundImage.scaledHeight = screenSize.y;
		backgroundImage.color = JVLocalData.sharedInstance().currentColorPalette.colorForIndex(JVColorPalette.INDEX_BACKGROUND_1).webColor;
		
		this.addGraphic(backgroundImage);
		
		// UI
		//var titleDialog:JVExampleDialog = new JVExampleDialog(new Point(0, -80), new Point(250, 60));
		var titleDialog:UIView = new UIView(new Point(0, -80), new Point(250, 60));
		titleDialog.offsetAlignmentForSelf = EXTOffsetType.BOTTOM_CENTER;
		var titleColor:UInt = JVLocalData.sharedInstance().currentColorPalette.colorForIndex(JVColorPalette.INDEX_BACKGROUND_2).webColor;
		var titlePointSize:Int = cast (24 * JVGlobals.TOTAL_GAME_SCALE);
		var titleText:Text = new Text("JOURNEY INTO THE VOID", 0, 0, { "size" : titlePointSize, "color" : titleColor });
		var titleLabel:UILabel = new UILabel(EXTUtility.ZERO_POINT, titleText);
		titleDialog.addSubview(titleLabel);
		
		//var menuDialog:JVExampleDialog = new JVExampleDialog(new Point(0, -80), new Point(200, 220));
		var menuDialog:UIView = new UIView(new Point(0, -80), new Point(200, 220));
		menuDialog.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
		
		// Toggle button
		//_toggleButton = new JVExampleMenuButton(new Point(0, 35), "toggle", toggleButtonCallback);
		//_toggleButton.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
		//_toggleButton.offsetAlignmentInParent = EXTOffsetType.TOP_CENTER;
		//_toggleButton.selectable = true;
		//menuDialog.addSubview(_toggleButton);
		
		// Play button
		_playButton = new JVExampleMenuButton(new Point(0, 35), "NEW GAME", playButtonCallback);
		_playButton.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
		_playButton.offsetAlignmentInParent = EXTOffsetType.TOP_CENTER;
		//_playButton.enabled = false;
		menuDialog.addSubview(_playButton);
		
		// Configure button
		//_configureButton = new JVExampleMenuButton(new Point(0, _playButton.position.y + _playButton.size.y + 15), "configure", configureButtonCallback);
		//_configureButton.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
		//_configureButton.offsetAlignmentInParent = EXTOffsetType.TOP_CENTER;
		//menuDialog.addSubview(_configureButton);
		
		// Fullscreen button
#if !flash
		var fullscreenButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(0, _playButton.position.y + _playButton.size.y + 15), "FULLSCREEN", fullscreenButtonCallback);
		fullscreenButton.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
		fullscreenButton.offsetAlignmentInParent = EXTOffsetType.TOP_CENTER;
		fullscreenButton.selected = HXP.fullscreen;
		menuDialog.addSubview(fullscreenButton);

		// Editor button
		var editorButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(0, fullscreenButton.position.y + fullscreenButton.size.y + 15), "EDITOR", editorButtonCallback);
		editorButton.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
		editorButton.offsetAlignmentInParent = EXTOffsetType.TOP_CENTER;
		editorButton.enabled = !HXP.fullscreen;
		menuDialog.addSubview(editorButton);
#end
		
		this.staticUiController.rootView.addSubview(titleDialog);
		this.staticUiController.rootView.addSubview(menuDialog);
	}
	
	//public function toggleButtonCallback(args:Array<Dynamic>):Void
	//{
		//_playButton.enabled = !_playButton.enabled;
	//}
	
	public function playButtonCallback(args:Array<Dynamic>):Void
	{
		JVSceneManager.sharedInstance().goToLevelSelectScene();
	}
	
	public function configureButtonCallback(args:Array<Dynamic>):Void
	{
		JVSceneManager.sharedInstance().goToButonSelectScene();
	}
	
	public function fullscreenButtonCallback(args:Array<Dynamic>):Void
	{
		if (HXP.fullscreen)
			goWindowed();
		else
			goFullscreen();
		
		JVSceneManager.sharedInstance().goToMainMenuScene();
	}

	public function editorButtonCallback(args:Array<Dynamic>):Void
	{
		JVSceneManager.sharedInstance().goToEditorScene();
	}
	
	/**
	 * Private
	 */
	//private var _toggleButton:JVExampleMenuButton;
	private var _playButton:JVExampleMenuButton;
	private var _configureButton:JVExampleMenuButton;
	
	private function goFullscreen():Void
	{
		var widthRatio:Float = Capabilities.screenResolutionX / JVConstants.PLAY_SPACE_WIDTH;
		var heightRatio:Float = Capabilities.screenResolutionY / JVConstants.PLAY_SPACE_HEIGHT;
		
		if (heightRatio > widthRatio)
		{
			// We need black bars on top and bottom
			JVGlobals.TOTAL_GAME_WIDTH = JVConstants.PLAY_SPACE_WIDTH;
			JVGlobals.TOTAL_GAME_HEIGHT = cast (JVConstants.PLAY_SPACE_HEIGHT * heightRatio / widthRatio);
#if !flash
			JVGlobals.TOTAL_GAME_SCALE = widthRatio;
#end
			HXP.resize(JVConstants.PLAY_SPACE_WIDTH, JVGlobals.TOTAL_GAME_HEIGHT);
		}
		else if (widthRatio > heightRatio)
		{
			// We need black bars on the left and right
			JVGlobals.TOTAL_GAME_WIDTH = cast (JVConstants.PLAY_SPACE_WIDTH * widthRatio / heightRatio);
			JVGlobals.TOTAL_GAME_HEIGHT = JVConstants.PLAY_SPACE_HEIGHT;
#if !flash
			JVGlobals.TOTAL_GAME_SCALE = heightRatio;
#end
			HXP.resize(JVGlobals.TOTAL_GAME_WIDTH, JVConstants.PLAY_SPACE_HEIGHT);
		}
		else
		{
			// No black bars needed!
			JVGlobals.TOTAL_GAME_WIDTH = JVConstants.PLAY_SPACE_WIDTH;
			JVGlobals.TOTAL_GAME_HEIGHT = JVConstants.PLAY_SPACE_HEIGHT;
#if !flash
			JVGlobals.TOTAL_GAME_SCALE = widthRatio;
#end
			HXP.resize(JVConstants.PLAY_SPACE_WIDTH, JVConstants.PLAY_SPACE_HEIGHT);
		}
		
		JVGlobals.PLAY_SPACE_OFFSET = new Point((JVGlobals.TOTAL_GAME_WIDTH - JVConstants.PLAY_SPACE_WIDTH) / 2.0,
												(JVGlobals.TOTAL_GAME_HEIGHT - JVConstants.PLAY_SPACE_HEIGHT) / 2.0);
		HXP.fullscreen = true;
		HXP.screen.smoothing = true;
	}
	
	private function goWindowed():Void
	{
		JVGlobals.TOTAL_GAME_WIDTH = JVConstants.PLAY_SPACE_WIDTH;
		JVGlobals.TOTAL_GAME_HEIGHT = JVConstants.PLAY_SPACE_HEIGHT;
		JVGlobals.TOTAL_GAME_SCALE = 1.0;
		
		JVGlobals.PLAY_SPACE_OFFSET = new Point((JVGlobals.TOTAL_GAME_WIDTH - JVConstants.PLAY_SPACE_WIDTH) / 2.0,
												(JVGlobals.TOTAL_GAME_HEIGHT - JVConstants.PLAY_SPACE_HEIGHT) / 2.0);
		
		HXP.screen.smoothing = false;
		HXP.fullscreen = false;
		HXP.width = JVConstants.PLAY_SPACE_WIDTH;
		HXP.height = JVConstants.PLAY_SPACE_HEIGHT;
		HXP.screen.resize();
	}
}
