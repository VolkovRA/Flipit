package mvc.view.scene;

import js.Browser;
import motion.Actuate;
import mvc.view.View;
import mvc.view.other.BoardView;
import mvc.view.other.GameTopPanel;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.text.AntiAliasType;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import mvc.model.game.GameState;
import ui.ResetButton;
import ui.SolveButton;
import ui.SubmitButton;

/**
 * Сцена с основным игровым процессом.
 * @author VolkovRA
 */
class GameScene extends Scene 
{
	static private var PANEL:Dynamic;
	static private var HINT:Dynamic;
	static private var RESET:Dynamic;
	static private var SOLVE:Dynamic;
	static private var SUBMIT:Dynamic;
	
	// Приват
	// Содержимое:
	private var bg:Bitmap;
	private var panel:GameTopPanel;
	private var hint:TextField;
	private var reset:ResetButton;
	private var submit:SubmitButton;
	private var solve:SolveButton;
	private var board:BoardView;
	// Флаги:
	private var isPressedReset:Bool;
	private var isPressedSubmit:Bool;
	
	/**
	 * Создать сцену основного игрового процесса.
	 * @param	view Главный визуализатор.
	 */
	public function new(view:View) {
		super(view);
		
		// Инициализация
		// Разное:
		isPressedReset			= false;
		isPressedSubmit			= false;
		
		// Фон:
		bg						= new Bitmap(Assets.getBitmapData("assets/image/bg.png"));
		bg.smoothing			= false;
		addChild(bg);
		
		// Верхняя панель:
		panel					= new GameTopPanel(view);
		panel.game				= view.model.game;
		addChild(panel);
		PANEL					= { x:panel.x, y:panel.y };
		
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
		HINT					= { x:hint.x, y:hint.y };
		
		// Кнопка сброса:
		reset					= new ResetButton();
		reset.x					= 520;
		reset.y					= 424;
		reset.addEventListener(MouseEvent.CLICK, onPressReset);
		addChild(reset);
		RESET					= { x:reset.x, y:reset.y };
		
		// Кнопка отправки:
		submit					= new SubmitButton();
		submit.x				= 7;
		submit.y				= 424;
		submit.addEventListener(MouseEvent.CLICK, onPressSubmit);
		addChild(submit);
		SUBMIT					= { x:submit.x, y:submit.y };
		
		// Кнопка помощи:
		solve					= new SolveButton();
		solve.x					= reset.x;
		solve.y					= 368;
		solve.addEventListener(MouseEvent.CLICK, onPressSolve);
		addChild(solve);
		SOLVE					= { x: solve.x, y:solve.y };
		
		// Отображалка доски:
		board					= new BoardView(view);
		board.x					= 244;
		board.y					= 202;
		addChild(board);
		
		// События:
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
	}
	
	// ЛИСТЕНЕРЫ
	// Общее:
	private function onAddedToStage(e:Event):Void {
		isPressedReset	= false;
		isPressedSubmit	= false;
		
		board.board = view.model.game.board;
		
		// Анимашки
		// Фейковая, для починки бага:
		view.runFakeAnimation(5);
		
		// Панель:
		Actuate.stop(panel);
		panel.y = -100;
		Actuate.tween(panel, 1, { y:PANEL.y });
		
		// Кнопка Submit:
		Actuate.stop(submit);
		submit.x = SUBMIT.x - 110;
		Actuate.tween(submit, 1, { x:SUBMIT.x });
		
		// Кнопка Reset:
		Actuate.stop(reset);
		reset.x = RESET.x + 110;
		Actuate.tween(reset, 1, { x:RESET.x });
		
		// Кнопка Solve:
		Actuate.stop(solve);
		solve.x = SOLVE.x + 110;
		Actuate.tween(solve, 1, { x:SOLVE.x });
		
		// Метка:
		Actuate.stop(hint);
		hint.alpha = 0;
		Actuate.tween(hint, 1, { alpha:1 }).delay(2);
		
		// Доска:
		board.playAnimationIn();
	}
	private function onRemovedFromStage(e:Event):Void {
		board.board = null;
	}
	// Кнопки:
	private function onPressReset(e:MouseEvent):Void {
		if (isPressedReset)
			return;
		if (view.model.game.state != GameState.RUNNING)
			return;
		
		isPressedReset	= true;
		
		board.playAnimationOut(onAnimationResetCompleted);
	}
	private function onPressSubmit(e:MouseEvent):Void {
		if (isPressedSubmit)
			return;
		
		isPressedSubmit	= true;
		
		// Анимашки
		// Фейковая, для починки бага:
		view.runFakeAnimation(5);
		
		// Панель:
		Actuate.stop(panel);
		Actuate.tween(panel, 1, { y:-130 });
		
		// Кнопка Submit:
		Actuate.stop(submit);
		Actuate.tween(submit, 1, { x:SUBMIT.x - 130 });
		
		// Кнопка Reset:
		Actuate.stop(reset);
		Actuate.tween(reset, 1, { x:RESET.x + 130 });
		
		// Кнопка Solve:
		Actuate.stop(solve);
		Actuate.tween(solve, 1, { x:SOLVE.x + 130 });
		
		// Метка:
		Actuate.stop(hint);
		Actuate.tween(hint, 1, { alpha:0 });
		
		// Доска:
		board.stopAnimation();
		board.playAnimationOut(onAnimationSubmitCompleted);
	}
	private function onPressSolve(e:MouseEvent):Void {
		Browser.alert("Эта функция появится в следующей версии игры!");
	}
	// Анимаций:
	private function onAnimationResetCompleted(board:BoardView):Void {
		this.isPressedReset = false;
		this.view.model.game.reset();
		this.board.playAnimationIn();
	}
	private function onAnimationSubmitCompleted(board:BoardView):Void {
		this.view.game.showGameOver();
	}
}