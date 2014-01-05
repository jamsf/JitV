package jitv.entities.components;

import flash.geom.Point;
import com.haxepunk.tweens.motion.LinearMotion;
import com.haxepunk.Tween;
import extendedhxpunk.ext.EXTTimer;
import jitv.entities.JVEntity;
import jitv.datamodel.staticdata.JVEnemyPattern;

/**
 * JVPatternComponent
 * Component for updating a pattern for an entity
 * Created by Fletcher, 1/1/2014
 */
class JVPatternComponent implements JVEntityComponent
{
	public var started:Bool;
	public var complete:Bool;
	
	/**
	 * Constructor
	 * @param	parent			Entity this object is a component of
	 * @param	pattern			Pattern to apply to the entity
	 * @param	indexInPattern	Index of parent in the pattern data
	 * @param	delay			Seconds to delay execution of the pattern
	 */
	public function new(parent:JVEntity, pattern:JVEnemyPattern, indexInPattern:Int, delay:Float) 
	{
		_parentEntity = parent;
		_pattern = pattern;
		_indexInPattern = indexInPattern;
		_delay = delay;
		_gridSpaceWidth = cast (pattern.totalWidth / pattern.gridColumns);
		_gridSpaceHeight = cast (pattern.totalHeight / pattern.gridRows);
	}
	
	public function update():Void 
	{
		// Follow pattern
		if (!_hasSetUpPattern)
		{
			setupPatternMovement();
			_hasSetUpPattern = true;
		}
		else if (this.started && !this.complete)
		{
			_parentEntity.x += _motion.x - _previousPoint.x;
			_parentEntity.y += _motion.y - _previousPoint.y;
			_previousPoint = new Point(_motion.x, _motion.y);
		}
	}
	
	public function render():Void 
	{
		
	}
	
	public function cleanup():Void
	{
		if (_motion != null)
			_parentEntity.removeTween(_motion);
	}
	
	public function pathStageComplete(_):Void
	{
		var startNewMotion:Bool = false;
		var previousKeyFrame:Int = _keyFramesCompleted;
		++_keyFramesCompleted;

		if (_keyFramesCompleted < _pattern.keyFrameCount)
		{
			startNewMotion = true;
		}
		else if (_keyFramesCompleted > 1 && _pattern.loops)
		{
			_keyFramesCompleted = _pattern.loopIndex;
			startNewMotion = true;
		}

		if (startNewMotion)
		{
			var nextKeyFramePoint:Point = _pattern.keyFramePositions[_indexInPattern][_keyFramesCompleted];
			_motion.setMotion(_previousPoint.x, _previousPoint.y,
							  nextKeyFramePoint.x * _gridSpaceWidth, nextKeyFramePoint.y * _gridSpaceHeight,
							  _pattern.keyFrameTimes[previousKeyFrame]);
		}
		else
		{
			this.complete = true;
		}
	}
	
	public function beginPatternMovement(timer:EXTTimer):Void
	{
		this.started = true;
		_motion = new LinearMotion(pathStageComplete, TweenType.Persist);
		this.pathStageComplete(null);
		_parentEntity.addTween(_motion);
	}
	
	/**
	 * Private
	 */
	private var _parentEntity:JVEntity;
	private var _pattern:JVEnemyPattern;
	private var _indexInPattern:Int;
	private var _delay:Float;
	private var _hasSetUpPattern:Bool = false;
	private var _keyFramesCompleted:Int = 0;
	private var _motion:LinearMotion;
	private var _previousPoint:Point;
	private var _gridSpaceWidth:Int;
	private var _gridSpaceHeight:Int;
	
	private function setupPatternMovement():Void
	{
		_previousPoint = _pattern.keyFramePositions[_indexInPattern][0];
		_previousPoint = new Point(_previousPoint.x * _gridSpaceWidth, _previousPoint.y * _gridSpaceHeight);
		_parentEntity.x += _previousPoint.x;
		_parentEntity.y += _previousPoint.y;
		
		// Delay the start of the pattern execution if necessary
		if (_delay > 0)
			EXTTimer.createTimer(_delay, false, beginPatternMovement);
		else
			this.beginPatternMovement(null);
	}
}
