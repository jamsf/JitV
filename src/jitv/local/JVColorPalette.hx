package jitv.local;

import openfl.Assets;
import flash.display.BitmapData;
import flash.geom.Point;
import com.haxepunk.graphics.Image;
import extendedhxpunk.ext.EXTColor;

/**
 * JVColorPalette
 * Created by Fletcher, 5/18/2014
 */
class JVColorPalette
{
	public static inline var INDEX_PLAYER_SHIP_1:Int = 0;
	public static inline var INDEX_PLAYER_SHIP_2:Int = 1;
	public static inline var INDEX_PLAYER_SHIP_3:Int = 2;
	public static inline var INDEX_PLAYER_SHIP_4:Int = 3;
	public static inline var INDEX_ENEMY_SHIP_1:Int = 4;
	public static inline var INDEX_ENEMY_SHIP_2:Int = 5;
	public static inline var INDEX_ENEMY_SHIP_3:Int = 6;
	public static inline var INDEX_ENEMY_SHIP_4:Int = 7;
	public static inline var INDEX_BACKGROUND_1:Int = 8;
	public static inline var INDEX_BACKGROUND_2:Int = 9;
	
	public var paletteId(default, null):UInt;
	public var baseImage(default, null):Image;
	
	public function new(paletteId:UInt) 
	{
		this.paletteId = paletteId;
		var imageName:String = "gfx/palette_" + (paletteId < 10 ? "0" : "") + paletteId + ".png";
		_bitmapData = Assets.getBitmapData(imageName);
		this.baseImage = new Image(imageName);
		_colorMap = new Map();
	}
	
	public function colorForIndex(index:Int):EXTColor
	{
		var existingColor:EXTColor = _colorMap[index];
		if (existingColor == null)
		{
			existingColor = extractColorFromBaseImage(index);
			_colorMap[index] = existingColor;
		}
		return existingColor;
	}
	
	/**
	 * Private
	 */
	private static inline var COLORPALETTE_GRID_SPACE_SIZE:UInt = 4;
	private static inline var COLORPALETTE_GRID_SIZE:UInt = 8;
	
	private var _colorMap:Map<Int, EXTColor>;
	private var _bitmapData:BitmapData;
	
	private function extractColorFromBaseImage(index:UInt):EXTColor
	{
		var xPos:UInt = cast (index % COLORPALETTE_GRID_SIZE) * COLORPALETTE_GRID_SPACE_SIZE;
		var yPos:UInt = cast (index / COLORPALETTE_GRID_SIZE) * COLORPALETTE_GRID_SPACE_SIZE;
		var color:EXTColor = new EXTColor();
		color.webColor = _bitmapData.getPixel(xPos, yPos);
		return color;
	}
}
