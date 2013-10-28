package jitv
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.extendedpunk.ext.EXTConsole;
	
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
		}
		
		override public function update():void
		{
			super.update();
			
CONFIG::debug
{
			EXTConsole.update();
}
		}
	}
}
