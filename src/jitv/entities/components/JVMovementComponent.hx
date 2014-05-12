package jitv.entities.components;

import com.haxepunk.HXP;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import extendedhxpunk.io.Gamepad;
import extendedhxpunk.ext.EXTMath;
import jitv.entities.JVEntity;
import jitv.JVConstants;

/**
 * JVMovementComponent
 * Handles movement via input for an entity (i.e. the player's ship)
 * Created by Fletcher, 5/11/2014
 */
class JVMovementComponent implements JVEntityComponent
{
	public function new(parent:JVEntity, gamepad:Gamepad) 
	{
		_parent = parent;
		_gamepad = gamepad;
	}
	
	public function update():Void 
	{
		// Movement
		var movementMagnitude:Float = JVConstants.BASE_SHIP_MOVEMENT_SPEED * HXP.elapsed * JVConstants.ASSUMED_FPS_FOR_PHYSICS;
		
		var horizontalMovement:Bool = false;
		var verticalMovement:Bool = false;
		var xMultiplier:Float = 1.0;
		var yMultiplier:Float = 1.0;
		
		// TODO - Have better checking for controller support
		if ((Math.abs(_gamepad.leftAnalogueX) > 0) || (Math.abs(_gamepad.leftAnalogueY) > 0))
		{
			if (Math.abs(_gamepad.leftAnalogueX) > 0)
			{
				horizontalMovement = true;
				xMultiplier = _gamepad.leftAnalogueX;
			}
			if (Math.abs(_gamepad.leftAnalogueY) > 0)
			{
				verticalMovement = true;
				yMultiplier = _gamepad.leftAnalogueY;
			}
		}
		else
		{
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
		}
		
		if (horizontalMovement && verticalMovement)
		{
			xMultiplier *= EXTMath.SQRT2_2;
			yMultiplier *= EXTMath.SQRT2_2;
		}
		
		if (horizontalMovement)
			_parent.x += xMultiplier * movementMagnitude;
		if (verticalMovement)
			_parent.y += yMultiplier * movementMagnitude;
	}
	
	public function render():Void 
	{
		
	}
	
	public function prepare():Void
	{
		
	}
	
	public function cleanup():Void 
	{
		
	}
	
	/**
	 * Private
	 */
	private var _parent:JVEntity;
	private var _gamepad:Gamepad;
}
