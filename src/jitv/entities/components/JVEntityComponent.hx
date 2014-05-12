package jitv.entities.components;

import jitv.entities.JVEntity;

/**
 * JVEntityComponent
 * Interface for entity components, managed by JVEntity
 * Created by Fletcher, 1/1/2014
 */
interface JVEntityComponent
{
	public function update():Void;
	public function render():Void;
	public function prepare():Void;
	public function cleanup():Void;
}
