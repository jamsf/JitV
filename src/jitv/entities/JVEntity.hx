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
	public var enabled(default, null):Bool;
	
	public function new() 
	{
		super();
		components = new Array();
	}
	
	/**
	 * Returns the component of the given class type, i.e.
	 * getComponentOfType(JVPatternComponent);
	 * @param	type
	 * @return
	 */
	//public function getComponentOfType(classType):T
	//{
		//for (i in 0...this.components.length)
		//{
			//var component:JVEntityComponent = this.components[i];
			//if (Std.is(component, T))
				//return component;
		//}
		//return null;
	//}
	
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
	
	override public function added():Void
	{
		this.enabled = true;
		
		for (component in this.components)
			component.prepare();
	}
	
	override public function removed():Void
	{
		this.enabled = false;
		for (component in this.components)
			component.cleanup();
	}
}
