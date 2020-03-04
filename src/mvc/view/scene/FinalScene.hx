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
 * Финальная сцена завершения всей игры.
 * @author VolkovRA
 */
class FinalScene extends Scene 
{
	// Начальные координаты анимируемых объектов. (Их значения известны только после построения)
	static private var TITLE:Dynamic;
	static private var TITLE2:Dynamic;
	static private var PLAYBT:Dynamic;
	
	// Приват
	// Содержимое:
	private var title:TextField;
	private var title2:TextField;
	private var progress:Sprite;
	private var progressDescr:TextField;
	private var progressScore:TextField;
	private var highest:TextField;
	private var btPlay:PlayButton;
	private var btMore:MoreGamesButton;
	private var bg:Bitmap;
	// Звуки:
	private var sound:Sound;
	
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
		sound			= Assets.getSound("assets/sound/193.mp3");
		
		// Шапка:
		title						= new TextField();
		title.defaultTextFormat		= new TextFormat(Assets.getFont("assets/font/CgBernhardtBd.ttf").fontName, 70, 0x0, false, false, false, null, null, TextFormatAlign.CENTER);
		title.antiAliasType			= AntiAliasType.ADVANCED;
		title.autoSize				= TextFieldAutoSize.CENTER;
		title.x						= 0;
		title.y						= 65;
		title.width					= 640;
		title.height				= 75;
		title.embedFonts			= true;
		title.selectable			= false;
		title.multiline				= false;
		title.text					= "GAME COMPLETE";
		title.setTextFormat(new TextFormat(null, null, 0xffffff), 4);
		addChild(title);
		TITLE						= { x:title.x, y:title.y, width:title.width, height:title.height };
		
		// Приписок:
		title2						= new TextField();
		title2.defaultTextFormat	= new TextFormat(Assets.getFont("assets/font/CgBernhardtBd.ttf").fontName, 30, 0xffffff, false, false, false, null, null, TextFormatAlign.CENTER);
		title2.antiAliasType		= AntiAliasType.ADVANCED;
		title2.autoSize				= TextFieldAutoSize.CENTER;
		title2.x					= 0;
		title2.y					= 135;
		title2.width				= 640;
		title2.height				= 75;
		title2.embedFonts			= true;
		title2.selectable			= false;
		title2.multiline			= false;
		title2.text					= "GREAT! YOU HAVE BEATEN ALL STAGES!";
		title2.setTextFormat(new TextFormat(null, null, 0x0), 6);
		addChild(title2);
		TITLE2						= { x:title2.x, y:title2.y, width:title2.width, height:title2.height };
		
		// Прогресс:
		progress					= new Sprite();
		progress.x					= 320;
		progress.y					= 210;
		addChild(progress);
		
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
		sound.play();
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
		var game				= view.model.game;
		
		// Обновление данных
		// Набранные очки:
		progressScore.text		= Std.string(game.score);
		
		// Максимальный результат:
		highest.text			= "YOUR HIGHEST SCORE: " + Std.string(game.highest);
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
		
		title2.alpha	= 0;
		title2.scaleX	= scale;
		title2.scaleY	= scale;
		title2.x		= (TITLE2.x + TITLE2.width / 2) - (title2.width / 2);
		title2.y		= (TITLE2.y + TITLE2.height / 2) - (title2.height / 2);
		
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
		var a11			= function():Void {		Actuate.tween(title2, 0.4, { x:TITLE2.x, y:TITLE2.y, alpha:1, scaleX:1, scaleY:1 }).ease(Back.easeOut).onComplete(a2); };
		var a1			= function():Void {		Actuate.tween(title, 0.4, { x:TITLE.x, y:TITLE.y, alpha:1, scaleX:1, scaleY:1 }).ease(Back.easeOut).onComplete(a11); };
		
		view.runFakeAnimation(5);
		
		// Запускаем:
		a1();
	}
}