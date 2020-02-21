package ui;

import openfl.display.Bitmap;
import openfl.Assets;

/**
 * Кнопка с текстом.
 * @author VolkovRA
 */
class ButtonLabel extends Button 
{
	
	/**
	 * Создать кнопку с текстом.
	 */
	public function new() {
		super();
		
		skin			= new Bitmap(Assets.getBitmapData("assets/image/btn.png"));
		skinHover		= new Bitmap(Assets.getBitmapData("assets/image/btn_hover.png"));
		skinPress		= new Bitmap(Assets.getBitmapData("assets/image/btn_hover.png"));
	}
}