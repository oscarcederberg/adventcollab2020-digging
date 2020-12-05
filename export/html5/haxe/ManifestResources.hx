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
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end

		var data, manifest, library, bundle;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		data = '{"name":null,"assets":"aoy4:pathy31:assets%2Fdata%2Fadvent2020.ogmoy4:sizei8943y4:typey4:TEXTy2:idR1y7:preloadtgoR0y31:assets%2Fdata%2Flevel_test.jsonR2i2009R3R4R5R7R6tgoR0y38:assets%2Fimages%2FOGMO%2Fenemy_gov.pngR2i710R3y5:IMAGER5R8R6tgoR0y35:assets%2Fimages%2FOGMO%2Fplayer.pngR2i592R3R9R5R10R6tgoR0y34:assets%2Fimages%2FOGMO%2Ftiles.pngR2i1950R3R9R5R11R6tgoR0y36:assets%2Fimages%2Fspr_background.pngR2i11771R3R9R5R12R6tgoR0y31:assets%2Fimages%2Fspr_block.pngR2i710R3R9R5R13R6tgoR0y37:assets%2Fimages%2Fspr_block_enemy.pngR2i1898R3R9R5R14R6tgoR0y31:assets%2Fimages%2Fspr_brick.pngR2i402R3R9R5R15R6tgoR0y36:assets%2Fimages%2Fspr_brick_gift.pngR2i2159R3R9R5R16R6tgoR0y42:assets%2Fimages%2Fspr_brick_gift_black.pngR2i762R3R9R5R17R6tgoR0y41:assets%2Fimages%2Fspr_brick_gift_blue.pngR2i792R3R9R5R18R6tgoR0y42:assets%2Fimages%2Fspr_brick_gift_green.pngR2i778R3R9R5R19R6tgoR0y43:assets%2Fimages%2Fspr_brick_gift_purple.pngR2i770R3R9R5R20R6tgoR0y40:assets%2Fimages%2Fspr_brick_gift_red.pngR2i771R3R9R5R21R6tgoR0y39:assets%2Fimages%2Fspr_brick_surface.pngR2i318R3R9R5R22R6tgoR0y37:assets%2Fimages%2Fspr_enemy_brown.pngR2i869R3R9R5R23R6tgoR0y35:assets%2Fimages%2Fspr_enemy_gov.pngR2i985R3R9R5R24R6tgoR0y37:assets%2Fimages%2Fspr_enemy_green.pngR2i829R3R9R5R25R6tgoR0y35:assets%2Fimages%2Fspr_enemy_red.pngR2i972R3R9R5R26R6tgoR0y30:assets%2Fimages%2Fspr_gift.pngR2i1165R3R9R5R27R6tgoR0y36:assets%2Fimages%2Fspr_gift_black.pngR2i372R3R9R5R28R6tgoR0y35:assets%2Fimages%2Fspr_gift_blue.pngR2i382R3R9R5R29R6tgoR0y36:assets%2Fimages%2Fspr_gift_green.pngR2i388R3R9R5R30R6tgoR0y37:assets%2Fimages%2Fspr_gift_purple.pngR2i389R3R9R5R31R6tgoR0y34:assets%2Fimages%2Fspr_gift_red.pngR2i394R3R9R5R32R6tgoR0y32:assets%2Fimages%2Fspr_player.pngR2i2749R3R9R5R33R6tgoR0y30:assets%2Fimages%2Fspr_snow.pngR2i176R3R9R5R34R6tgoR0y36:assets%2Fmusic%2Fmusic-goes-here.txtR2zR3R4R5R35R6tgoR2i26642R3y5:SOUNDR5y32:assets%2Fsounds%2Fsfx_damage.wavy9:pathGroupaR37hR6tgoR2i16656R3R36R5y30:assets%2Fsounds%2Fsfx_gift.wavR38aR39hR6tgoR2i12254R3R36R5y29:assets%2Fsounds%2Fsfx_hit.wavR38aR40hR6tgoR2i12254R3R36R5y32:assets%2Fsounds%2Fsfx_pickup.wavR38aR41hR6tgoR2i44252R3R36R5y30:assets%2Fsounds%2Fsfx_step.wavR38aR42hR6tgoR2i2114R3y5:MUSICR5y26:flixel%2Fsounds%2Fbeep.mp3R38aR44y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i39706R3R43R5y28:flixel%2Fsounds%2Fflixel.mp3R38aR46y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i5794R3R36R5R45R38aR44R45hgoR2i33629R3R36R5R47R38aR46R47hgoR2i15744R3y4:FONTy9:classNamey35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R48R49y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i519R3R9R5R54R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i3280R3R9R5R55R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
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

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_advent2020_ogmo extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_level_test_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ogmo_enemy_gov_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ogmo_player_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ogmo_tiles_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spr_background_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spr_block_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spr_block_enemy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spr_brick_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spr_brick_gift_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spr_brick_gift_black_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spr_brick_gift_blue_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spr_brick_gift_green_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spr_brick_gift_purple_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spr_brick_gift_red_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spr_brick_surface_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spr_enemy_brown_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spr_enemy_gov_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spr_enemy_green_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spr_enemy_red_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spr_gift_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spr_gift_black_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spr_gift_blue_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spr_gift_green_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spr_gift_purple_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spr_gift_red_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spr_player_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_spr_snow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_sfx_damage_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_sfx_gift_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_sfx_hit_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_sfx_pickup_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_sfx_step_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("assets/data/advent2020.ogmo") @:noCompletion #if display private #end class __ASSET__assets_data_advent2020_ogmo extends haxe.io.Bytes {}
@:keep @:file("assets/data/level_test.json") @:noCompletion #if display private #end class __ASSET__assets_data_level_test_json extends haxe.io.Bytes {}
@:keep @:image("assets/images/OGMO/enemy_gov.png") @:noCompletion #if display private #end class __ASSET__assets_images_ogmo_enemy_gov_png extends lime.graphics.Image {}
@:keep @:image("assets/images/OGMO/player.png") @:noCompletion #if display private #end class __ASSET__assets_images_ogmo_player_png extends lime.graphics.Image {}
@:keep @:image("assets/images/OGMO/tiles.png") @:noCompletion #if display private #end class __ASSET__assets_images_ogmo_tiles_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spr_background.png") @:noCompletion #if display private #end class __ASSET__assets_images_spr_background_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spr_block.png") @:noCompletion #if display private #end class __ASSET__assets_images_spr_block_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spr_block_enemy.png") @:noCompletion #if display private #end class __ASSET__assets_images_spr_block_enemy_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spr_brick.png") @:noCompletion #if display private #end class __ASSET__assets_images_spr_brick_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spr_brick_gift.png") @:noCompletion #if display private #end class __ASSET__assets_images_spr_brick_gift_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spr_brick_gift_black.png") @:noCompletion #if display private #end class __ASSET__assets_images_spr_brick_gift_black_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spr_brick_gift_blue.png") @:noCompletion #if display private #end class __ASSET__assets_images_spr_brick_gift_blue_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spr_brick_gift_green.png") @:noCompletion #if display private #end class __ASSET__assets_images_spr_brick_gift_green_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spr_brick_gift_purple.png") @:noCompletion #if display private #end class __ASSET__assets_images_spr_brick_gift_purple_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spr_brick_gift_red.png") @:noCompletion #if display private #end class __ASSET__assets_images_spr_brick_gift_red_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spr_brick_surface.png") @:noCompletion #if display private #end class __ASSET__assets_images_spr_brick_surface_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spr_enemy_brown.png") @:noCompletion #if display private #end class __ASSET__assets_images_spr_enemy_brown_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spr_enemy_gov.png") @:noCompletion #if display private #end class __ASSET__assets_images_spr_enemy_gov_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spr_enemy_green.png") @:noCompletion #if display private #end class __ASSET__assets_images_spr_enemy_green_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spr_enemy_red.png") @:noCompletion #if display private #end class __ASSET__assets_images_spr_enemy_red_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spr_gift.png") @:noCompletion #if display private #end class __ASSET__assets_images_spr_gift_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spr_gift_black.png") @:noCompletion #if display private #end class __ASSET__assets_images_spr_gift_black_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spr_gift_blue.png") @:noCompletion #if display private #end class __ASSET__assets_images_spr_gift_blue_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spr_gift_green.png") @:noCompletion #if display private #end class __ASSET__assets_images_spr_gift_green_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spr_gift_purple.png") @:noCompletion #if display private #end class __ASSET__assets_images_spr_gift_purple_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spr_gift_red.png") @:noCompletion #if display private #end class __ASSET__assets_images_spr_gift_red_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spr_player.png") @:noCompletion #if display private #end class __ASSET__assets_images_spr_player_png extends lime.graphics.Image {}
@:keep @:image("assets/images/spr_snow.png") @:noCompletion #if display private #end class __ASSET__assets_images_spr_snow_png extends lime.graphics.Image {}
@:keep @:file("assets/music/music-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sfx_damage.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_sfx_damage_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sfx_gift.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_sfx_gift_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sfx_hit.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_sfx_hit_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sfx_pickup.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_sfx_pickup_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sfx_step.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_sfx_step_wav extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,8,1/assets/sounds/beep.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,8,1/assets/sounds/flixel.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,8,1/assets/sounds/beep.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,8,1/assets/sounds/flixel.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/nokiafc22.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterrat.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,8,1/assets/images/ui/button.png") @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,8,1/assets/images/logo/default.png") @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end
