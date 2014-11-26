package jitv.entities.components;

import jitv.datamodel.staticdata.JVEnemyClass;
import jitv.datamodel.staticdata.JVBossClass;
import jitv.entities.JVEntity;
import jitv.entities.components.JVEntityComponent;
import jitv.entities.components.JVGravitateComponent;
import jitv.entities.components.JVMovementComponent;
import jitv.entities.components.JVPatternComponent;
import jitv.entities.components.JVWeaponComponent;

/**
 * JVEnemyBehaviorFactory
 * Assigns appropriate components to Enemy and Boss entity's according to their data
 * Created by Fletcher 11/23/14
 */
class JVEnemyBehaviorFactory
{
	public static function setupEnemyBehavior:(data:JVEnemyClass, entity:JVEntity):Void
	{
		
	}
	
	public static function setupBossBehavior:(data:JVBossClass, entity:JVEntity):Void
	{
		
	}
}
