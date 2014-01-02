package jitv.entities;

import com.haxepunk.Entity;
import jitv.entities.components.JVEntityComponent;

/**
 * JVEntity
 * Subclass of Entity for handling logic specific to our game entities, 
 * such as managing components.
 * Created by Fletcher, 1/1/2014
 */
class JVEntity extends Entity
{
	public var components:Array<JVEntityComponent>;
	
	public function new() 
	{
		super();
		components = new Array();
	}
	
	override public function update():Void 
	{
		for (component in this.components)
			component.update();
	}
	
	override public function render():Void
	{
		super.render();
		
		for (component in this.components)
			component.render();
	}
	
	override public function removed():Void
	{
		for (component in this.components)
			component.cleanup();
	}
}
