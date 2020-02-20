package mvc.view.scene;

import mvc.view.View;
import openfl.events.Event;

/**
 * Сцена завершения игры.
 * @author VolkovRA
 */
class EndScene extends Scene 
{
	/**
	 * Создать сцену завершения игры.
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
		trace("EndScene onAddedToStage");
	}
	private function onRemovedFromStage(e:Event):Void {
		trace("EndScene onRemovedFromStage");
	}
}