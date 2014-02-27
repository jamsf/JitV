package jitv;
import com.haxepunk.math.Vector;

/**
 * ...
 * @author ...
 */
class JVUtil
{

	public static function createVector(angle:Float,force:Float):Vector
	{
		return new Vector(
			Math.cos(angle*Math.PI) * force,
			Math.sin(angle*Math.PI) * force
		);
	}
	
}