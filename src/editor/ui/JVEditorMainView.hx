package editor.ui;

import flash.geom.Point;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import extendedhxpunk.ui.UIView;
import extendedhxpunk.ui.UIImageView;
import extendedhxpunk.ext.EXTOffsetType;
import extendedhxpunk.ext.EXTUtility;
import jitv.ui.JVExampleMenuButton;
import jitv.scenes.JVSceneManager;
import jitv.JVConstants;

class JVEditorMainView extends UIView
{
	public function new()
	{
		super(EXTUtility.ZERO_POINT, new Point(HXP.screen.width, HXP.screen.height));
		
		var sidePanelView:UIView = new UIView(EXTUtility.ZERO_POINT, new Point(170, HXP.screen.height));
		sidePanelView.offsetAlignmentInParent = EXTOffsetType.TOP_LEFT;
		sidePanelView.offsetAlignmentForSelf = EXTOffsetType.TOP_LEFT;
		sidePanelView.backgroundColor.setColor(0.0, 0.0, 0.0, 0.8);
		
		var exitButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(0, -10), "exit editor", exitButtonCallback, null);
		exitButton.offsetAlignmentInParent = EXTOffsetType.BOTTOM_CENTER;
		exitButton.offsetAlignmentForSelf = EXTOffsetType.BOTTOM_CENTER;
		
		var importButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(0, 10), "import", importButtonCallback, null);
		importButton.offsetAlignmentInParent = EXTOffsetType.TOP_CENTER;
		importButton.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
		
		var exportButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(0, 60), "export", exportButtonCallback, null);
		exportButton.offsetAlignmentInParent = EXTOffsetType.TOP_CENTER;
		exportButton.offsetAlignmentForSelf = EXTOffsetType.TOP_CENTER;
		
		var sideImageVertical:Image = new Image("gfx/ui/speech_bubble_side_vertical_8x8.png");
		sideImageVertical.scaledHeight = HXP.screen.height;
		var rightBoundsImageView:UIImageView = new UIImageView(EXTUtility.ZERO_POINT, sideImageVertical);
		rightBoundsImageView.offsetAlignmentInParent = EXTOffsetType.RIGHT_CENTER;
		rightBoundsImageView.offsetAlignmentForSelf = EXTOffsetType.CENTER;
		
		sidePanelView.addSubview(rightBoundsImageView);
		sidePanelView.addSubview(exitButton);
		sidePanelView.addSubview(importButton);
		sidePanelView.addSubview(exportButton);
		this.addSubview(sidePanelView);
	}
	
	public function importButtonCallback(args:Array<Dynamic>):Void
	{
		
	}
	
	public function exportButtonCallback(args:Array<Dynamic>):Void
	{
		
	}
	
	public function exitButtonCallback(args:Array<Dynamic>):Void
	{
		HXP.resizeStage(JVConstants.PLAY_SPACE_WIDTH, JVConstants.PLAY_SPACE_HEIGHT);
		JVSceneManager.sharedInstance().goToMainMenuScene();
	}
}
