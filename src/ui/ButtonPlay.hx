package ui;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.media.Sound;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.text.AntiAliasType;
import openfl.filters.DropShadowFilter;

/**
 * Кнопка: "PLAY".
 * @author VolkovRA
 */
class ButtonPlay extends Button 
{
	private var sound:Sound;
	
	/**
	 * Создать кнопку.
	 */
	public function new() {
		super();
		
		// Пиликалка:
		sound				= Assets.getSound("assets/sound/mouse_over.mp3");
		
		// Скин
		// Обычное состояние:
		var wrap			= new Sprite();
		var bt				= new Bitmap(Assets.getBitmapData("assets/image/btn.png"));
		bt.scaleX			= 0.91;
		bt.scaleY			= 0.9;
		wrap.addChild(bt);
		
		var label			= new TextField();
		label.defaultTextFormat = new TextFormat(Assets.getFont("assets/font/CgBernhardtBd.ttf").fontName, 37, 0xffffff, false, false, false, null, null, TextFormatAlign.CENTER);
		label.antiAliasType	= AntiAliasType.ADVANCED;
		label.y				= 8;
		label.width			= 146;
		label.height		= 40;
		label.embedFonts	= true;
		label.selectable	= false;
		label.multiline		= false;
		label.text			= "PLAY";
		label.filters		= [new DropShadowFilter(4, 45, 0, 0.8, 3, 3, 1)];
		wrap.addChild(label);
		
		// Наведение:
		var wrap2			= new Sprite();
		var bt2				= new Bitmap(Assets.getBitmapData("assets/image/btn_hover.png"));
		bt2.scaleX			= 0.91;
		bt2.scaleY			= 0.9;
		wrap2.addChild(bt2);
		
		var label2			= new TextField();
		label2.defaultTextFormat = label.defaultTextFormat;
		label2.antiAliasType = label.antiAliasType;
		label2.y			= label.y;
		label2.width		= label.width;
		label2.height		= label.height;
		label2.embedFonts	= label.embedFonts;
		label2.selectable	= label.selectable;
		label2.multiline	= label.multiline;
		label2.text			= label.text;
		label2.filters		= [new DropShadowFilter(4, 45, 0, 0.8, 3, 3, 1)];
		wrap2.addChild(label2);
		
		// Установка:
		skin				= wrap;
		skinHover			= wrap2;
		skinPress			= skinHover;
		
		addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
	}
	
	private function onMouseOver(e:MouseEvent):Void {
		sound.play();
	}
}