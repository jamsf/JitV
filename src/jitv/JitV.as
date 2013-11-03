package jitv
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.extendedpunk.ext.EXTConsole;
	import jitv.worlds.*;
	
	[SWF(frameRate=60,width="620",height="380")]
	public class JitV extends Engine
	{
		public function JitV()
		{
			super(620, 380, 60, true);
			FP.screen.color = 0xff7777;
			EXTConsole.initializeConsole();
		}
		
		override public function init():void
		{
			super.init();
			JVWorldManager.sharedInstance.goToMainMenuWorld();
		}
		
		override public function update():void
		{
			super.update();
			
			JVWorldManager.sharedInstance.update();
			
CONFIG::debug
{
			EXTConsole.update();
}
		}
	}
}
