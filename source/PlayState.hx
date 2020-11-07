package;

import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.tile.FlxTilemap;

class PlayState extends FlxState
{
	var player:Player;
	var map:FlxOgmo3Loader;
	var tiles:FlxTilemap;

	override public function create()
	{
		map = new FlxOgmo3Loader(AssetPaths.AdventCollab20_Digging__ogmo, AssetPaths.level_test__json);
		tiles = map.loadTilemap(AssetPaths.tiles__png, "tiles");
		tiles.follow();
		tiles.setTileProperties(1, FlxObject.ANY);
		tiles.setTileProperties(2, FlxObject.ANY);
		add(tiles);

		player = new Player(tiles);
		map.loadEntities(placeEntities, "entities");
		add(player);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	function placeEntities(entity:EntityData)
	{
		if (entity.name == "player")
		{
			player.setPosition(entity.x, entity.y);
		}
	}
}
