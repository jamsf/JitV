package jitv.datamodel.persistentdata;

import jitv.datamodel.JVDataObject;

/**
 * JVShipChassis
 * Data for a chassis ship part
 * Created by Fletcher, 12/23/13
 */
class JVShipChassis extends JVDataObject
{
	public var imageName:String; // Name of the image to use for this part
	public var armor:Int; // Hits it takes to destroy ship
	public var speed:Int; // Movement speed of the ship
	public var modifiers:Array; // Array of bonus modifiers this part provides
}
