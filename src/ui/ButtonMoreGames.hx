package ui;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;

/**
 * Кнопка - больше игр.
 * @author VolkovRA
 */
class ButtonMoreGames extends Button 
{
	/**
	 * Создать кнопку.
	 */
	public function new() {
		super();
		
		var sensor		= new Sprite();
		sensor.alpha	= 0;
		sensor.graphics.beginFill(0xff0000);
		sensor.graphics.drawRect(4, 4, 129, 69);
		addChild(sensor);
		
		hitArea			= sensor;
		mouseEnabled	= false;
		skinWrap.mouseEnabled = false;
		
		skin			= new Bitmap(Assets.getBitmapData("assets/image/btn_games.png"));
		skinHover		= new Bitmap(Assets.getBitmapData("assets/image/btn_games_hover.png"));
		skinPress		= new Bitmap(Assets.getBitmapData("assets/image/btn_games_hover.png"));
	}
}