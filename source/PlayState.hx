package;

import blocks.*;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	public static final CELL_SIZE:Int = 32;
	public static final CELL_SCALE:Float = CELL_SIZE / 32;

	var map:FlxOgmo3Loader;
	var tiles:FlxTilemap;

	public var player:Player;
	public var HUD:HUD;
	public var score:Int;
	public var time:FlxTimer;
	public var blocks:FlxTypedGroup<Block>;
	public var enemies:FlxTypedGroup<Enemy>;
	public var bounds:FlxGroup;

	override public function create()
	{
		this.bgColor = FlxColor.WHITE;

		var background:FlxSprite = new FlxSprite(0, 0);
		background.loadGraphic(AssetPaths.spr_background__png, true, 320, 512);
		add(background);

		this.blocks = new FlxTypedGroup<Block>();
		this.map = new FlxOgmo3Loader(AssetPaths.advent2020__ogmo, AssetPaths.level_test__json);
		this.bounds = FlxCollision.createCameraWall(new FlxCamera(0, 0, 320, 51200, 1), true, 1, true);
		this.tiles = map.loadTilemap(AssetPaths.tiles__png, "blocks");
		placeBlocks();
		add(this.blocks);

		this.enemies = new FlxTypedGroup<Enemy>();
		this.map.loadEntities(placeEntities, "entities");
		add(this.enemies);

		FlxG.camera.follow(player, TOPDOWN, 1);
		FlxG.camera.setScrollBoundsRect(0, 0, 320, 99999);

		this.HUD = new HUD();
		this.score = 0;
		this.time = new FlxTimer();
		this.time.start(300, endGame, 1);
		add(HUD);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.anyPressed([R]))
			FlxG.switchState(new PlayState());
		HUD.updateHUD(score, Std.int(time.timeLeft));

		super.update(elapsed);
	}

	// we want to tiles from the transform layer to actual block entities instead of unbreakable tiles, this seems to be the only way?
	function placeBlocks()
	{
		for (x in 0...tiles.widthInTiles)
		{
			for (y in 0...tiles.heightInTiles)
			{
				var tile:Int = tiles.getData()[y * tiles.widthInTiles + x];
				switch (tile)
				{
					case 1:
						blocks.add(new BlockSnow(x * 32, y * 32));
					case 2:
						blocks.add(new BlockSnowGift(x * 32, y * 32));
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
		}
	}

	public function updateScore(score:Int)
	{
		this.score += score;
	}

	public function endGame(timer:FlxTimer)
	{
		FlxG.switchState(new EndState(score));
	}
}
