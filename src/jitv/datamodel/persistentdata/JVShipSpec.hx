package jitv.datamodel.persistentdata;

import jitv.datamodel.JVDataObject;
import jitv.datamodel.proceduraldata.JVShipChassis;
import jitv.datamodel.proceduraldata.JVShipWeapon;

/**
 * JVShipSpec
 * A ship specification that the player has saved for use as a ship in the game.
 * Created by Fletcher, 12/23/2013
 */
class JVShipSpec extends JVDataObject
{
	public var chassis:JVShipChassis;
	public var weapon1:JVShipWeapon;
	public var weapon2:JVShipWeapon;
}
