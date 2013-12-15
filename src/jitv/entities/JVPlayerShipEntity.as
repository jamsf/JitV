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
	 * Created by Fletcher, 11/3/13
	 */
	public class JVPlayerShipEntity extends Entity 
	{	
		var lastBulletFired:int;
		var cooldown:Boolean;
		var firingRate:int = 10;
		var time:int = 0;
		
		public function JVPlayerShipEntity() 
		{
			super();
			
			var image:Image = new Image(Assets.PLAYER_SHIP_ENTITY);
			image.centerOrigin();
			this.graphic = image;
			
			this.mask = new Hitbox(12, 12, -6, -6);
			
			this.type = "player";
			this.width = 12;
			this.height = 12;
		}
	
		override public function update():void
		{
			// Movement
			time++;
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
			
			// Primary Fire
			if (Input.check(Key.SPACE) && cooldown == false)
			{
				var bullet:JVBulletEntity = new JVBulletEntity(this.x, this.y);
				FP.world.add(bullet);
				cooldown = true;
				lastBulletFired = time;
			}
			if (cooldown == true)
			{
				if (firingRate < time - lastBulletFired)
				{
					cooldown = false;
				}
			}
			
			
			
		}
	}
}
