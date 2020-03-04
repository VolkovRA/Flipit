package mvc.view.scene;

import js.Browser;
import motion.Actuate;
import mvc.view.View;
import mvc.view.other.HighestScoreView;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.events.MouseEvent;
import openfl.media.Sound;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.text.AntiAliasType;
import ui.HowToPlayButton;
import ui.PlayButton;
import ui.MoreGamesButton;

/**
 * Сцена с главным игровым меню.
 * @author VolkovRA
 */
class MainMenuScene extends Scene 
{
	static private inline var FAQ_Y:Float = -340;
	
	// Приват
	// Содержимое:
	private var logo:Bitmap;
	private var btPlay:PlayButton;
	private var btMore:MoreGamesButton;
	private var btHow:HowToPlayButton;
	private var score:HighestScoreView;
	private var faq:Bitmap;
	private var bg:Bitmap;
	private var version:TextField;
	// Звуки:
	private var mOver:Sound;
	
	/**
	 * Создать сцену с главным игровым меню.
	 * @param	view Главный визуализатор.
	 */
	public function new(view:View) {
		super(view);
		
		// Инициализация
		// Фон:
		bg					= new Bitmap(Assets.getBitmapData("assets/image/preview.png"));
		bg.smoothing		= false;
		addChild(bg);
		
		// Пиликалка:
		mOver				= Assets.getSound("assets/sound/mouse_over.mp3");
		
		// Лого:
		logo				= new Bitmap(Assets.getBitmapData("assets/image/logo.png"));
		logo.x				= 180;
		logo.y				= 16;
		addChild(logo);
		
		// Кнопка: "Больше игр":
		btMore				= new MoreGamesButton();
		btMore.x			= 272;
		btMore.y			= 379;
		btMore.addEventListener(MouseEvent.CLICK, onBtMore);
		addChild(btMore);
		
		// Кнопка: "Играть":
		btPlay				= new PlayButton();
		btPlay.x			= 457;
		btPlay.y			= 385;
		btPlay.addEventListener(MouseEvent.CLICK, onBtPlay);
		addChild(btPlay);
		
		// Кнопка: "Как играть?":
		btHow				= new HowToPlayButton();
		btHow.addEventListener(MouseEvent.MOUSE_OVER, onBtHowOver);
		btHow.addEventListener(MouseEvent.MOUSE_OUT, onBtHowOut);
		addChild(btHow);
		
		// Панелька с очками:
		score				= new HighestScoreView(view);
		score.x				= 22;
		score.y				= 374;
		addChild(score);
		
		// Версия игры:
		version				= new TextField();
		version.defaultTextFormat = new TextFormat(Assets.getFont("assets/font/Pixelyn.ttf").fontName, 10, 0xffffff, false, false, false, null, null, TextFormatAlign.RIGHT);
		version.antiAliasType= AntiAliasType.ADVANCED;
		version.x			= 533;
		version.y			= 7;
		version.width		= 100;
		version.height		= 30;
		version.embedFonts	= true;
		version.selectable	= false;
		version.multiline	= false;
		version.text		= Settings.VERSION.toString();
		addChild(version);
		
		// FAQ:
		faq					= new Bitmap(Assets.getBitmapData("assets/image/help.png"));
		faq.y				= FAQ_Y;
		addChild(faq);
	}
	
	// ЛИСТЕНЕРЫ
	// Кнопки:
	private function onBtPlay(e:MouseEvent):Void {
		view.game.showChooseLevel();
	}
	private function onBtHowOver(e:MouseEvent):Void {
		mOver.play();
		
		Actuate.stop(faq);
		Actuate.tween(faq, 0.8, { y:0 });
	}
	private function onBtHowOut(e:MouseEvent):Void {
		Actuate.stop(faq);
		Actuate.tween(faq, 0.8, { y:FAQ_Y });
	}
	private function onBtMore(e:MouseEvent):Void {
		Browser.window.open(Settings.URL_MORE_GAMES, "_blank");
	}
}