package mvc.view.other;

import mvc.model.game.Game;
import mvc.model.game.GameEvent;
import mvc.view.AView;
import mvc.view.View;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.filters.DropShadowFilter;
import openfl.media.Sound;
import openfl.text.AntiAliasType;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

/**
 * Верхняя панель в основной игре.
 * @author VolkovRA
 */
class GameTopPanel extends AView 
{
	/**
	 * Отображаемая игра.
	 * Установите в свойство отображаемый экземпляр игры.
	 * По умолчанию: null.
	 */
	public var game(default, set):Game = null;
	
	// Приват
	private var level:TextField;
	private var bonus:TextField;
	private var score:TextField;
	private var flips:TextField;
	private var levelTitle:TextField;
	private var bonusTitle:TextField;
	private var scoreTitle:TextField;
	private var flipsTitle:TextField;
	private var bonusZero:Sound;
	private var bg:Bitmap;
	
	/**
	 * Создать игровую панель.
	 * @param	view Главная вьюшка.
	 */
	public function new(view:View) {
		super(view);
		
		// Построение
		// Звук:
		bonusZero						= Assets.getSound("assets/sound/bonus_out.mp3");
		
		// Фон:
		bg								= new Bitmap(Assets.getBitmapData("assets/image/head.png"));
		addChild(bg);
		
		// Уровень
		// Метка:
		levelTitle						= new TextField();
		levelTitle.defaultTextFormat	= new TextFormat(Assets.getFont("assets/font/Pixelyn.ttf").fontName, 10, 0xFFCC00);
		levelTitle.antiAliasType		= AntiAliasType.ADVANCED;
		levelTitle.autoSize				= TextFieldAutoSize.CENTER;
		levelTitle.x					= 195;
		levelTitle.y					= 14;
		levelTitle.embedFonts			= true;
		levelTitle.selectable			= false;
		levelTitle.multiline			= false;
		levelTitle.text					= "LEVEL";
		levelTitle.filters				= [new DropShadowFilter(2, 45, 0, 1.0, 5, 5, 1)];
		addChild(levelTitle);
		
		// Значение:
		level							= new TextField();
		level.defaultTextFormat			= new TextFormat(Assets.getFont("assets/font/CgBernhardtBd.ttf").fontName, 40, 0xFFFFFF);
		level.antiAliasType				= AntiAliasType.ADVANCED;
		level.autoSize					= TextFieldAutoSize.LEFT;
		level.x							= levelTitle.x - 2;
		level.y							= levelTitle.y;
		level.embedFonts				= true;
		level.selectable				= false;
		level.multiline					= false;
		addChild(level);
		
		// Бонус
		// Метка:
		bonusTitle						= new TextField();
		bonusTitle.defaultTextFormat	= new TextFormat(Assets.getFont("assets/font/Pixelyn.ttf").fontName, 10, 0xFFCC00, false, false, false, null, null, TextFormatAlign.CENTER);
		bonusTitle.antiAliasType		= AntiAliasType.ADVANCED;
		bonusTitle.autoSize				= TextFieldAutoSize.CENTER;
		bonusTitle.x					= 268;
		bonusTitle.y					= 14;
		bonusTitle.embedFonts			= true;
		bonusTitle.selectable			= false;
		bonusTitle.multiline			= false;
		bonusTitle.text					= "BONUS";
		bonusTitle.filters				= [new DropShadowFilter(2, 45, 0, 1.0, 5, 5, 1)];
		addChild(bonusTitle);
		
		// Значение:
		bonus							= new TextField();
		bonus.defaultTextFormat			= new TextFormat(Assets.getFont("assets/font/CgBernhardtBd.ttf").fontName, 40, 0xFFFFFF);
		bonus.antiAliasType				= AntiAliasType.ADVANCED;
		bonus.autoSize					= TextFieldAutoSize.LEFT;
		bonus.x							= bonusTitle.x - 2;
		bonus.y							= bonusTitle.y;
		bonus.embedFonts				= true;
		bonus.selectable				= false;
		bonus.multiline					= false;
		addChild(bonus);
		
		// Очки
		// Метка:
		scoreTitle						= new TextField();
		scoreTitle.defaultTextFormat	= new TextFormat(Assets.getFont("assets/font/Pixelyn.ttf").fontName, 10, 0xFFCC00, false, false, false, null, null, TextFormatAlign.CENTER);
		scoreTitle.antiAliasType		= AntiAliasType.ADVANCED;
		scoreTitle.autoSize				= TextFieldAutoSize.CENTER;
		scoreTitle.x					= 564;
		scoreTitle.y					= 14;
		scoreTitle.embedFonts			= true;
		scoreTitle.selectable			= false;
		scoreTitle.multiline			= false;
		scoreTitle.text					= "SCORE";
		scoreTitle.filters				= [new DropShadowFilter(2, 45, 0, 1.0, 5, 5, 1)];
		addChild(scoreTitle);
		
		// Значение:
		score							= new TextField();
		score.defaultTextFormat			= new TextFormat(Assets.getFont("assets/font/CgBernhardtBd.ttf").fontName, 40, 0xFFFFFF);
		score.antiAliasType				= AntiAliasType.ADVANCED;
		score.autoSize					= TextFieldAutoSize.RIGHT;
		score.x							= scoreTitle.x - 72;
		score.y							= scoreTitle.y;
		score.embedFonts				= true;
		score.selectable				= false;
		score.multiline					= false;
		addChild(score);
		
		// Ходы
		// Метка:
		flipsTitle						= new TextField();
		flipsTitle.defaultTextFormat	= new TextFormat(Assets.getFont("assets/font/Pixelyn.ttf").fontName, 10, 0xFFCC00, false, false, false, null, null, TextFormatAlign.CENTER);
		flipsTitle.antiAliasType		= AntiAliasType.ADVANCED;
		flipsTitle.autoSize				= TextFieldAutoSize.CENTER;
		flipsTitle.x					= 270;
		flipsTitle.y					= 79;
		flipsTitle.embedFonts			= true;
		flipsTitle.selectable			= false;
		flipsTitle.multiline			= false;
		flipsTitle.text					= "FLIPS";
		flipsTitle.filters				= [new DropShadowFilter(2, 45, 0, 1.0, 5, 5, 1)];
		addChild(flipsTitle);
		
		// Значение:
		flips							= new TextField();
		flips.defaultTextFormat			= new TextFormat(Assets.getFont("assets/font/CgBernhardtBd.ttf").fontName, 30, 0xFFFFFF);
		flips.antiAliasType				= AntiAliasType.ADVANCED;
		flips.autoSize					= TextFieldAutoSize.LEFT;
		flips.x							= flipsTitle.x - 1;
		flips.y							= flipsTitle.y + 1;
		flips.embedFonts				= true;
		flips.selectable				= false;
		flips.multiline					= false;
		addChild(flips);
		
		// События:
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
	}
	
