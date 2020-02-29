package ui;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.text.AntiAliasType;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

/**
 * Панелька с текстом: "Level complete"
 * @author VolkovRA
 */
class LevelComplete extends Sprite 
{
	private var label:TextField;
	
	public function new() {
		super();
		
		var bg = new Bitmap(Assets.getBitmapData("assets/image/level_complete.png"));
		bg.x							= -119;
		bg.y							= -53;
		addChild(bg);
		
		label							= new TextField();
		label.defaultTextFormat			= new TextFormat(Assets.getFont("assets/font/CgBernhardtBd.ttf").fontName, 40, 0xFFFFFF, null, null, null, null, null, TextFormatAlign.CENTER, null, null, null, -10);
		label.antiAliasType				= AntiAliasType.ADVANCED;
		label.width						= 238;
		label.height					= 80;
		label.x							= -119;
		label.y							= -44;
		label.embedFonts				= true;
		label.selectable				= false;
		label.multiline					= true;
		label.text						= "LEVEL\nCOMPLETE";
		addChild(label);
	}
}