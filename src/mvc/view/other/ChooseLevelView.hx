package mvc.view.other;

import mvc.model.data.GameData;
import mvc.model.data.level.LevelData.LevelID;
import mvc.view.AView;
import mvc.view.View;
import openfl.events.Event;
import openfl.events.EventType;
import openfl.events.MouseEvent;
import ui.LevelButton;

/**
 * Панелька отображения игровых уровней.
 * @author VolkovRA
 */
class ChooseLevelView extends AView 
{
	private var arr:Array<LevelButton> = null;
	
	/**
	 * Создать панельку.
	 * @param	view Главная вьюшка.
	 */
	public function new(view:View) {
		super(view);
		
		// События:
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}
	
	// ЛИСТЕНЕРЫ
	private function onAddedToStage(e:Event):Void {
		update();
	}
	private function onPressLevel(e:MouseEvent):Void {
		if (Std.is(e.currentTarget, LevelButton) == false)
			return;
		
		var bt:LevelButton		= e.currentTarget;
		var e:LevelsPanelEvent	= new LevelsPanelEvent(LevelsPanelEvent.CHOOSE);
		e.level					= bt.level.id;
		dispatchEvent(e);
	}
	
	// ПРИВАТ
	private function update():Void {
		
		// Обновление списка.
		// Выгрузка:
		arr = null;
		removeChildren();
		
		// Если нет данных, ничего не сторим:
		var data:GameData = view.model.game.data;
		if (data == null || data.levels.length == 0)
			return;
		
		// Строим список:
		arr = new Array();
		for (level in data.levels) {
			var bt			= new LevelButton();
			bt.level		= level;
			arr.push(bt);
		}
		
		arr.sort(sortLevels);
		
		// Добавление в дисплей лист, позицианирование:
		var i:Int			= 0;
		var x:Float			= 0;
		var y:Float			= 0;
		var size:Float		= 50;
		var padding:Float	= 5;
		var line:Int		= 6;
		var length:Int		= arr.length;
		var oppened:Int		= 1;
		while (i < length) {
			var bt			= arr[i];
			bt.x			= x * (size + padding);
			bt.y			= y * (size + padding);
			bt.enabled		= data.progress.isLevelCompleted(bt.level.id) ? true : (oppened-- > 0 ? true : false);
			addChild(bt);
			
			if (bt.enabled)
				bt.addEventListener(MouseEvent.CLICK, onPressLevel);
			
			if (++x >= line) {
				x = 0;
				y ++;
			}
			
			i ++;
		}
	}
	private function sortLevels(x:LevelButton, y:LevelButton):Int {
		if (x.level.num > y.level.num)
			return 1;
		if (x.level.num < y.level.num)
			return -1;
		
		if (x.level.id > y.level.id)
			return 1;
		if (x.level.id < y.level.id)
			return -1;
		
		return 0;
	}
}

/**
 * Событие панели выбора уровня.
 * @author VolkovRA
 */
class LevelsPanelEvent extends Event 
{	
	/**
	 * Выбор уровня.
	 * Событие диспетчерезируется, когда пользователь выбирает доступный ему для прохождения игровой уровень.
	 * Параметры события содержат ID выбранного уровня.
	 */
	public static inline var CHOOSE:EventType<LevelsPanelEvent> = "levelsPanelChoose";
	
	/**
	 * ID Выбранного уровня.
	 * Значение используется для событий: LevelsPanelEvent.SELECT.
	 */
	public var level:LevelID;
	
	/**
	 * Создать событие.
	 * @param	type Тип события.
	 */
	public function new(type:String) {
		super(type);
	}
}
