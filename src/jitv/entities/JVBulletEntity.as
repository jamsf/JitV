package jitv.entities 
{
	import flash.geom.Point;
	
	import jitv.Assets;
	import jitv.JVConstants;
	
	import net.extendedpunk.ext.EXTKey;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * JVPlayerShipEntity
	 * Entity representing a player-controllable ship.
	 * Created by Clement, 12/8/13
	 */
	public class JVBulletEntity extends Entity
	{
		
		public function JVBulletEntity(x:int, y:int) 
		{
			super();
			
			var image:Image = new Image(Assets.BULLET_0_ENTITY);
			image.centerOrigin();
			this.graphic = image;
			
			// TODO: Pixelmask or Hitbox???!?!?
			//this.mask = new Hitbox(12, 12, -6, -6);
			var mask:Pixelmask = new Pixelmask(Assets.BULLET_0_ENTITY, -16, -16);
			this.mask = mask;
			
			this.type = "player";
			this.width = 8;
			this.height = 8;
			this.x = x;
			this.y = y;
		}
		
		override public function update():void
		{
			var movementMagnitude:Number = 6 * FP.elapsed * JVConstants.ASSUMED_FPS_FOR_PHYSICS;
			
			// only travels vertically for now
			//if (horizontalMovement)
			//	this.x += xMultiplier * movementMagnitude;
			//if (verticalMovement)
			
			this.y -= 1 * movementMagnitude;	
		}
	}

}