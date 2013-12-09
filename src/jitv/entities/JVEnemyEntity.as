package jitv.entities
{
	import jitv.Assets;
	import jitv.JVConstants;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	
	public class JVEnemyEntity extends Entity
	{
		protected var health:int = 100;
		
		public function JVEnemyEntity()
		{
			super();
			
			var image:Image = new Image(Assets.ENEMY_0_ENTITY);
			image.centerOrigin();
			this.graphic = image;
			
			var mask:Pixelmask = new Pixelmask(Assets.ENEMY_0_ENTITY, -16, -16);
			this.mask = mask;
			
			this.type = "enemy";
			this.width = 32;
			this.height = 32;
		}
		
		override public function update():void
		{
			this.y += 2;
			
			// Check if offscreen and remove
			if (this.y > FP.screen.height + JVConstants.OFFSCREEN_DELETION_BUFFER)
				FP.world.remove(this);
				

			var collidedEntity:Entity = this.collide("playerbullet", this.x, this.y);
			if (collidedEntity != null)
			{
				FP.world.remove(this);
				FP.world.remove(collidedEntity);
			}

		}
	}
}
