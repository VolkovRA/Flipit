package;


import haxe.io.Bytes;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_font_cgbernhardtbd_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_font_pixelyn_ttf);
		
		#end

		var data, manifest, library, bundle;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		data = '{"name":null,"assets":"aoy4:pathy29:assets%2Fconfig%2Flevels.jsony4:sizei611y4:typey4:TEXTy2:idR1y7:preloadtgoR0y23:assets%2Fimage%2Fbg.pngR2i711975R3y5:IMAGER5R7R6tgoR0y24:assets%2Fimage%2Fbtn.pngR2i3719R3R8R5R9R6tgoR0y30:assets%2Fimage%2Fbtn_games.pngR2i4688R3R8R5R10R6tgoR0y36:assets%2Fimage%2Fbtn_games_hover.pngR2i4677R3R8R5R11R6tgoR0y30:assets%2Fimage%2Fbtn_hover.pngR2i4424R3R8R5R12R6tgoR0y28:assets%2Fimage%2Fbtn_lvl.pngR2i4472R3R8R5R13R6tgoR0y35:assets%2Fimage%2Fbtn_lvl_closed.pngR2i4226R3R8R5R14R6tgoR0y34:assets%2Fimage%2Fbtn_lvl_hover.pngR2i4669R3R8R5R15R6tgoR0y25:assets%2Fimage%2Fhead.pngR2i7579R3R8R5R16R6tgoR0y25:assets%2Fimage%2Fhelp.pngR2i132788R3R8R5R17R6tgoR0y32:assets%2Fimage%2Fhow_to_play.pngR2i4434R3R8R5R18R6tgoR0y25:assets%2Fimage%2Flogo.pngR2i6216R3R8R5R19R6tgoR0y26:assets%2Fimage%2Fpanel.pngR2i2453R3R8R5R20R6tgoR0y28:assets%2Fimage%2Fpreview.pngR2i728549R3R8R5R21R6tgoR0y29:assets%2Fimage%2Ftile%2F1.pngR2i4801R3R8R5R22R6tgoR0y30:assets%2Fimage%2Ftile%2F10.pngR2i3305R3R8R5R23R6tgoR0y30:assets%2Fimage%2Ftile%2F11.pngR2i4386R3R8R5R24R6tgoR0y30:assets%2Fimage%2Ftile%2F12.pngR2i3726R3R8R5R25R6tgoR0y30:assets%2Fimage%2Ftile%2F13.pngR2i3115R3R8R5R26R6tgoR0y30:assets%2Fimage%2Ftile%2F14.pngR2i3537R3R8R5R27R6tgoR0y30:assets%2Fimage%2Ftile%2F15.pngR2i3676R3R8R5R28R6tgoR0y30:assets%2Fimage%2Ftile%2F16.pngR2i4552R3R8R5R29R6tgoR0y30:assets%2Fimage%2Ftile%2F17.pngR2i4998R3R8R5R30R6tgoR0y30:assets%2Fimage%2Ftile%2F18.pngR2i4480R3R8R5R31R6tgoR0y30:assets%2Fimage%2Ftile%2F19.pngR2i4220R3R8R5R32R6tgoR0y29:assets%2Fimage%2Ftile%2F2.pngR2i3624R3R8R5R33R6tgoR0y30:assets%2Fimage%2Ftile%2F20.pngR2i3813R3R8R5R34R6tgoR0y30:assets%2Fimage%2Ftile%2F21.pngR2i4761R3R8R5R35R6tgoR0y29:assets%2Fimage%2Ftile%2F3.pngR2i3975R3R8R5R36R6tgoR0y29:assets%2Fimage%2Ftile%2F4.pngR2i4614R3R8R5R37R6tgoR0y29:assets%2Fimage%2Ftile%2F5.pngR2i4604R3R8R5R38R6tgoR0y29:assets%2Fimage%2Ftile%2F6.pngR2i4564R3R8R5R39R6tgoR0y29:assets%2Fimage%2Ftile%2F7.pngR2i3728R3R8R5R40R6tgoR0y29:assets%2Fimage%2Ftile%2F8.pngR2i3510R3R8R5R41R6tgoR0y29:assets%2Fimage%2Ftile%2F9.pngR2i3286R3R8R5R42R6tgoR2i11544R3y5:SOUNDR5y24:assets%2Fsound%2F193.mp3y9:pathGroupaR44hR6tgoR2i2652R3R43R5y30:assets%2Fsound%2Fbonus_out.mp3R45aR46hR6tgoR2i5070R3R43R5y30:assets%2Fsound%2Fgame_over.mp3R45aR47hR6tgoR2i11076R3R43R5y26:assets%2Fsound%2Fintro.mp3R45aR48hR6tgoR2i6084R3R43R5y35:assets%2Fsound%2Flevel_complete.mp3R45aR49hR6tgoR2i3276R3R43R5y31:assets%2Fsound%2Fmouse_down.mp3R45aR50hR6tgoR2i2496R3R43R5y31:assets%2Fsound%2Fmouse_over.mp3R45aR51hR6tgoR2i2340R3R43R5y27:assets%2Fsound%2Ftile_1.mp3R45aR52hR6tgoR2i2496R3R43R5y27:assets%2Fsound%2Ftile_2.mp3R45aR53hR6tgoR2i2184R3R43R5y27:assets%2Fsound%2Ftile_3.mp3R45aR54hR6tgoR2i27468R3y4:FONTy9:classNamey38:__ASSET__assets_font_cgbernhardtbd_ttfR5y33:assets%2Ffont%2FCgBernhardtBd.ttfR6tgoR2i21836R3R55R56y32:__ASSET__assets_font_pixelyn_ttfR5y27:assets%2Ffont%2FPixelyn.ttfR6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

		#end

	}


}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_config_levels_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_btn_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_btn_games_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_btn_games_hover_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_btn_hover_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_btn_lvl_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_btn_lvl_closed_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_btn_lvl_hover_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_head_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_help_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_how_to_play_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_logo_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_panel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_preview_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_tile_1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_tile_10_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_tile_11_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_tile_12_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_tile_13_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_tile_14_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_tile_15_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_tile_16_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_tile_17_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_tile_18_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_tile_19_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_tile_2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_tile_20_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_tile_21_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_tile_3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_tile_4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_tile_5_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_tile_6_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_tile_7_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_tile_8_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_image_tile_9_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sound_193_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sound_bonus_out_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sound_game_over_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sound_intro_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sound_level_complete_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sound_mouse_down_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sound_mouse_over_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sound_tile_1_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sound_tile_2_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sound_tile_3_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_font_cgbernhardtbd_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_font_pixelyn_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("assets/config/levels.json") @:noCompletion #if display private #end class __ASSET__assets_config_levels_json extends haxe.io.Bytes {}
@:keep @:image("assets/image/bg.png") @:noCompletion #if display private #end class __ASSET__assets_image_bg_png extends lime.graphics.Image {}
@:keep @:image("assets/image/btn.png") @:noCompletion #if display private #end class __ASSET__assets_image_btn_png extends lime.graphics.Image {}
@:keep @:image("assets/image/btn_games.png") @:noCompletion #if display private #end class __ASSET__assets_image_btn_games_png extends lime.graphics.Image {}
@:keep @:image("assets/image/btn_games_hover.png") @:noCompletion #if display private #end class __ASSET__assets_image_btn_games_hover_png extends lime.graphics.Image {}
@:keep @:image("assets/image/btn_hover.png") @:noCompletion #if display private #end class __ASSET__assets_image_btn_hover_png extends lime.graphics.Image {}
@:keep @:image("assets/image/btn_lvl.png") @:noCompletion #if display private #end class __ASSET__assets_image_btn_lvl_png extends lime.graphics.Image {}
@:keep @:image("assets/image/btn_lvl_closed.png") @:noCompletion #if display private #end class __ASSET__assets_image_btn_lvl_closed_png extends lime.graphics.Image {}
@:keep @:image("assets/image/btn_lvl_hover.png") @:noCompletion #if display private #end class __ASSET__assets_image_btn_lvl_hover_png extends lime.graphics.Image {}
@:keep @:image("assets/image/head.png") @:noCompletion #if display private #end class __ASSET__assets_image_head_png extends lime.graphics.Image {}
@:keep @:image("assets/image/help.png") @:noCompletion #if display private #end class __ASSET__assets_image_help_png extends lime.graphics.Image {}
@:keep @:image("assets/image/how_to_play.png") @:noCompletion #if display private #end class __ASSET__assets_image_how_to_play_png extends lime.graphics.Image {}
@:keep @:image("assets/image/logo.png") @:noCompletion #if display private #end class __ASSET__assets_image_logo_png extends lime.graphics.Image {}
@:keep @:image("assets/image/panel.png") @:noCompletion #if display private #end class __ASSET__assets_image_panel_png extends lime.graphics.Image {}
@:keep @:image("assets/image/preview.png") @:noCompletion #if display private #end class __ASSET__assets_image_preview_png extends lime.graphics.Image {}
@:keep @:image("assets/image/tile/1.png") @:noCompletion #if display private #end class __ASSET__assets_image_tile_1_png extends lime.graphics.Image {}
@:keep @:image("assets/image/tile/10.png") @:noCompletion #if display private #end class __ASSET__assets_image_tile_10_png extends lime.graphics.Image {}
@:keep @:image("assets/image/tile/11.png") @:noCompletion #if display private #end class __ASSET__assets_image_tile_11_png extends lime.graphics.Image {}
@:keep @:image("assets/image/tile/12.png") @:noCompletion #if display private #end class __ASSET__assets_image_tile_12_png extends lime.graphics.Image {}
@:keep @:image("assets/image/tile/13.png") @:noCompletion #if display private #end class __ASSET__assets_image_tile_13_png extends lime.graphics.Image {}
@:keep @:image("assets/image/tile/14.png") @:noCompletion #if display private #end class __ASSET__assets_image_tile_14_png extends lime.graphics.Image {}
@:keep @:image("assets/image/tile/15.png") @:noCompletion #if display private #end class __ASSET__assets_image_tile_15_png extends lime.graphics.Image {}
@:keep @:image("assets/image/tile/16.png") @:noCompletion #if display private #end class __ASSET__assets_image_tile_16_png extends lime.graphics.Image {}
@:keep @:image("assets/image/tile/17.png") @:noCompletion #if display private #end class __ASSET__assets_image_tile_17_png extends lime.graphics.Image {}
@:keep @:image("assets/image/tile/18.png") @:noCompletion #if display private #end class __ASSET__assets_image_tile_18_png extends lime.graphics.Image {}
@:keep @:image("assets/image/tile/19.png") @:noCompletion #if display private #end class __ASSET__assets_image_tile_19_png extends lime.graphics.Image {}
@:keep @:image("assets/image/tile/2.png") @:noCompletion #if display private #end class __ASSET__assets_image_tile_2_png extends lime.graphics.Image {}
@:keep @:image("assets/image/tile/20.png") @:noCompletion #if display private #end class __ASSET__assets_image_tile_20_png extends lime.graphics.Image {}
@:keep @:image("assets/image/tile/21.png") @:noCompletion #if display private #end class __ASSET__assets_image_tile_21_png extends lime.graphics.Image {}
@:keep @:image("assets/image/tile/3.png") @:noCompletion #if display private #end class __ASSET__assets_image_tile_3_png extends lime.graphics.Image {}
@:keep @:image("assets/image/tile/4.png") @:noCompletion #if display private #end class __ASSET__assets_image_tile_4_png extends lime.graphics.Image {}
@:keep @:image("assets/image/tile/5.png") @:noCompletion #if display private #end class __ASSET__assets_image_tile_5_png extends lime.graphics.Image {}
@:keep @:image("assets/image/tile/6.png") @:noCompletion #if display private #end class __ASSET__assets_image_tile_6_png extends lime.graphics.Image {}
@:keep @:image("assets/image/tile/7.png") @:noCompletion #if display private #end class __ASSET__assets_image_tile_7_png extends lime.graphics.Image {}
@:keep @:image("assets/image/tile/8.png") @:noCompletion #if display private #end class __ASSET__assets_image_tile_8_png extends lime.graphics.Image {}
@:keep @:image("assets/image/tile/9.png") @:noCompletion #if display private #end class __ASSET__assets_image_tile_9_png extends lime.graphics.Image {}
@:keep @:file("assets/sound/193.mp3") @:noCompletion #if display private #end class __ASSET__assets_sound_193_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sound/bonus_out.mp3") @:noCompletion #if display private #end class __ASSET__assets_sound_bonus_out_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sound/game_over.mp3") @:noCompletion #if display private #end class __ASSET__assets_sound_game_over_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sound/intro.mp3") @:noCompletion #if display private #end class __ASSET__assets_sound_intro_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sound/level_complete.mp3") @:noCompletion #if display private #end class __ASSET__assets_sound_level_complete_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sound/mouse_down.mp3") @:noCompletion #if display private #end class __ASSET__assets_sound_mouse_down_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sound/mouse_over.mp3") @:noCompletion #if display private #end class __ASSET__assets_sound_mouse_over_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sound/tile_1.mp3") @:noCompletion #if display private #end class __ASSET__assets_sound_tile_1_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sound/tile_2.mp3") @:noCompletion #if display private #end class __ASSET__assets_sound_tile_2_mp3 extends haxe.io.Bytes {}
@:keep @:file("assets/sound/tile_3.mp3") @:noCompletion #if display private #end class __ASSET__assets_sound_tile_3_mp3 extends haxe.io.Bytes {}
@:keep @:font("bin/html5/obj/webfont/CgBernhardtBd.ttf") @:noCompletion #if display private #end class __ASSET__assets_font_cgbernhardtbd_ttf extends lime.text.Font {}
@:keep @:font("bin/html5/obj/webfont/Pixelyn.ttf") @:noCompletion #if display private #end class __ASSET__assets_font_pixelyn_ttf extends lime.text.Font {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__assets_font_cgbernhardtbd_ttf') @:noCompletion #if display private #end class __ASSET__assets_font_cgbernhardtbd_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/font/CgBernhardtBd"; #else ascender = 973; descender = -200; height = 1261; numGlyphs = 219; underlinePosition = -125; underlineThickness = 50; unitsPerEM = 1000; #end name = "CgBernhardtBd"; super (); }}
@:keep @:expose('__ASSET__assets_font_pixelyn_ttf') @:noCompletion #if display private #end class __ASSET__assets_font_pixelyn_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/font/Pixelyn"; #else ascender = 500; descender = -200; height = 752; numGlyphs = 98; underlinePosition = -125; underlineThickness = 50; unitsPerEM = 1000; #end name = "Pixelyn"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__assets_font_cgbernhardtbd_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_font_cgbernhardtbd_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_font_cgbernhardtbd_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_font_pixelyn_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_font_pixelyn_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_font_pixelyn_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__assets_font_cgbernhardtbd_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_font_cgbernhardtbd_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_font_cgbernhardtbd_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_font_pixelyn_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_font_pixelyn_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_font_pixelyn_ttf ()); super (); }}

#end

#end
#end

#end
