package blocks;

class BlockSnowGold extends Block
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		this.totalHits = 15;
		this.currentHits = this.totalHits;

		loadGraphic(AssetPaths.blocksnowgold__png, false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
	}

	override public function breakblock():Void
	{
		parent.add(new Gold(x + width / 2 - 4, y + height / 2 - 2));
		destroy();
	}
}
