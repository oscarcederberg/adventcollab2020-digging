package digging;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup;
import flixel.text.FlxBitmapText;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

import digging.tiles.*;
import digging.tiles.BrickGift.GiftColors;

import ui.Controls;

class PlayState extends FlxState
{
	inline public static var WINDOW_WIDTH = 480;
	inline public static var GAME_WIDTH = 320;
	inline public static var WING_WIDTH = (WINDOW_WIDTH - GAME_WIDTH) / 2;

	public static final CELL_SIZE:Int = 32;
	public static final CELL_SCALE:Float = CELL_SIZE / 32;

	var map:FlxOgmo3Loader;
	var tilemap:FlxTilemap;

	public var score:Int;
	public var time:FlxTimer;
	public var giftsCollected:Int;
	public var blocksDestroyed:Int;
	public var enemiesKilled:Int;
	public var maxDepth:Int;

	public var player:Player;
	public var HUD:HUD;
	public var fastMode:Bool;
	public var tiles:FlxTypedGroup<Tile>;
	public var enemies:FlxTypedGroup<Enemy>;
	public var pickups:FlxTypedGroup<Pickup>;
	public var bounds:FlxGroup;
	public var infoTexts:FlxTypedGroup<InfoText>;

	override public function create()
	{
		this.bgColor = FlxColor.fromRGB(155, 173, 183, 255);

		var background:FlxSprite = new FlxSprite(0, 0);
		background.loadGraphic("assets/images/spr_background.png", true, 320, 512);
		add(background);

		this.tiles = new FlxTypedGroup<Tile>();
		this.map = new FlxOgmo3Loader("assets/data/advent2020.ogmo", "assets/data/level_1.json");
		this.bounds = FlxCollision.createCameraWall(new FlxCamera(0, 0, 320, 51200, 1), true, 1, true);
		this.tilemap = map.loadTilemap("assets/images/OGMO/tiles.png", "tiles");
		placeTiles();
		add(this.tiles);

		add(infoTexts = new FlxTypedGroup());
		InfoText.pool = infoTexts;

		this.enemies = new FlxTypedGroup<Enemy>();
		this.pickups = new FlxTypedGroup<Pickup>();
		this.map.loadEntities(placeEntities, "entities");
		add(this.enemies);
		add(this.pickups);

		FlxG.camera.follow(player, TOPDOWN, 1);
		FlxG.camera.deadzone.x = 0;
		FlxG.camera.deadzone.y -= FlxG.height / 4; // show the player near the top
		FlxG.camera.deadzone.height = 100; // approx the jump height
		FlxG.camera.deadzone.width = FlxG.width;
		FlxG.camera.minScrollX = -WING_WIDTH;
		FlxG.camera.maxScrollX = FlxG.width - WING_WIDTH;
		FlxG.camera.minScrollY = null;
		FlxG.camera.maxScrollY = null;

		this.HUD = new HUD();
		this.score = 0;
		this.giftsCollected = 0;
		this.blocksDestroyed = 0;
		this.enemiesKilled = 0;
		this.maxDepth = 0;

		this.time = new FlxTimer();
		this.time.start(300, endGame, 1);
		add(HUD);

		this.fastMode = false;
		FlxG.sound.playMusic("assets/music/mus_music_normal.mp3", 0.5, true);
		FlxG.sound.music.loopTime = 22160;

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (!fastMode)
		{
			if (time.timeLeft <= 60)
			{
				fastMode = true;
				HUD.updateFlicker();
				FlxG.sound.music.fadeOut(0.2, 0);
				FlxG.sound.play("assets/sounds/sfx_hurry_up.wav");
				new FlxTimer().start(3.33, switchTrack, 1);
			}
		}

		enemies.forEach(function(enemy:Enemy) enemy.active = enemy.isOnScreen());
		pickups.forEach(function(pickup:Pickup) pickup.active = pickup.isOnScreen());

		FlxG.collide(enemies, tiles);
		FlxG.collide(enemies, bounds);
		FlxG.overlap(player, pickups, (_, pickup:Pickup) -> pickupItem(pickup));
		FlxG.collide(pickups, tiles);

		var currentDepth = Std.int((player.y - 6 * CELL_SIZE) / 32);
		maxDepth = Std.int(Math.max(currentDepth, maxDepth));
		HUD.updateHUD(score, Std.int(time.timeLeft));

		#if (debug || ADVENT)
		if (FlxG.keys.anyPressed([R]))
			FlxG.switchState(new PlayState());
		if (FlxG.keys.anyJustPressed([Q]))
			endGame(null);
		#end
		#if ADVENT
		if (Controls.justPressed.EXIT)
			data.Game.exitArcade();
		#end

		super.update(elapsed);
	}

