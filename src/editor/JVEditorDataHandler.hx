package editor;

#if !flash
import sys.io.File;
import sys.io.FileOutput;
#end
import extendedhxpunk.ext.EXTJsonSerialization;
import jitv.datamodel.staticdata.JVEnemyPattern;
import jitv.JVJsonMappings;

/**
 * ...
 * Created by Fletcher, 2/17/2014
 */
class JVEditorDataHandler
{
	public var patterns(default, null):Array<JVEnemyPattern>;
	
	public function new(filepath:String) 
	{
		_filepath = filepath;
	}
	
	public function loadPatternDataFromDisk():Void
	{
#if !flash
		 var fileContent:String = File.getContent(_filepath);
		 this.patterns = EXTJsonSerialization.decode(fileContent, Array);
#end
	}
	
	public function writePatternDataToDisk():Void
	{
#if !flash
		var contentToWrite:String = EXTJsonSerialization.encode(this.patterns, JVJsonMappings.fieldMapping);
		File.saveContent(_filepath, contentToWrite);
#if debug
		// Navigate out of the bin folder and save the new data in our repo's folder
		File.saveContent("../../../../" + _filepath, contentToWrite);
#end
#end
	}
	
	/**
	 * Private
	 */
	private var _filepath:String;
}
