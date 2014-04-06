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
import editor.JVEditorStateHandler;

class JVEditorMainView extends UIView
{
	public function new(dataHandler:JVEditorDataHandler, stateHandler:JVEditorStateHandler)
	{
		super(EXTUtility.ZERO_POINT, new Point(HXP.screen.width, HXP.screen.height));
		
		_dataHandler = dataHandler;
		_stateHandler = stateHandler;
		
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
		
		var gridVisibilityButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(0, 170), "toggle grid", gridVisibilityButtonCallback, null);
		gridVisibilityButton.offsetAlignmentInParent = EXTOffsetType.TOP_CENTER;
		gridVisibilityButton.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
		
		var chooseShipButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(0, 210), "pick ship", chooseShipButtonCallback, null);
		chooseShipButton.offsetAlignmentInParent = EXTOffsetType.TOP_CENTER;
		chooseShipButton.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
		
		var chooseKeyFrameButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(0, 250), "pick frame", chooseKeyFrameButtonCallback, null);
		chooseKeyFrameButton.offsetAlignmentInParent = EXTOffsetType.TOP_CENTER;
		chooseKeyFrameButton.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
		
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
		sidePanelView.addSubview(gridVisibilityButton);
		sidePanelView.addSubview(chooseShipButton);
		sidePanelView.addSubview(chooseKeyFrameButton);
		
		this.addSubview(sidePanelView);
	}
	
	public function importButtonCallback(args:Array<Dynamic>):Void
	{
		_importView = new JVEditorImportView(_dataHandler, patternButtonCallback);
		this.addSubview(_importView);
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
		_stateHandler.currentPatternIndex = pattern.id;
		_stateHandler.currentShipIndex = -1;
		_stateHandler.currentKeyFrameIndex = -1;
		_stateHandler.gridVisible = true;
		this.removeSubview(_importView);
		_importView = null;
	}
	
	public function gridVisibilityButtonCallback(args:Array<Dynamic>):Void
	{
		_stateHandler.gridVisible = !_stateHandler.gridVisible;
	}
	
	public function chooseShipButtonCallback(args:Array<Dynamic>):Void
	{
		
	}
	
	public function chooseKeyFrameButtonCallback(args:Array<Dynamic>):Void
	{
		_chooseKeyFrameView = new JVEditorChooseKeyFrameView(_dataHandler.patterns[_stateHandler.currentPatternIndex], updateKeyFrameCallback);
		this.addSubview(_chooseKeyFrameView);
	}
	
	public function updateKeyFrameCallback(keyFrameIndex:Int):Void
	{
		_stateHandler.currentKeyFrameIndex = keyFrameIndex;
		this.removeSubview(_chooseKeyFrameView);
		_chooseKeyFrameView = null;
	}
	
	
	/**
	 * Private
	 */
	private var _stateHandler:JVEditorStateHandler;
	private var _dataHandler:JVEditorDataHandler;
	private var _importView:JVEditorImportView;
	private var _chooseKeyFrameView:JVEditorChooseKeyFrameView;
}
