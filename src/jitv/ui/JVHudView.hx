package jitv.ui;

import flash.geom.Point;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import extendedhxpunk.ui.UIView;
import extendedhxpunk.ui.UIImageView;
import extendedhxpunk.ui.UILabel;
import extendedhxpunk.ext.EXTUtility;
import extendedhxpunk.ext.EXTOffsetType;
import extendedhxpunk.ext.EXTCamera;
import jitv.scenes.JVSceneManager;
import jitv.JVGlobals;

/**
 * JVHudView
 * The standard in-game HUD.
 * Created by Fletcher 11/3/13
 */
class JVHudView extends UIView
{
	public function new(camera:EXTCamera) 
	{
		super(EXTUtility.ZERO_POINT, new Point(HXP.screen.width, HXP.screen.height));
		
		_camera = camera;
		
		var backButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(10 + JVGlobals.PLAY_SPACE_OFFSET.x, 10), "abort level", backButtonCallback);
		backButton.offsetAlignmentForSelf = EXTOffsetType.TOP_LEFT;
		backButton.offsetAlignmentInParent = EXTOffsetType.TOP_LEFT;
		
		var zoomInButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(-10 - JVGlobals.PLAY_SPACE_OFFSET.x, 10), "zoom in", zoomInButtonCallback);
		zoomInButton.offsetAlignmentForSelf = EXTOffsetType.TOP_RIGHT;
		zoomInButton.offsetAlignmentInParent = EXTOffsetType.TOP_RIGHT;
		
		var zoomOutButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(-10 - JVGlobals.PLAY_SPACE_OFFSET.x, 50), "zoom out", zoomOutButtonCallback);
		zoomOutButton.offsetAlignmentForSelf = EXTOffsetType.TOP_RIGHT;
		zoomOutButton.offsetAlignmentInParent = EXTOffsetType.TOP_RIGHT;
		
		var livesIcon:Image = new Image("gfx/ui/player_life_icon.png");
		var livesDisplay:UIImageView = new UIImageView(new Point(-45 - JVGlobals.PLAY_SPACE_OFFSET.x, 90), livesIcon);
		livesDisplay.offsetAlignmentForSelf = EXTOffsetType.TOP_RIGHT;
		livesDisplay.offsetAlignmentInParent = EXTOffsetType.TOP_RIGHT;
		
		var livesPointSize:Int = cast (16 * JVGlobals.TOTAL_GAME_SCALE);
		_livesCount = new UILabel(new Point(-10 - JVGlobals.PLAY_SPACE_OFFSET.x, 90), new Text("x 5", 0, 0, { "size" : livesPointSize }));
		_livesCount.offsetAlignmentForSelf = EXTOffsetType.TOP_RIGHT;
		_livesCount.offsetAlignmentInParent = EXTOffsetType.TOP_RIGHT;
		
		this.addSubview(backButton);
		this.addSubview(zoomInButton);
		this.addSubview(zoomOutButton);
		this.addSubview(livesDisplay);
		this.addSubview(_livesCount);
	}
	
	public function backButtonCallback(args:Array<Dynamic>):Void
	{
		JVSceneManager.sharedInstance().goToLevelSelectScene();
	}
	
	public function zoomInButtonCallback(args:Array<Dynamic>):Void
	{
		_camera.zoomWithAnchor(0.1, EXTUtility.ZERO_POINT, EXTOffsetType.CENTER);
	}
	
	public function zoomOutButtonCallback(args:Array<Dynamic>):Void
	{
		_camera.zoomWithAnchor(-0.1, EXTUtility.ZERO_POINT, EXTOffsetType.CENTER);
	}
	
	public function updateLivesCount(lives:Int):Void
	{
		_livesCount.text.text = "x " + lives;
	}
	
	/**
	 * Private
	 */
	private var _camera:EXTCamera;
	private var _livesCount:UILabel;
}
