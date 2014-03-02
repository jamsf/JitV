package editor.ui;

import flash.geom.Point;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import extendedhxpunk.ui.UIView;
import extendedhxpunk.ui.UIImageView;
import extendedhxpunk.ext.EXTOffsetType;
import extendedhxpunk.ext.EXTUtility;
import jitv.datamodel.staticdata.JVEnemyPattern;
import jitv.ui.JVExampleMenuButton;
import jitv.scenes.JVSceneManager;
import jitv.JVConstants;
import editor.JVEditorDataHandler;

class JVEditorMainView extends UIView
{
	public function new(dataHandler:JVEditorDataHandler, updatePatternCallback:Int->Void = null)
	{
		super(EXTUtility.ZERO_POINT, new Point(HXP.screen.width, HXP.screen.height));
		
		_dataHandler = dataHandler;
		_updatePatternCallback = updatePatternCallback;
		
		var sidePanelView:UIView = new UIView(EXTUtility.ZERO_POINT, new Point(150, HXP.screen.height));
		sidePanelView.offsetAlignmentInParent = EXTOffsetType.TOP_LEFT;
		sidePanelView.offsetAlignmentForSelf = EXTOffsetType.TOP_LEFT;
		sidePanelView.backgroundColor.setColor(0.7, 0.5, 0.4, 1.0);
		
		var exitButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(0, -10), "exit editor", exitButtonCallback, null);
		exitButton.offsetAlignmentInParent = EXTOffsetType.BOTTOM_CENTER;
		exitButton.offsetAlignmentForSelf = EXTOffsetType.BOTTOM_CENTER;
		
		var importButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(0, 10), "import", importButtonCallback, null);
		importButton.offsetAlignmentInParent = EXTOffsetType.TOP_CENTER;
		importButton.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
		
		var exportButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(0, 50), "export", exportButtonCallback, null);
		exportButton.offsetAlignmentInParent = EXTOffsetType.TOP_CENTER;
		exportButton.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
		
		var previewButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(0, 90), "preview", previewButtonCallback, null);
		previewButton.offsetAlignmentInParent = EXTOffsetType.TOP_CENTER;
		previewButton.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
		
		var keyframeButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(0, 130), "+keyframe", keyframeButtonCallback, null);
		keyframeButton.offsetAlignmentInParent = EXTOffsetType.TOP_CENTER;
		keyframeButton.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
		
		var sideImageVertical:Image = new Image("gfx/ui/speech_bubble_side_vertical_8x8.png");
		sideImageVertical.scaledHeight = HXP.screen.height;
		var rightBoundsImageView:UIImageView = new UIImageView(EXTUtility.ZERO_POINT, sideImageVertical);
		rightBoundsImageView.offsetAlignmentInParent = EXTOffsetType.RIGHT_CENTER;
		rightBoundsImageView.offsetAlignmentForSelf = EXTOffsetType.CENTER;
		
		sidePanelView.addSubview(rightBoundsImageView);
		sidePanelView.addSubview(exitButton);
		sidePanelView.addSubview(previewButton);
		sidePanelView.addSubview(importButton);
		sidePanelView.addSubview(exportButton);
		sidePanelView.addSubview(keyframeButton);
		
		if (_dataHandler.patterns != null)
		{
			var y:Int = 170;
			for (i in 0..._dataHandler.patterns.length)
			{
				var pattern:JVEnemyPattern = _dataHandler.patterns[i];
				var patternButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(0, y), pattern.name, patternButtonCallback, [pattern]);
				patternButton.offsetAlignmentInParent = EXTOffsetType.TOP_CENTER;
				patternButton.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
				sidePanelView.addSubview(patternButton);
				
				y += 40;
			}
		}
		
		this.addSubview(sidePanelView);
	}
	
	public function importButtonCallback(args:Array<Dynamic>):Void
	{
		
	}
	
	public function exportButtonCallback(args:Array<Dynamic>):Void
	{
		_dataHandler.writePatternDataToDisk();
	}
	
	public function keyframeButtonCallback(args:Array<Dynamic>):Void
	{
		
	}
	
	public function previewButtonCallback(args:Array<Dynamic>):Void
	{
		
	}
	
	public function exitButtonCallback(args:Array<Dynamic>):Void
	{
		HXP.resizeStage(JVConstants.PLAY_SPACE_WIDTH, JVConstants.PLAY_SPACE_HEIGHT);
		JVSceneManager.sharedInstance().goToMainMenuScene();
	}
	
	public function patternButtonCallback(args:Array<Dynamic>):Void
	{
		var pattern:JVEnemyPattern = args[0];
		_updatePatternCallback(pattern.id);
	}
	
	/**
	 * Private
	 */
	private var _dataHandler:JVEditorDataHandler;
	private var _updatePatternCallback:Int->Void;
}
