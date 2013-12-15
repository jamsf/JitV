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
		private var time = 0;
		
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
			time++;
			
			// Move down
			this.y += 2;
			
			// Fire a bullet
			if (time % 70 == 0)
			{
				var bullet:JVBulletEntity = new JVBulletEntity(this.x, this.y, this.type);
				FP.world.add(bullet);
			}
			
			// Check if offscreen and remove
			if (this.y > FP.screen.height + JVConstants.OFFSCREEN_DELETION_BUFFER)
				FP.world.remove(this);
				
			var collidedEntity:Entity = this.collide("player", this.x, this.y);
			if (collidedEntity != null)
			{
				this.health -= 25;
				FP.world.remove(collidedEntity);
				if (this.health <= 0)
				{
					FP.world.remove(this);
				}
			}

		}
	}
}
