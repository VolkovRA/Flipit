package mvc.view.scene;

import motion.Actuate;
import mvc.view.View;
import mvc.view.other.GameTopPanel;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.text.AntiAliasType;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import ui.ResetButton;
import ui.SolveButton;
import ui.SubmitButton;

/**
 * Сцена с основным игровым процессом.
 * @author VolkovRA
 */
class GameScene extends Scene 
{
	// Приват
	private var bg:Bitmap;
	private var panel:GameTopPanel;
	private var hint:TextField;
	private var reset:ResetButton;
	private var submit:SubmitButton;
	private var solve:SolveButton;
	
	/**
	 * Создать сцену основного игрового процесса.
	 * @param	view Главный визуализатор.
	 */
	public function new(view:View) {
		super(view);
		
		// Инициализация
		// Фон:
		bg				= new Bitmap(Assets.getBitmapData("assets/image/bg.png"));
		bg.smoothing	= false;
		addChild(bg);
		
		// Верхняя панель:
		panel			= new GameTopPanel(view);
		panel.game		= view.model.game;
		addChild(panel);
		
		// Подсказка:
		hint					= new TextField();
		hint.defaultTextFormat	= new TextFormat(Assets.getFont("assets/font/CgBernhardtBd.ttf").fontName, 20, 0xffffff);
		hint.antiAliasType		= AntiAliasType.ADVANCED;
		hint.autoSize			= TextFieldAutoSize.CENTER;
		hint.x					= 147;
		hint.y					= 448;
		hint.width				= 350;
		hint.height				= 30;
		hint.embedFonts			= true;
		hint.selectable			= false;
		hint.multiline			= false;
		hint.text				= "flip all the peices to white.";
		addChild(hint);
		
		// Кнопка сброса:
		reset					= new ResetButton();
		reset.x					= 520;
		reset.y					= 424;
		reset.addEventListener(MouseEvent.CLICK, onPressReset);
		addChild(reset);
		
		// Кнопка отправки:
		submit					= new SubmitButton();
		submit.x				= 7;
		submit.y				= 424;
		submit.addEventListener(MouseEvent.CLICK, onPressSubmit);
		addChild(submit);
		
		// Кнопка помощи:
		solve					= new SolveButton();
		solve.x					= reset.x;
		solve.y					= 368;
		solve.addEventListener(MouseEvent.CLICK, onPressSolve);
		addChild(solve);
		
		// События:
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
	}
	
	// ЛИСТЕНЕРЫ
	// Общее:
	private function onAddedToStage(e:Event):Void {
		playAnimation();
	}
	private function onRemovedFromStage(e:Event):Void {
		
	}
	// Кнопки:
	private function onPressReset(e:MouseEvent):Void {
		trace("RESET");
	}
	private function onPressSubmit(e:MouseEvent):Void {
		trace("SUBMIT");
	}
	private function onPressSolve(e:MouseEvent):Void {
		trace("SOLVE");
	}
	
	// ПРИВАТ
	private function playAnimation():Void {
		
		// Сброс:
		Actuate.stop(panel);
		
		// Исходная позиция:
		panel.y = -100;
		
		// Запуск:
		Actuate.tween(panel, 1, { y:0 });
	}
}