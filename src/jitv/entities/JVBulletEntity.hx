package jitv.entities;

import openfl.utils.Int16Array;
import com.haxepunk.debug.Console;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.masks.Pixelmask;
import com.haxepunk.math.Vector;
import extendedhxpunk.ext.EXTColor;
import jitv.JVConstants;
import jitv.JVGlobals;
import jitv.entities.JVEntity;
import jitv.local.JVLocalData;
import jitv.local.JVColorPalette;

/**
 * JVPlayerShipEntity
 * Entity representing a player-controllable ship.
 * Created by Clement 12/8/13, Ported by Fletcher 12/15/13
 */
class JVBulletEntity extends JVEntity
{
	var vel:Vector;
	var movementMagnitude:Float;
	var damagePoints:Int;
	
	public function new(x:Float, y:Float, type:String, angle:Float, velocity:Float, damagePoints:Int, color:EXTColor) 
	{
		super();
		
		var image:Image = new Image("gfx/entities/bullet_0_entity.png");
		image.centerOrigin();
		image.color = color.webColor;
		this.graphic = image;
		
		var mask:Pixelmask = new Pixelmask("gfx/masks/bullet_0_mask.png", Std.int( -image.width / 2), Std.int( -image.width / 2));
		this.mask = mask;
		
		this.damagePoints = damagePoints;
		this.type = type;
		this.width = image.width;
		this.height = image.height;
		this.x = x;
		this.y = y;
		vel = JVUtil.createVector(angle, velocity);
	}
	
	override public function update():Void
	{
		super.update();
		
		movementMagnitude = HXP.elapsed * JVConstants.ASSUMED_FPS_FOR_PHYSICS;
		
		this.x += vel.x * movementMagnitude;
		this.y += vel.y * movementMagnitude;
		
		if (this.x < JVGlobals.PLAY_SPACE_OFFSET.x - JVConstants.ENEMY_OFFSCREEN_DELETION_BUFFER ||
			this.y < JVGlobals.PLAY_SPACE_OFFSET.y - JVConstants.ENEMY_OFFSCREEN_DELETION_BUFFER ||
			this.x > JVGlobals.PLAY_SPACE_OFFSET.x + JVConstants.PLAY_SPACE_WIDTH + JVConstants.ENEMY_OFFSCREEN_DELETION_BUFFER ||
			this.y > JVGlobals.PLAY_SPACE_OFFSET.y + JVConstants.PLAY_SPACE_HEIGHT + JVConstants.ENEMY_OFFSCREEN_DELETION_BUFFER)
			HXP.scene.remove(this);
	}
	
	public function getDamagePoints():Int
	{
		return damagePoints;
	}
}
