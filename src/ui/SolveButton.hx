package ui;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.text.AntiAliasType;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

/**
 * Кнопка подсказки.
 * @author VolkovRA
 */
class SolveButton extends Button 
{
	/**
	 * Создать кнопку.
	 */
	public function new() {
		super();
		
		// Скин
		// Обычное состояние:
		var wrap			= new Sprite();
		var bt				= new Bitmap(Assets.getBitmapData("assets/image/btn.png"));
		bt.scaleX			= 0.7;
		bt.scaleY			= 0.7;
		wrap.addChild(bt);
		
		var label			= new TextField();
		label.defaultTextFormat = new TextFormat(Assets.getFont("assets/font/CgBernhardtBd.ttf").fontName, 15, 0xffffff, false, false, false, null, null, TextFormatAlign.CENTER, null, null, null, -4);
		label.antiAliasType	= AntiAliasType.ADVANCED;
		label.y				= 13;
		label.width			= 112;
		label.height		= 40;
		label.embedFonts	= true;
		label.selectable	= false;
		label.multiline		= true;
		label.text			= "SOLVE";
		wrap.addChild(label);
		
		// Наведение:
		var wrap2			= new Sprite();
		var bt2				= new Bitmap(Assets.getBitmapData("assets/image/btn_hover.png"));
		bt2.scaleX			= 0.7;
		bt2.scaleY			= 0.7;
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
		wrap2.addChild(label2);
		
		// Установка:
		skin				= wrap;
		skinHover			= wrap2;
		skinPress			= skinHover;
	}
}