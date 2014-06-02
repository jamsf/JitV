package jitv.entities.components;

import com.haxepunk.HXP;
import com.haxepunk.math.Vector;
import extendedhxpunk.ext.EXTMath;
import extendedhxpunk.ext.EXTUtility;
import flash.geom.Point;
import jitv.entities.JVEntity;
import jitv.JVConstants;

/**
 * Entity component which moves the parent entity toward a target entity
 * Created by Fletcher, 5/25/2014
 */
class JVFollowComponent implements JVEntityComponent
{
	public var target:JVEntity;
	public var force:Float;
	public var maxSpeed:Float;
	public var enabled:Bool;
	
	/**
	 * Create a component for following a target
	 * @param	parent			Subject following the target
	 * @param	target			The entity to follow
	 * @param	initialSpeed	The initial speed to follow at
	 * @param	initialVelocity	The initial velocity vector to follow at (optional, if set it is assumed to be normalized and will be multiplied by initialSpeed)
	 * @param	force			The force of the pull toward the object (Defaults to 1 pixel per second per second)
	 * @param	maxSpeed		The max speed to follow at. If < 0 it is ignored (default).
	 * @param	completionCallback	Function to call when the parent reaches the target.
	 */
	public function new(parent:JVEntity, target:JVEntity = null, completionCallback:JVEntity->Void, initialSpeed:Float = 0.0, initialVelocity:Vector = null, force:Float = 1.0, maxSpeed:Float = -1.0)
	{
		_parent = parent;
		this.target = target;
		_initialSpeed = initialSpeed;
		_initialVelocity = initialVelocity;
		this.force = force;
		this.maxSpeed = maxSpeed;
		_completionCallback = completionCallback;
		this.prepare();
		this.enabled = true;
	}
	
	public function update():Void 
	{
		if (target != null && target.enabled)
		{
			var accelerationMagnitude:Float = this.force * HXP.elapsed * JVConstants.ASSUMED_FPS_FOR_PHYSICS;
			
			// Get the distance between the points
			var difference:Vector = new Vector(this.target.x - _parent.x, this.target.y - _parent.y);
			var forceVector:Vector = new Vector(difference.x, difference.y);
			
			// Normalize the vector
			forceVector.normalize(1.0);
			
			// Find the acceleration vector
			forceVector.x *= accelerationMagnitude;
			forceVector.y *= accelerationMagnitude;
			
			// Apply the acceleration
			_velocityVector.x += forceVector.x;
			_velocityVector.y += forceVector.y;

			// Check against maxSpeed
			if (this.maxSpeed >= 0.0 && _velocityVector.length > this.maxSpeed)
			{
				_velocityVector.normalize(1.0);
				_velocityVector.x *= this.maxSpeed;
				_velocityVector.y *= this.maxSpeed;
			}
			
			// Check if we've reached our destination
			if (_completionCallback != null && _parent.collideWith(this.target, _parent.x, _parent.y) != null)
			{
				_completionCallback(_parent);
			}
			
			// Apply the velocity
			_parent.x += _velocityVector.x * HXP.elapsed * JVConstants.ASSUMED_FPS_FOR_PHYSICS;
			_parent.y += _velocityVector.y * HXP.elapsed * JVConstants.ASSUMED_FPS_FOR_PHYSICS;
		}
		else
		{
			this.enabled = false;
			_parent.components.remove(this);
		}
	}
	
	public function render():Void 
	{
		
	}
	
	public function prepare():Void 
	{
		if (target != null && target.enabled)
		{
			if (_initialVelocity == null)
			{
				_initialVelocity = new Vector(this.target.x - _parent.x, this.target.y - _parent.y);
				_initialVelocity.normalize(1.0);
			}

			_velocityVector = new Vector(_initialVelocity.x * _initialSpeed, _initialVelocity.y * _initialSpeed);
		}
		else
		{
			this.enabled = false;
			_parent.components.remove(this);
		}
	}
	
	public function cleanup():Void 
	{
		
	}
	
	/**
	 * Private
	 */
	private var _parent:JVEntity;
	private var _velocityVector:Vector;
	private var _initialSpeed:Float;
	private var _initialVelocity:Vector;
	private var _completionCallback:JVEntity->Void;
}
