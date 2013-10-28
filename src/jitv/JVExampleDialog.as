package jitv
{
	import flash.geom.Point;
	import net.flashpunk.graphics.Image;
	import net.extendedpunk.ext.EXTOffsetType;
	import net.extendedpunk.ext.EXTUtility;
	import net.extendedpunk.ui.UIImageView;
	import net.extendedpunk.ui.UIView;
	
	public class JVExampleDialog extends UIView
	{
		public function JVExampleDialog(position:Point, size:Point)
		{
			super(position, size);
			
			// Sides
			var sideImageHorizontal:Image = new Image (Assets.UI_SPEECH_BUBBLE_SIDE_HORIZONTAL);
			sideImageHorizontal.scaledWidth = size.x;
			var sideImageVertical:Image = new Image (Assets.UI_SPEECH_BUBBLE_SIDE_VERTICAL);
			sideImageVertical.scaledHeight = size.y;
			var topImageView:UIImageView = new UIImageView(EXTUtility.ZERO_POINT, sideImageHorizontal);
			topImageView.offsetAlignmentInParent = EXTOffsetType.TOP_CENTER;
			var rightImageView:UIImageView = new UIImageView(EXTUtility.ZERO_POINT, sideImageVertical);
			rightImageView.offsetAlignmentInParent = EXTOffsetType.RIGHT_CENTER;
			var botImageView:UIImageView = new UIImageView(EXTUtility.ZERO_POINT, sideImageHorizontal);
			botImageView.offsetAlignmentInParent = EXTOffsetType.BOTTOM_CENTER;
			var leftImageView:UIImageView = new UIImageView(EXTUtility.ZERO_POINT, sideImageVertical);
			leftImageView.offsetAlignmentInParent = EXTOffsetType.LEFT_CENTER;
			
			// Corners
			var cornerImage:Image = new Image(Assets.UI_SPEECH_BUBBLE_CORNER);
			var upLeftCornerImageView:UIImageView = new UIImageView(EXTUtility.ZERO_POINT, cornerImage);
			upLeftCornerImageView.offsetAlignmentInParent = EXTOffsetType.TOP_LEFT;
			var upRightCornerImageView:UIImageView = new UIImageView(EXTUtility.ZERO_POINT, cornerImage);
			upRightCornerImageView.offsetAlignmentInParent = EXTOffsetType.TOP_RIGHT;
			var botRightCornerImageView:UIImageView = new UIImageView(EXTUtility.ZERO_POINT, cornerImage);
			botRightCornerImageView.offsetAlignmentInParent = EXTOffsetType.BOTTOM_RIGHT;
			var botLeftCornerImageView:UIImageView = new UIImageView(EXTUtility.ZERO_POINT, cornerImage);
			botLeftCornerImageView.offsetAlignmentInParent = EXTOffsetType.BOTTOM_LEFT;
			
			// Set up the subviews
			this.backgroundColor.setColor(0, 0, 0, 0.8);
			this.addSubview(topImageView);
			this.addSubview(rightImageView);
			this.addSubview(botImageView);
			this.addSubview(leftImageView);
			this.addSubview(upLeftCornerImageView);
			this.addSubview(upRightCornerImageView);
			this.addSubview(botRightCornerImageView);
			this.addSubview(botLeftCornerImageView);
		}
	}
}
