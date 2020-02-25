package mvc.view.scene;

import js.Browser;
import motion.Actuate;
import motion.easing.Back;
import mvc.view.View;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.filters.DropShadowFilter;
import openfl.media.Sound;
import openfl.text.AntiAliasType;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import ui.MoreGamesButton;
import ui.PlayButton;

/**
 * Сцена завершения игры.
 * @author VolkovRA
 */
class GameOverScene extends Scene 
{
	// Начальные координаты анимируемых объектов. (Их значения известны только после построения)
	static private var TITLE:StartPos;
	static private var PLAYBT:StartPos;
	
	// Приват
	// Содержимое:
	private var title:TextField;
	private var progress:Sprite;
	private var progressLevel:TextField;
	private var progressDescr:TextField;
	private var progressScore:TextField;
	private var highest:TextField;
	private var btPlay:PlayButton;
	private var btMore:MoreGamesButton;
	private var bg:Bitmap;
	// Звуки:
	private var gameOverSound:Sound;
	
	/**
	 * Создать сцену завершения игры.
	 * @param	view Главный визуализатор.
	 */
	public function new(view:View) {
		super(view);
		
		// Инициализация
		// Фон:
		bg				= new Bitmap(Assets.getBitmapData("assets/image/bg.png"));
		bg.smoothing	= false;
		addChild(bg);
		
		// Звуки:
		gameOverSound	= Assets.getSound("assets/sound/game_over.mp3");
		
		// Шапка:
		title						= new TextField();
		title.defaultTextFormat		= new TextFormat(Assets.getFont("assets/font/CgBernhardtBd.ttf").fontName, 70, 0x0, false, false, false, null, null, TextFormatAlign.CENTER);
		title.antiAliasType			= AntiAliasType.ADVANCED;
		title.autoSize				= TextFieldAutoSize.CENTER;
		title.x						= 0;
		title.y						= 75;
		title.width					= 640;
		title.height				= 75;
		title.embedFonts			= true;
		title.selectable			= false;
		title.multiline				= false;
		title.text					= "GAME OVER";
		title.setTextFormat(new TextFormat(null, null, 0xffffff), 5);
		addChild(title);
		TITLE						= { x:title.x, y:title.y, width:title.width, height:title.height };
		
		// Прогресс:
		progress					= new Sprite();
		progress.x					= 320;
		progress.y					= 200;
		addChild(progress);
		
		// Прогресс - уровень:
		progressLevel					= new TextField();
		progressLevel.defaultTextFormat = new TextFormat(Assets.getFont("assets/font/CgBernhardtBd.ttf").fontName, 25, 0x0);
		progressLevel.antiAliasType		= AntiAliasType.ADVANCED;
		progressLevel.autoSize			= TextFieldAutoSize.CENTER;
		progressLevel.x					= -200;
		progressLevel.y					= -46;
		progressLevel.width				= 400;
		progressLevel.height			= 30;
		progressLevel.embedFonts		= true;
		progressLevel.selectable		= false;
		progressLevel.multiline			= false;
		progress.addChild(progressLevel);
		
		// Прогресс - описание:
		progressDescr					= new TextField();
		progressDescr.defaultTextFormat = new TextFormat(Assets.getFont("assets/font/CgBernhardtBd.ttf").fontName, 25, 0xffffff);
		progressDescr.antiAliasType		= AntiAliasType.ADVANCED;
		progressDescr.autoSize			= TextFieldAutoSize.CENTER;
		progressDescr.x					= -200;
		progressDescr.y					= -9;
		progressDescr.width				= 400;
		progressDescr.height			= 30;
		progressDescr.embedFonts		= true;
		progressDescr.selectable		= false;
		progressDescr.multiline			= false;
		progressDescr.text				= "Final Score:";
		progressDescr.filters			= [new DropShadowFilter(7, 45, 0, 0.7, 6, 6, 1)];
		progress.addChild(progressDescr);
		
		// Прогресс - очки:
		progressScore					= new TextField();
		progressScore.defaultTextFormat = new TextFormat(Assets.getFont("assets/font/CgBernhardtBd.ttf").fontName, 70, 0xffffff);
		progressScore.antiAliasType		= AntiAliasType.ADVANCED;
		progressScore.autoSize			= TextFieldAutoSize.CENTER;
		progressScore.x					= -200;
		progressScore.y					= 9;
		progressScore.width				= 400;
		progressScore.height			= 30;
		progressScore.embedFonts		= true;
		progressScore.selectable		= false;
		progressScore.multiline			= false;
		progressScore.filters			= [new DropShadowFilter(7, 45, 0, 0.8, 5, 5, 1)];
		progress.addChild(progressScore);
		
		// Максимальный рекорд:
		highest							= new TextField();
		highest.defaultTextFormat		= new TextFormat(Assets.getFont("assets/font/CgBernhardtBd.ttf").fontName, 15, 0xffffff);
		highest.antiAliasType			= AntiAliasType.ADVANCED;
		highest.autoSize				= TextFieldAutoSize.CENTER;
		highest.x						= 0;
		highest.y						= 448;
		highest.width					= 640;
		highest.height					= 30;
		highest.embedFonts				= true;
		highest.selectable				= false;
		highest.multiline				= false;
		highest.filters					= [new DropShadowFilter(8, 45, 0, 0.55, 5, 5, 1)];
		addChild(highest);
		
		// Кнопка: "Больше игр":
		btMore				= new MoreGamesButton();
		btMore.x			= 275;
		btMore.y			= 351;
		btMore.addEventListener(MouseEvent.CLICK, onBtMore);
		addChild(btMore);
		
		// Кнопка: "Играть":
		btPlay				= new PlayButton();
		btPlay.scaleX		= btPlay.scaleY = 1.1;
		btPlay.x			= 426;
		btPlay.y			= 354;
		btPlay.addEventListener(MouseEvent.CLICK, onBtPlay);
		addChild(btPlay);
		PLAYBT				= { x:btPlay.x, y:btPlay.y, width:btPlay.width, height:btPlay.height };
		
		// События:
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
	}
	
