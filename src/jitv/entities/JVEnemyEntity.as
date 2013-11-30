package jitv.entities
{
	import jitv.Assets;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	
	public class JVEnemyEntity extends Entity
	{
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
		}
	}
}
