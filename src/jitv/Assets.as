package jitv
{
	public class Assets
	{
		/**
		 * PLACEHOLDER
		 */
		
		// UI
		[Embed(source = "../../assets/images/ui/speech_bubble_corner_8x8.png")] public static const UI_SPEECH_BUBBLE_CORNER:Class;
		[Embed(source = "../../assets/images/ui/speech_bubble_side_horizontal_8x8.png")] public static const UI_SPEECH_BUBBLE_SIDE_HORIZONTAL:Class;
		[Embed(source = "../../assets/images/ui/speech_bubble_side_vertical_8x8.png")] public static const UI_SPEECH_BUBBLE_SIDE_VERTICAL:Class;
		[Embed(source = "../../assets/images/ui/button_enabled_32x32.png")] public static const UI_BUTTON_ENABLED:Class;
		[Embed(source = "../../assets/images/ui/button_disabled_32x32.png")] public static const UI_BUTTON_DISABLED:Class;
		[Embed(source = "../../assets/images/ui/button_hover_32x32.png")] public static const UI_BUTTON_HOVERING:Class;
		[Embed(source = "../../assets/images/ui/button_pressed_32x32.png")] public static const UI_BUTTON_PRESSED:Class;
		[Embed(source = "../../assets/images/ui/button_selected_32x32.png")] public static const UI_BUTTON_SELECTED:Class;
		[Embed(source = "../../assets/images/ui/button_selected_hover_32x32.png")] public static const UI_BUTTON_SELECTED_HOVERING:Class;
		
		// Backgrounds
		[Embed(source = "../../assets/images/backgrounds/menu_background_1.jpg")] public static const BG_MENU_1:Class;
		
		// Entities
		[Embed(source = "../../assets/images/entities/player_ship_entity.png")] public static const PLAYER_SHIP_ENTITY:Class;
		[Embed(source = "../../assets/images/entities/enemy_0_entity.png")] public static const ENEMY_0_ENTITY:Class;
		[Embed(source = "../../assets/images/entities/waves.png")] public static const WAVES_ENTITY:Class;
		
		
		/**
		 * For real
		 */
		
		// UI
		
		// Backgrounds
		
		// Entities
		
		/**
		 * String access
		 */
		public static function AssetClassForString(assetName:String):Class
		{
			return Assets[assetName];
		}
	}
}
