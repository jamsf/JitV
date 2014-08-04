package jitv.scenes;

import com.haxepunk.math.Projection;
import extendedhxpunk.ui.UIView;
import flash.geom.Point;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Draw;
import extendedhxpunk.ext.EXTScene;
import extendedhxpunk.ext.EXTOffsetType;
import extendedhxpunk.ext.EXTUtility;
import jitv.entities.JVEntity;
import jitv.entities.JVLevelSelectEntity;
import jitv.ui.JVExampleMenuButton;
import jitv.datamodel.proceduraldata.JVLevel;
import jitv.local.JVLocalData;
import jitv.local.JVColorPalette;
import jitv.JVConstants;

/**
 * JVLevelSelectWorld
 * A world in which the player can create ship specs, upgrade ship parts, and visit different levels.
 * Created by Fletcher 11/3/13, Ported by Fletcher 12/15/13
 */
class JVLevelSelectScene extends EXTScene
{
	public function new() 
	{
		super();
	}
	
	override public function begin():Void
	{
		// Background Image
		var screenSize:Point = this.worldCamera.currentViewSize();
		var backgroundImage:Image = new Image("gfx/entities/particle_entity.png");
		backgroundImage.scaledWidth = screenSize.x;
		backgroundImage.scaledHeight = screenSize.y;
		backgroundImage.color = JVLocalData.sharedInstance().currentColorPalette.colorForIndex(JVColorPalette.INDEX_BACKGROUND_1).webColor;
		
		this.addGraphic(backgroundImage);
		
		var containerView = new UIView(EXTUtility.ZERO_POINT, screenSize);
		
		var startLevelButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(10, 10), "TEST LEVEL", buttonCallback, [START_LEVEL_NAME]);
		startLevelButton.offsetAlignmentInParent = EXTOffsetType.TOP_LEFT;
		startLevelButton.offsetAlignmentForSelf = EXTOffsetType.TOP_LEFT;
		var goBackButton:JVExampleMenuButton = new JVExampleMenuButton(new Point(10, 20 + startLevelButton.size.y), "GO BACK", buttonCallback, [BACK_BUTTON_NAME]);
		goBackButton.offsetAlignmentInParent = EXTOffsetType.TOP_LEFT;
		goBackButton.offsetAlignmentForSelf = EXTOffsetType.TOP_LEFT;
		
		containerView.addSubview(startLevelButton);
		containerView.addSubview(goBackButton);
		this.staticUiController.rootView.addSubview(containerView);
		
		// Set up level select grid
		if (HXP.fullscreen)
		{
			_levelIconImage = new Image("gfx/ui/level_select_icon_64x64.png");
			_levelIconImage.scale = 0.5;
		}
		else
		{
			_levelIconImage = new Image("gfx/ui/level_select_icon_32x32.png");
		}
		_levelIconImage.color = JVLocalData.sharedInstance().currentColorPalette.colorForIndex(JVColorPalette.INDEX_BACKGROUND_2).webColor;
		_levelIconImage.centerOrigin();
		
		var centerX = screenSize.x / 2;
		var centerY = screenSize.y / 2;
		var initialLocations:Array<Point> = [new Point(centerX, centerY), //NOTE - Center point currently unused
											 new Point(centerX, centerY - JVConstants.LEVEL_SELECT_ICON_DISTANCE * 1.5), 
											 new Point(centerX + JVConstants.LEVEL_SELECT_ICON_DISTANCE * 1.5, centerY), 
											 new Point(centerX, centerY + JVConstants.LEVEL_SELECT_ICON_DISTANCE * 1.5), 
											 new Point(centerX - JVConstants.LEVEL_SELECT_ICON_DISTANCE * 1.5, centerY)];
		
		addLevelQuadrant(initialLocations[1], false, true);		// up
		addLevelQuadrant(initialLocations[2], true, false);		// right
		addLevelQuadrant(initialLocations[3], false, false);	// down
		addLevelQuadrant(initialLocations[4], true, true);		// left
	}
	
	public function buttonCallback(args:Array<Dynamic>):Void
	{
		var buttonName:String = args[0];
		if (buttonName == START_LEVEL_NAME)
			JVSceneManager.sharedInstance().goToSceneForCombatLevel(new JVLevel());
		else 
		if (buttonName == BACK_BUTTON_NAME)
			JVSceneManager.sharedInstance().goToMainMenuScene();
	}
	
	/**
	 * Private
	 */
	private static inline var START_LEVEL_NAME:String = "start_level";
	private static inline var BACK_BUTTON_NAME:String = "back_button";
	
	private var _levelIconImage:Image;
	
	private function addLevelQuadrant(initialPoint:Point, horizontal:Bool, negative:Bool)
	{
		var middleTier:Int = cast (JVConstants.LEVEL_QUANTITY_TIER / 2);
		
		for (i in 0...JVConstants.LEVEL_QUANTITY_TIER)
		{
			var lengthOffset:Int = i * JVConstants.LEVEL_SELECT_ICON_DISTANCE;
			var iconsAtTier:Int = cast (middleTier + 1 - Math.abs(middleTier - i));
			
			for (j in 0...iconsAtTier)
			{
				var breadthOffset:Int = cast ((j + 0.5 - iconsAtTier / 2) * JVConstants.LEVEL_SELECT_ICON_DISTANCE * 2);
				
				var xOffset:Int = 0;
				var yOffset:Int = 0;
				
				if (horizontal)
				{
					yOffset = breadthOffset;
					xOffset = (negative ? -1 : 1) * lengthOffset;
				}
				else
				{
					xOffset = breadthOffset;
					yOffset = (negative ? -1 : 1) * lengthOffset;
				}
				
				addLevelSelectIcon(new Point(initialPoint.x + xOffset, initialPoint.y + yOffset));
			}
		}
	}
	
	private function addLevelSelectIcon(location:Point)
	{
		var levelIconEntity:JVEntity = new JVEntity();
		levelIconEntity.graphic = _levelIconImage;
		levelIconEntity.centerOrigin();
		levelIconEntity.x = location.x;
		levelIconEntity.y = location.y;
		//var levelIconEntity:JVLevelSelectEntity = new JVLevelSelectEntity(location.x, location.y, 32, 32);
		this.add(levelIconEntity);
	}
}
