package jitv.local;

/**
 * JVLocalData
 * Access to data, states, and settings local to this game copy
 * Created by Fletcher, 5/18/2014
 */
class JVLocalData
{
	public var currentColorPalette(default, null):JVColorPalette;
	
	/**
	 * Singleton access
	 */
	public static function sharedInstance():JVLocalData
	{
		if (_Singleton == null)
			_Singleton = new JVLocalData();
		return _Singleton;
	}
	
	/**
	 * For singleton guarding
	 */
	private static var _Singleton:JVLocalData = null;
	private function new()
	{
		this.currentColorPalette = new JVColorPalette(1);
	}
}