	// ЛИСТЕНЕРЫ
	// Общее:
	private function onAddedToStage(e:Event):Void {
		if (game != null)
			addGameListeners(game);
		
		update();
	}
	private function onRemovedFromStage(e:Event):Void {
		if (game != null)
			removeGameListeners(game);
	}
	// Игра:
	private function onGameFlips(e:GameEvent):Void {
		update();
	}
	private function onGameScore(e:GameEvent):Void {
		update();
	}
	private function onGameBonus(e:GameEvent):Void {
		update();
		
		if (game != null && game.bonus == 0)
			bonusZero.play();
	}
	
	// ПРИВАТ
	private function update():Void {
		if (game == null) {
			level.text		= "--";
			score.text		= "--";
			bonus.text		= "--";
			flips.text		= "--";
		}
		else {
			var levelData = game.data.levels.getItemByID(game.level);
			
			level.text		= levelData == null ? "--" : Std.string(levelData.num);
			score.text		= Std.string(game.score);
			bonus.text		= Std.string(game.bonus);
			flips.text		= Std.string(game.flips);
		}
	}
	private function addGameListeners(game:Game):Void {
		game.addEventListener(GameEvent.BONUS, onGameBonus);
		game.addEventListener(GameEvent.FLIPS, onGameFlips);
		game.addEventListener(GameEvent.SCORE, onGameScore);
	}
	private function removeGameListeners(game:Game):Void {
		game.removeEventListener(GameEvent.BONUS, onGameBonus);
		game.removeEventListener(GameEvent.FLIPS, onGameFlips);
		game.removeEventListener(GameEvent.SCORE, onGameScore);
	}
	
	// СЕТТЕРЫ
	function set_game(value:Game):Game {
		if (value == game)
			return value;
		
		if (stage == null) {
			game = value;
		}
		else {
			if (game != null)
				removeGameListeners(game);
			
			game = value;
			
			if (game != null)
				addGameListeners(game);
		}
		
		return value;
	}
}