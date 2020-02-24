package mvc.view.scene;

import mvc.view.View;
import mvc.view.level.LevelsPanel;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.text.AntiAliasType;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

/**
 * Сцена выбора игрового уровня.
 * @author VolkovRA
 */
class LevelsScene extends Scene 
{
	// Приват
	private var title:TextField;
	private var descr:TextField;
	private var footer:TextField;
	private var levels:LevelsPanel;
	private var bg:Bitmap;
	
	/**
	 * Создать сцену выбора игрового уровня.
	 * @param	view Главный визуализатор.
	 */
	public function new(view:View) {
		super(view);
		
		// Инициализация
		// Фон:
		bg					= new Bitmap(Assets.getBitmapData("assets/image/bg.png"));
		bg.smoothing		= false;
		addChild(bg);
		
		// Шапка:
		title				= new TextField();
		title.defaultTextFormat = new TextFormat(Assets.getFont("assets/font/CgBernhardtBd.ttf").fontName, 60, 0x0, false, false, false, null, null, TextFormatAlign.CENTER);
		title.antiAliasType= AntiAliasType.ADVANCED;
		title.x				= 0;
		title.y				= 31;
		title.width			= 640;
		title.height		= 60;
		title.embedFonts	= true;
		title.selectable	= false;
		title.multiline		= false;
		title.text			= "CHOOSE LEVEL";
		title.setTextFormat(new TextFormat(null, null, 0xffffff), 6);
		addChild(title);
		
		// Описание:
		descr				= new TextField();
		descr.defaultTextFormat = new TextFormat(Assets.getFont("assets/font/CgBernhardtBd.ttf").fontName, 20, 0x0, false, false, false, null, null, TextFormatAlign.CENTER);
		descr.antiAliasType= AntiAliasType.ADVANCED;
		descr.x				= 0;
		descr.y				= 99;
		descr.width			= 640;
		descr.height		= 30;
		descr.embedFonts	= true;
		descr.selectable	= false;
		descr.multiline		= false;
		descr.text			= "YOU MUST HAVE BEEN TO A LEVEL TO UNLOCK IT";
		descr.setTextFormat(new TextFormat(null, null, 0xffffff), 0, 29);
		addChild(descr);
		
		// Подвал:
		footer				= new TextField();
		footer.defaultTextFormat = new TextFormat(Assets.getFont("assets/font/CgBernhardtBd.ttf").fontName, 17, 0xFFFFFF, false, false, false, null, null, TextFormatAlign.CENTER);
		footer.antiAliasType= AntiAliasType.ADVANCED;
		footer.x			= 0;
		footer.y			= 442;
		footer.width		= 640;
		footer.height		= 30;
		footer.embedFonts	= true;
		footer.selectable	= false;
		footer.multiline	= false;
		footer.text			= "WHITE TILES ARE UNLOCKED LEVELS";
		addChild(footer);
		
		// Уровни:
		levels				= new LevelsPanel(view);
		levels.x			= 154;
		levels.y			= 154;
		levels.addEventListener(LevelsPanelEvent.CHOOSE, onLevelChoose);
		addChild(levels);
	}
	
	// ЛИСТЕНЕРЫ
	private function onLevelChoose(e:LevelsPanelEvent):Void {
		trace("Select level ID=" + e.level);
	}
}