	function pickupItem(pickup:Pickup)
	{
		if (FlxG.pixelPerfectOverlap(pickup, player))
		{
			giftsCollected++;
			if (pickup.score > 0)
			{
				updateScore(pickup.score);
				new ScoreText(pickup, pickup.score);
			}
			pickup.pickup();
		}
	}

	// we want to tiles from the transform layer to actual tile entities instead of unbreakable tiles, this seems to be the only way?
	function placeTiles()
	{
		for (x in 0...tilemap.widthInTiles)
		{
			for (y in 0...tilemap.heightInTiles)
			{
				var tile:Int = tilemap.getData()[y * tilemap.widthInTiles + x];
				switch (tile)
				{
					case 1:
						tiles.add(new Brick(x * 32, y * 32));
					case 2:
						tiles.add(new BrickGift(x * 32, y * 32));
					case 3:
						tiles.add(new BrickSurface(x * 32, y * 32));
					case 4:
						tiles.add(new Block(x * 32, y * 32));
					case 5:
						tiles.add(new BlockEnemy(x * 32, y * 32));
					case 6:
						tiles.add(new Snow(x * 32, y * 32));
					case 7:
						tiles.add(new Stone(x * 32, y * 32));
					case 8:
						tiles.add(new StoneGiftBig(x * 32, y * 32));
					case 9:
						tiles.add(new BedrockStart(x * 32, y * 32));
					case 10:
						tiles.add(new Bedrock(x * 32, y * 32));
					case 11:
						tiles.add(new BlockGiftMedium(x * 32, y * 32));
				}
			}
		}
	}

	function placeEntities(entity:EntityData)
	{
		var real_x = entity.x * CELL_SCALE;
		var real_y = entity.y * CELL_SCALE;
		switch (entity.name)
		{
			case "player":
				player = new Player(real_x, real_y);
				add(player);
			case "enemy":
				enemies.add(new Enemy(real_x, real_y));
			case "gift":
				pickups.add(new Gift(real_x, real_y, GiftColors.Random));
			case "gift_medium":
				pickups.add(new GiftMedium(real_x, real_y));
			case "gift_big":
				pickups.add(new GiftBig(real_x, real_y));
		}
	}

	public function switchTrack(timer:FlxTimer)
	{
		FlxG.sound.playMusic("assets/music/mus_music_fast.mp3", 0.5, true);
		FlxG.sound.music.loopTime = 18005;
	}

	public function updateScore(score:Int)
	{
		this.score += score;
	}

	public function endGame(timer:FlxTimer)
	{
		#if ADVENT
		data.NGio.postPlayerHiscore("digging", score);
		if (score > 20000)
			data.NGio.unlockMedalByName("digging");// hard coded for now, meh
		#end

		FlxG.sound.music.stop();
		FlxG.switchState(new EndState(score, giftsCollected, blocksDestroyed, enemiesKilled, maxDepth));
	}
}

abstract HitText(InfoText) to InfoText
{
	inline public function new (source:FlxObject, seconds:Int)
	{
		this = new InfoText(source, '-${seconds}s', 0xFFff0000);
	}
}

abstract ScoreText(InfoText) to InfoText
{
	inline public function new (source:FlxObject, score:Int)
	{
		this = new InfoText(source, score+"pts", 0xFFffffff, 0xFF486cb7);
	}
}

abstract InfoText(FlxBitmapText) to FlxBitmapText
{
	static public var pool:FlxTypedGroup<FlxBitmapText>;
	
	public function new (source:FlxObject, text:String, color:FlxColor, border:FlxColor = 0xFF000000)
	{
		this = cast pool.recycle(FlxBitmapText, ()->new FlxBitmapText());
		this.text = text;
		this.x = source.x + (source.width - this.width) / 2;
		this.y = source.y;
		this.setBorderStyle(OUTLINE, border, 1);
		this.color = color;

		FlxTween.tween(this, { y:this.y - PlayState.CELL_SIZE }, 1,
			{ ease:(t)->FlxEase.quadOut(Math.min(1, t * 1.5)), onComplete:(_)->this.kill() });
	}
}
