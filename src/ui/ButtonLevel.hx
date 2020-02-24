package ui;

import mvc.model.data.level.LevelData;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.media.Sound;
import openfl.text.AntiAliasType;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

/**
 * Кнопка выбора игрового уровня.
 * @author VolkovRA
 */
class ButtonLevel extends Button 
{
	/**
	 * Отображаемый уровень.
	 * По умолчанию: null.
	 */
	public var level(default, set):LevelData = null;
	
	// Приват:
	private var label:TextField;
	private var labelHover:TextField;
	private var labelDisabled:TextField;
	private var sound:Sound;
	
	/**
	 * Создать кнопку.
	 */
	public function new() {
		super();
		
		// Построение
		// Свистелка:
		sound						= Assets.getSound("assets/sound/mouse_over.mp3");
		
		// Скин:
		var s:Sprite				= new Sprite();
		s.addChild(new Bitmap(Assets.getBitmapData("assets/image/btn_lvl.png")));
		skin						= s;
		
		var fmt						= new TextFormat(Assets.getFont("assets/font/CgBernhardtBd.ttf").fontName);
		fmt.color					= 0x0;
		fmt.size					= 20;
		fmt.align					= TextFormatAlign.CENTER;
		
		label						= new TextField();
		label.antiAliasType			= AntiAliasType.ADVANCED;
		label.defaultTextFormat		= fmt;
		label.y						= 10;
		label.width					= 51;
		label.height				= 34;
		label.embedFonts			= true;
		label.selectable			= false;
		label.multiline				= false;
		s.addChild(label);
		
		// Скин - Наведение:
		var sHover:Sprite			= new Sprite();
		sHover.addChild(new Bitmap(Assets.getBitmapData("assets/image/btn_lvl_hover.png")));
		skinHover					= sHover;
		
		labelHover					= new TextField();
		labelHover.antiAliasType	= label.antiAliasType;
		labelHover.defaultTextFormat = fmt;
		labelHover.y				= label.y;
		labelHover.width			= label.width;
		labelHover.height			= label.height;
		labelHover.embedFonts 		= label.embedFonts;
		labelHover.selectable 		= label.selectable;
		labelHover.multiline 		= label.multiline;
		sHover.addChild(labelHover);
		
		// Скин - Нажато:
		skinPress					= skinHover;
		
		// Скин - Выключено:
		var sDisabled:Sprite		= new Sprite();
		sDisabled.addChild(new Bitmap(Assets.getBitmapData("assets/image/btn_lvl_closed.png")));
		skinDisabled				= sDisabled;
		
		var fmtDisabled				= new TextFormat(Assets.getFont("assets/font/CgBernhardtBd.ttf").fontName);
		fmtDisabled.color			= 0x666666;
		fmtDisabled.size			= fmt.size;
		fmtDisabled.align			= fmt.align;
		
		labelDisabled				= new TextField();
		labelDisabled.antiAliasType	= label.antiAliasType;
		labelDisabled.defaultTextFormat = fmtDisabled;
		labelDisabled.y				= label.y;
		labelDisabled.width			= label.width;
		labelDisabled.height		= label.height;
		labelDisabled.embedFonts 	= label.embedFonts;
		labelDisabled.selectable 	= label.selectable;
		labelDisabled.multiline 	= label.multiline;
		sDisabled.addChild(labelDisabled);
		
		// События:
		addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
	}
	
	// ЛИСТЕНЕРЫ
	private function onMouseOver(e:MouseEvent):Void {
		if (enabled)
			sound.play();
	}
	
	// ПРИВАТ
	private function update():Void {
		if (level == null) {
			label.text			= "";
			labelHover.text		= "";
			labelDisabled.text	= "";
		}
		else {
			label.text			= Std.string(level.num);
			labelHover.text		= Std.string(level.num);
			labelDisabled.text	= Std.string(level.num);
		}
	}
	
	// СЕТТЕРЫ
	function set_level(value:LevelData):LevelData {
		if (value == level)
			return value;
		
		level = value;
		update();
		
		return value;
	}
}