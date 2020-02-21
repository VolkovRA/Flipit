package mvc.view.scene;

import js.Browser;
import motion.Actuate;
import mvc.view.View;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.events.MouseEvent;
import openfl.media.Sound;
import ui.ButtonHowPlay;
import ui.ButtonLabel;
import ui.ButtonMoreGames;

/**
 * Сцена с главным игровым меню.
 * @author VolkovRA
 */
class MenuScene extends Scene 
{
	static private inline var FAQ_Y:Float = -330;
	
	// Приват
	// Содержимое:
	private var logo:Bitmap;
	private var btPlay:ButtonLabel;
	private var btMore:ButtonMoreGames;
	private var btHow:ButtonHowPlay;
	private var faq:Bitmap;
	private var bg:Bitmap;
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
		btMore				= new ButtonMoreGames();
		btMore.x			= 276;
		btMore.y			= 383;
		btMore.addEventListener(MouseEvent.CLICK, onBtMore);
		addChild(btMore);
		
		// Кнопка: "Играть":
		btPlay				= new ButtonLabel();
		btPlay.x			= 458;
		btPlay.y			= 385;
		btPlay.addEventListener(MouseEvent.CLICK, onBtPlay);
		btPlay.addEventListener(MouseEvent.MOUSE_OVER, onBtPlayOver);
		addChild(btPlay);
		
		// Кнопка: "Как играть?":
		btHow				= new ButtonHowPlay();
		btHow.addEventListener(MouseEvent.MOUSE_OVER, onBtHowOver);
		btHow.addEventListener(MouseEvent.MOUSE_OUT, onBtHowOut);
		addChild(btHow);
		
		// FAQ:
		faq					= new Bitmap(Assets.getBitmapData("assets/image/help.png"));
		faq.y				= FAQ_Y;
		addChild(faq);
	}
	
	// ЛИСТЕНЕРЫ
	// Кнопки:
	private function onBtPlay(e:MouseEvent):Void {
		trace("Play");
	}
	private function onBtPlayOver(e:MouseEvent):Void {
		mOver.play();
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
		Browser.window.open("https://studionx.ru/", "_blank");
	}
}