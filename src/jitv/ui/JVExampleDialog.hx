package jitv.ui;

import com.haxepunk.graphics.Image;
import extendedhxpunk.ui.UIImageView;
import extendedhxpunk.ui.UIView;
import extendedhxpunk.ext.EXTUtility;
import extendedhxpunk.ext.EXTOffsetType;
import flash.geom.Point;

/**
 * JVExampleDialog
 * An example of setting up basic UI in ExtendedPunk
 * Created by Fletcher
 */
class JVExampleDialog extends UIView
{
	public function new(position:Point, size:Point) 
	{
		super(position, size);
		
		// Sides
		var sideImageHorizontal:Image = new Image("gfx/ui/speech_bubble_side_horizontal_8x8.png");
		sideImageHorizontal.scaledWidth = size.x;
		var sideImageVertical:Image = new Image("gfx/ui/speech_bubble_side_vertical_8x8.png");
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
		var cornerImage:Image = new Image("gfx/ui/speech_bubble_corner_8x8.png");
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
