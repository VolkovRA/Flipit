package mvc.view.scene;

import mvc.view.View;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.Assets;

/**
 * Сцена с главным игровым меню.
 * @author VolkovRA
 */
class MenuScene extends Scene 
{
	// Приват:
	private var bg:Bitmap;
	
	/**
	 * Создать сцену с главным игровым меню.
	 * @param	view Главный визуализатор.
	 */
	public function new(view:View) {
		super(view);
		
		// Инициализация
		// Фон:
		bg = new Bitmap(Assets.getBitmapData("assets/image/preview.png"));
		addChild(bg);
		
		// События:
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
	}
	
	// ЛИСТЕНЕРЫ
	private function onAddedToStage(e:Event):Void {
		trace("MenuScene onAddedToStage");
	}
	private function onRemovedFromStage(e:Event):Void {
		trace("MenuScene onRemovedFromStage");
	}
}