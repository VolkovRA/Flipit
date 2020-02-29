package mvc.view.other;

import motion.Actuate;
import motion.easing.Back;
import mvc.model.game.Game;
import mvc.view.AView;
import mvc.view.View;
import openfl.Assets;
import openfl.filters.GlowFilter;
import openfl.media.Sound;
import openfl.text.AntiAliasType;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import ui.LevelComplete;

/**
 * Анимация завершения уровня.
 * @author VolkovRA
 */
class LevelCompletedView extends AView 
{
	/**
	 * Отображаемая игра.
	 * Установите в свойство отображаемый экземпляр игры.
	 * По умолчанию: null.
	 */
	public var game(default, set):Game = null;
	
	// Приват
	private var popup:LevelComplete;
	private var bonusLevel:TextField;
	private var bonusFlip:TextField;
	private var sound:Sound;
	
	public function new(view:View) {
		super(view);
		
		// Построение
		// Разное:
		visible							= false;
		
		// Перделка:
		sound							= Assets.getSound("assets/sound/level_complete.mp3");
		
		// Бонус за уровень:
		bonusLevel						= new TextField();
		bonusLevel.defaultTextFormat	= new TextFormat(Assets.getFont("assets/font/Pixelyn.ttf").fontName, 20, 0x0);
		bonusLevel.antiAliasType		= AntiAliasType.ADVANCED;
		bonusLevel.autoSize				= TextFieldAutoSize.LEFT;
		bonusLevel.x					= 0;
		bonusLevel.y					= 89;
		bonusLevel.embedFonts			= true;
		bonusLevel.selectable			= false;
		bonusLevel.multiline			= false;
		bonusLevel.text					= "LEVEL BONUS: " + Std.string(Game.BONUS_LEVEL_COMPLETED);
		bonusLevel.filters				= [new GlowFilter(0xffffff, 1, 6, 6, 4)];
		addChild(bonusLevel);
		
		// Бонус за ходы:
		bonusFlip						= new TextField();
		bonusFlip.defaultTextFormat		= new TextFormat(Assets.getFont("assets/font/Pixelyn.ttf").fontName, 20, 0xffffff);
		bonusFlip.antiAliasType			= AntiAliasType.ADVANCED;
		bonusFlip.autoSize				= TextFieldAutoSize.LEFT;
		bonusFlip.x						= 0;
		bonusFlip.y						= bonusLevel.y + 17;
		bonusFlip.embedFonts			= true;
		bonusFlip.selectable			= false;
		bonusFlip.multiline				= false;
		addChild(bonusFlip);
		
		// Панелька:
		popup							= new LevelComplete();
		popup.x							= 319;
		popup.y							= 253;
		addChild(popup);
	}
	
	// ПАБЛИК
	/**
	 * Запустить анимацию пройденного уровня.
	 * Если какая-то анимация уже воспроизводится - она прекращается а её предыдущий колбек затирается.
	 * @param	callback Функция обратного вызова после завершения анимации.
	 */
	public function playAnimation(callback:LevelCompletedView->Void = null):Void {
		sound.play();
		
		// Сброс:
		Actuate.stop(popup);
		Actuate.stop(bonusFlip);
		Actuate.stop(bonusLevel);
		
		// Начальные позиций:
		visible							= true;
		
		popup.scaleX					= 0.1;
		popup.scaleY					= 0.1;
		popup.alpha						= 0;
		
		bonusFlip.x						= Settings.DEFAULT_WIDTH + 10;
		bonusFlip.text					= "FLIP BONUS: " + Std.string(game == null ? "--" : game.bonus);
		
		bonusLevel.x					= Settings.DEFAULT_WIDTH + 10;
		
		// Анимашки:
		Actuate.tween(bonusLevel, 0.7, { x:Settings.DEFAULT_WIDTH - bonusLevel.width - 16 }).ease(Back.easeOut).onComplete(function(){
			Actuate.tween(popup, 0.5, { scaleX:1, scaleY:1, alpha:1 }).ease(Back.easeOut);
			Actuate.tween(bonusFlip, 0.7, { x:Settings.DEFAULT_WIDTH - bonusFlip.width - 16 }).ease(Back.easeOut).onComplete(function(){
				Actuate.tween(popup, 0.5, { scaleX:1.8, scaleY:1.8, alpha:0 }).ease(Back.easeIn).delay(1.5);
				Actuate.tween(bonusLevel, 0.5, { x:Settings.DEFAULT_WIDTH + 10 }).ease(Back.easeIn).delay(1.5);
				Actuate.tween(bonusFlip, 0.5, { x:Settings.DEFAULT_WIDTH + 10 }).ease(Back.easeIn).delay(2).onComplete(function(){
					visible				= false;
					
					if (callback != null)
						callback(this);
				});
			});
		});		
	}
	
	// СЕТТЕРЫ
	function set_game(value:Game):Game {
		if (value == game)
			return value;
		
		game = value;
		
		return value;
	}
}