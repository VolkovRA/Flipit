package mvc.view.scene;

import mvc.view.View;
import openfl.events.Event;

/**
 * Сцена с основным игровым процессом.
 * @author VolkovRA
 */
class PlayScene extends Scene 
{
	/**
	 * Создать сцену основного игрового процесса.
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
		trace("PlayScene onAddedToStage");
	}
	private function onRemovedFromStage(e:Event):Void {
		trace("PlayScene onRemovedFromStage");
	}
}