	// ЛИСТЕНЕРЫ
	// Общее:
	private function onAddedToStage(e:Event):Void {
		gameOverSound.play();
		update();
		playAnimation();
	}
	private function onRemovedFromStage(e:Event):Void {
		
	}
	// Кнопки:
	private function onBtPlay(e:MouseEvent):Void {
		view.game.showChooseLevel();
	}
	private function onBtMore(e:MouseEvent):Void {
		Browser.window.open(Settings.URL_MORE_GAMES, "_blank");
	}
	
	// ПРИВАТ
	private function update():Void {
		
		// Обновление данных
		// Достигнутый уровень:
		progressLevel.text		= "LEVEL: 1";
		progressLevel.setTextFormat(new TextFormat(null, null, 0xffffff), 6);
		
		// Набранные очки:
		progressScore.text		= "0";
		
		// Максимальный результат:
		highest.text			= "YOUR HIGHEST SCORE: 0";
	}
	private function playAnimation():Void {
		
		// Сброс:
		Actuate.stop(btPlay);
		Actuate.stop(highest);
		Actuate.stop(progress);
		Actuate.stop(title);
		
		// Начальные параметры:
		var scale		= 2;
		title.alpha		= 0;
		title.scaleX	= scale;
		title.scaleY	= scale;
		title.x			= (TITLE.x + TITLE.width / 2) - (title.width / 2);
		title.y			= (TITLE.y + TITLE.height / 2) - (title.height / 2);
		
		progress.alpha	= 0;
		
		highest.alpha	= 0;
		
		btPlay.visible	= false;
		btPlay.alpha	= 0;
		btPlay.scaleX	= scale;
		btPlay.scaleY	= scale;
		btPlay.x		= (PLAYBT.x + PLAYBT.width / 2) - (btPlay.width / 2);
		btPlay.y		= (PLAYBT.y + PLAYBT.height / 2) - (btPlay.height / 2);
		
		// Анимашки: ^.^
		var a4			= function():Void {		Actuate.tween(btPlay, 0.4, { x:PLAYBT.x, y:PLAYBT.y, alpha:1, scaleX:1, scaleY:1 }).ease(Back.easeOut); btPlay.visible = true; };
		var a3			= function():Void {		Actuate.tween(highest, 0.4, { alpha:1 }); a4(); };
		var a2			= function():Void {		Actuate.tween(progress, 0.7, { alpha:1 }).onComplete(a3); };
		var a1			= function():Void {		Actuate.tween(title, 0.4, { x:TITLE.x, y:TITLE.y, alpha:1, scaleX:1, scaleY:1 }).ease(Back.easeOut).onComplete(a2); };
		
		view.runFakeAnimation(5);
		
		// Запускаем:
		a1();
	}
}
typedef StartPos = {
	var x:Float;
	var y:Float;
	var width:Float;
	var height:Float;
}