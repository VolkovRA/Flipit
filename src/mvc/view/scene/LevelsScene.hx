package mvc.view.scene;

import mvc.view.View;
import openfl.events.Event;

/**
 * Сцена выбора игрового уровня.
 * @author VolkovRA
 */
class LevelsScene extends Scene 
{
	/**
	 * Создать сцену выбора игрового уровня.
	 * @param	view Главный визуализатор.
	 */
	public function new(view:View) {
		super(view);
		
		// События:
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
	}
	
	// ЛИСТЕНЕРЫ
	private function onAddedToStage(e:Event):Void {
		trace("LevelsScene onAddedToStage");
	}
	private function onRemovedFromStage(e:Event):Void {
		trace("LevelsScene onRemovedFromStage");
	}
}