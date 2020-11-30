package;

import blocks.BlockSnowGift.GiftColors;
import flixel.FlxG;
import flixel.FlxSprite;

class Gift extends FlxSprite
{
	public static final SCORE:Int = 400;
	static final GRAVITY:Float = PlayState.CELL_SIZE * 30;

	var giftColor:GiftColors;
	var parent:PlayState;

	public function new(x:Float = 0, y:Float = 0, giftColor:GiftColors)
	{
		super(x, y);
		this.parent = cast(FlxG.state);
		this.giftColor = giftColor;
		acceleration.y = GRAVITY;

		switch (giftColor)
		{
			case Green:
				loadGraphic(AssetPaths.spr_gift_green__png, false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
			case Purple:
				loadGraphic(AssetPaths.spr_gift_purple__png, false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
			case Black:
				loadGraphic(AssetPaths.spr_gift_black__png, false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
			case Red:
				loadGraphic(AssetPaths.spr_gift_red__png, false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
			case Blue:
				loadGraphic(AssetPaths.spr_gift_blue__png, false, PlayState.CELL_SIZE, PlayState.CELL_SIZE);
		}
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(this, parent.blocks);
		if (FlxG.pixelPerfectOverlap(this, parent.player))
		{
			pickup();
		}
	}

	public function pickup()
	{
		parent.updateScore(SCORE);
		destroy();
	}
}
