package jitv.entities 
{
	import jitv.Assets;
	import jitv.JVConstants;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	
	/**
	 * JVPlayerShipEntity
	 * Entity representing a player-controllable ship.
	 * Created by Clement, 12/8/13
	 */
	public class JVBulletEntity extends Entity
	{
		
		public function JVBulletEntity(x:int, y:int, type:String) 
		{
			super();
			
			var image:Image = new Image(Assets.BULLET_0_ENTITY);
			image.centerOrigin();
			this.graphic = image;
			
			// TODO: Pixelmask or Hitbox???!?!?
			//this.mask = new Hitbox(12, 12, -6, -6);
			var mask:Pixelmask = new Pixelmask(Assets.BULLET_0_ENTITY, -4, -4);
			this.mask = mask;
			
			this.type = type;
			this.width = 8;
			this.height = 8;
			this.x = x;
			this.y = y;
		}
		
		override public function update():void
		{	
			// If "player" bullet travel up, if "enemy bullet" travel down
			if (type == "player")
			{
				this.y -= 6;	
			}
			else if(type == "enemy")
			{
				this.y += 6;
			}
			
			
			// Check if offscreen and remove
			if (this.y < 0 - JVConstants.OFFSCREEN_DELETION_BUFFER)
				FP.world.remove(this);
		}
	}

}