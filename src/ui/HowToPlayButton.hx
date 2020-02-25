package ui;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;

/**
 * Кнопка "Как играть?"
 * @author VolkovRA
 */
class HowToPlayButton extends Button 
{
	
	/**
	 * Создать кнопку.
	 */
	public function new() {
		super();
		
		var sensor		= new Sprite();
		sensor.alpha	= 0;
		sensor.graphics.beginFill(0xff0000);
		sensor.graphics.lineTo(143, 0);
		sensor.graphics.lineTo(0, 110);
		sensor.graphics.lineTo(0, 0);
		addChild(sensor);
		
		hitArea			= sensor;
		mouseEnabled	= false;
		skinWrap.mouseEnabled = false;
		
		skin			= new Bitmap(Assets.getBitmapData("assets/image/how_to_play.png"));
	}
}