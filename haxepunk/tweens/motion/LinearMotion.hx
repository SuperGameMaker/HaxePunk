﻿package haxepunk.tweens.motion;

import haxepunk.Tween;
import haxepunk.utils.Ease;
import flash.geom.Point;

/**
 * Determines motion along a line, from one point to another.
 */
class LinearMotion extends Motion
{
	/**
	 * Constructor.
	 * @param	complete	Optional completion callback.
	 * @param	type		Tween type.
	 */
	public function new(?complete:Dynamic -> Void, ?type:TweenType)
	{
		_fromX = _fromY = _moveX = _moveY = 0;
		_distance = -1;
		super(0, complete, type, null);
	}

	/**
	 * Starts moving along a line.
	 * @param	fromX		X start.
	 * @param	fromY		Y start.
	 * @param	toX			X finish.
	 * @param	toY			Y finish.
	 * @param	duration	Duration of the movement.
	 * @param	ease		Optional easer function.
	 */
	public function setMotion(fromX:Float, fromY:Float, toX:Float, toY:Float, duration:Float, ease:Float -> Float = null)
	{
		_distance = -1;
		x = _fromX = fromX;
		y = _fromY = fromY;
		_moveX = toX - fromX;
		_moveY = toY - fromY;
		_target = duration;
		_ease = ease;
		start();
	}

	/**
	 * Starts moving along a line at the speed.
	 * @param	fromX		X start.
	 * @param	fromY		Y start.
	 * @param	toX			X finish.
	 * @param	toY			Y finish.
	 * @param	speed		Speed of the movement.
	 * @param	ease		Optional easer function.
	 */
	public function setMotionSpeed(fromX:Float, fromY:Float, toX:Float, toY:Float, speed:Float, ease:Float -> Float = null)
	{
		_distance = -1;
		x = _fromX = fromX;
		y = _fromY = fromY;
		_moveX = toX - fromX;
		_moveY = toY - fromY;
		_target = distance / speed;
		_ease = ease;
		start();
	}

	/** @private Updates the Tween. */
	@:dox(hide)
	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		x = _fromX + _moveX * _t;
		y = _fromY + _moveY * _t;
		if (x == _fromX + _moveX && y == _fromY + _moveY && active)
		{
			super.update(elapsed);
			finish();
		}
	}

	/**
	 * Length of the current line of movement.
	 */
	public var distance(get, never):Float;
	function get_distance():Float
	{
		if (_distance >= 0) return _distance;
		return (_distance = Math.sqrt(_moveX * _moveX + _moveY * _moveY));
	}

	// Line information.
	var _fromX:Float;
	var _fromY:Float;
	var _moveX:Float;
	var _moveY:Float;
	var _distance:Float;
}
