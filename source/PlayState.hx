package;

import blocks.*;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup;

class PlayState extends FlxState
{
	public static final CELL_SIZE:Int = 32;
	public static final CELL_SCALE:Float = CELL_SIZE / 32;

	var player:Player;
	var map:FlxOgmo3Loader;

	public var blocks:FlxTypedGroup<Block>;

	override public function create()
	{
		blocks = new FlxTypedGroup<Block>();
		map = new FlxOgmo3Loader(AssetPaths.AdventCollab20_Digging__ogmo, AssetPaths.level_test__json);

		map.loadEntities(placeEntities, "entities");
		map.loadEntities(placeEntities, "blocks");
		add(blocks);
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
		var en_x = entity.x * CELL_SCALE;
		var en_y = entity.y * CELL_SCALE;
		switch (entity.name)
		{
			case "player":
				player = new Player(en_x, en_y, this);
				add(player);
			case "snow":
				var block = new BlockSnow(en_x, en_y);
				blocks.add(block);
			case "snow_gold":
				var block = new BlockSnowGold(en_x, en_y);
				blocks.add(block);
		}
	}
}
