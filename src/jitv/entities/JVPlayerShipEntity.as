package jitv.entities 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Key;
	import net.extendedpunk.ext.EXTKey;
	import jitv.Assets;
	import jitv.JVConstants;
	
	/**
	 * JVPlayerShipEntity
	 * Entity representing a player-controllable ship.
	 * Created by Fletcher, 11/3/13
	 */
	public class JVPlayerShipEntity extends Entity 
	{
		public function JVPlayerShipEntity() 
		{
			super();
			var image:Image = new Image(Assets.PLAYER_SHIP_ENTITY);
			image.centerOrigin();
			this.graphic = image;
		}
	
		override public function update():void
		{
			var movementMagnitude:Number = JVConstants.BASE_SHIP_MOVEMENT_SPEED * FP.elapsed * JVConstants.ASSUMED_FPS_FOR_PHYSICS;
			
			var horizontalMovement:Boolean = false;
			var verticalMovement:Boolean = false;
			var xMultiplier:Number = 1.0;
			var yMultiplier:Number = 1.0;
			
			if (Input.check(Key.RIGHT))
			{
				horizontalMovement = true;
			}
			if (Input.check(Key.LEFT))
			{
				horizontalMovement = !horizontalMovement;
				xMultiplier = -1.0;
			}
			if (Input.check(Key.DOWN))
			{
				verticalMovement = true;
			}
			if (Input.check(Key.UP))
			{
				verticalMovement = !verticalMovement;
				yMultiplier = -1.0;
			}
			
			if (horizontalMovement && verticalMovement)
			{
				xMultiplier *= Math.SQRT2 / 2;
				yMultiplier *= Math.SQRT2 / 2;
			}
			
			if (horizontalMovement)
				this.x += xMultiplier * movementMagnitude;
			if (verticalMovement)
				this.y += yMultiplier * movementMagnitude;
		}
	}
}
