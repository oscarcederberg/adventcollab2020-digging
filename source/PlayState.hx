package;

import blocks.*;
import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup;
import flixel.util.FlxCollision;
import flixel.util.FlxSpriteUtil;

class PlayState extends FlxState
{
	public static final CELL_SIZE:Int = 32;
	public static final CELL_SCALE:Float = CELL_SIZE / 32;

	var map:FlxOgmo3Loader;

	public var player:Player;
	public var score:Int;
	public var blocks:FlxTypedGroup<Block>;
	public var bounds:FlxGroup;

	override public function create()
	{
		score = 0;
		blocks = new FlxTypedGroup<Block>();
		map = new FlxOgmo3Loader(AssetPaths.AdventCollab20_Digging__ogmo, AssetPaths.level_test__json);
		bounds = FlxCollision.createCameraWall(FlxG.camera, true, 1, false);

		map.loadEntities(placeEntities, "entities");
		map.loadEntities(placeEntities, "blocks");
		add(blocks);

		FlxG.camera.follow(player, TOPDOWN, 1);
		FlxG.camera.setScrollBoundsRect(0, 0, 320, 99999);
		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.anyPressed([R]))
			FlxG.switchState(new PlayState());

		super.update(elapsed);
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
			case "snow":
				var block = new BlockSnow(real_x, real_y);
				blocks.add(block);
			case "snow_gold":
				var block = new BlockSnowGold(real_x, real_y);
				blocks.add(block);
		}
	}

	public function updateScore(score:Int)
	{
		this.score += score;
	}
}
