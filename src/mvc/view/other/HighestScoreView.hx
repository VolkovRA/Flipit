package mvc.view.other;

import mvc.view.AView;
import mvc.view.View;
import motion.Actuate;
import motion.easing.Linear;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.text.AntiAliasType;
import openfl.text.TextFieldAutoSize;
import openfl.filters.DropShadowFilter;
import openfl.media.Sound;
import openfl.events.MouseEvent;
import openfl.display.LineScaleMode;
import ui.Button;

/**
 * Панелька с рекордом.
 * @author VolkovRA
 */
class HighestScoreView extends AView 
{
	// Приват
	// Содержимое:
	private var bg:Bitmap;
	private var label:TextField;
	private var score:TextField;
	private var reset:Button;
	private var circle:Sprite;
	// Звуки:
	private var mOver:Sound;
	
	/**
	 * Создать панельку с рекордом.
	 * @param	view Главная вьюшка.
	 */
	public function new(view:View) {
		super(view);
		
		// Построение.
		// Пиликалка:
		mOver				= Assets.getSound("assets/sound/mouse_over.mp3");
		
		// Фон:
		bg					= new Bitmap(Assets.getBitmapData("assets/image/panel.png"));
		bg.x				= -2; // skin shadow
		bg.y				= -1;
		addChild(bg);
		
		// Кружок:
		circle				= new Sprite();
		circle.graphics.lineStyle(2, 0xffff00, 1, false, LineScaleMode.NONE);
		circle.graphics.drawCircle(0, 0, 46);
		circle.x			= 91;
		circle.y			= 46;
		circle.visible		= false;
		addChild(circle);
		
		// Текст:
		label				= new TextField();
		label.defaultTextFormat = new TextFormat(Assets.getFont("assets/font/CgBernhardtBd.ttf").fontName, 13, 0xffffff, false, false, false, null, null, TextFormatAlign.CENTER);
		label.antiAliasType	= AntiAliasType.ADVANCED;
		label.y				= 4;
		label.width			= 190;
		label.height		= 28;
		//label.sharpness		= 0;
		// label.thickness = -100; // Not support?
		label.embedFonts	= true;
		label.selectable	= false;
		label.multiline		= false;
		label.text			= "YOU HIGHEST SCORE";
		addChild(label);
		
		// Очки:
		score				= new TextField();
		score.defaultTextFormat = new TextFormat(Assets.getFont("assets/font/CgBernhardtBd.ttf").fontName, 37, 0xffffff, false, false, false, null, null, TextFormatAlign.CENTER);
		score.antiAliasType	= AntiAliasType.ADVANCED;
		score.y				= 18;
		score.width			= 190;
		score.height		= 50;
		score.embedFonts	= true;
		score.selectable	= false;
		score.multiline		= false;
		score.filters		= [new DropShadowFilter(4, 45, 0, 0.7, 3, 3, 1)];
		addChild(score);
		
		// Сбросить:
		var skin			= new TextField();
		skin.defaultTextFormat = new TextFormat(Assets.getFont("assets/font/CgBernhardtBd.ttf").fontName, 13, 0x999999, false, false, false, null, null, TextFormatAlign.CENTER);
		skin.antiAliasType	= AntiAliasType.ADVANCED;
		skin.autoSize		= TextFieldAutoSize.CENTER;
		skin.y				= 63;
		skin.width			= 190;
		skin.height			= 28;
		skin.embedFonts		= true;
		skin.selectable		= false;
		skin.multiline		= false;
		skin.text			= "RESET SCORE";
		skin.filters		= [new DropShadowFilter(4, 45, 0, 0.7, 3, 3, 1)];
		
		var skinHover		= new TextField();
		skinHover.defaultTextFormat = new TextFormat(Assets.getFont("assets/font/CgBernhardtBd.ttf").fontName, 13, 0xffff00, false, false, false, null, null, TextFormatAlign.CENTER);
		skinHover.antiAliasType	= AntiAliasType.ADVANCED;
		skinHover.autoSize	= skin.autoSize;
		skinHover.y			= skin.y;
		skinHover.x			= skin.x;
		skinHover.width		= skin.width;
		skinHover.height	= skin.height;
		skinHover.embedFonts = skin.embedFonts;
		skinHover.selectable = skin.selectable;
		skinHover.multiline	= skin.multiline;
		skinHover.text		= skin.text;
		skinHover.filters	= [new DropShadowFilter(4, 45, 0, 0.7, 3, 3, 1)];
		
		reset				= new Button();
		reset.skin			= skin;
		reset.skinHover		= skinHover;
		reset.skinPress		= skinHover;
		reset.addEventListener(MouseEvent.MOUSE_OVER, onResetHover);
		reset.addEventListener(MouseEvent.CLICK, onResetClick);
		addChild(reset);
		
		// События:
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
	}
	
	// ЛИСТЕНЕРЫ
	// Общие:
	private function onAddedToStage(e:Event):Void {
		updateScore();
	}
	private function onRemovedFromStage(e:Event):Void {
		
	}
	// Сброс:
	private function onResetHover(e:MouseEvent):Void {
		mOver.play();
	}
	private function onResetClick(e:MouseEvent):Void {
		trace("Reset!");
		
		circle.visible	= true;
		circle.scaleX	= 1;
		circle.scaleY	= 1;
		
		Actuate.stop(circle);
		Actuate.tween(circle, 0.16, { scaleX:0, scaleY:0 })
			.onComplete(function(obj:Sprite){ obj.visible = false; }, [circle])
			.ease(Linear.easeNone);
	}
	
	// ПРИВАТ
	private function updateScore():Void {
		score.text = "0";
	}
}