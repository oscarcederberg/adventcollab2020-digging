package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;
import flixel.ui.FlxButton;
import tiles.Bedrock;

class MenuState extends FlxState
{
	var playButton:FlxButton;
	var keys:Array<Array<FlxKey>>;
	var step:Int;

	override public function create()
	{
		var background:FlxSprite = new FlxSprite(0, 0);
		background.loadGraphic("assets/images/spr_title.png", false, 480, 270);
		add(background);

		playButton = new FlxButton(0, 0, "Play", clickPlay);
		playButton.y = 10 * 540 / 32;
		playButton.screenCenter(X);
		add(playButton);

		keys = tiles.Konami.KEYS;
		step = 0;

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.anyJustPressed([ANY]))
		{
			if (tiles.Konami.handleKeys(step))
			{
				step++;
				if (step == 10)
				{
					add(new tiles.Konami(352, 96));
				}
			}
			else
			{
				step = 0;
				if (FlxG.keys.anyJustPressed([J, Z]))
				{
					clickPlay();
				}
			}
		}

		super.update(elapsed);
	}

	function clickPlay()
	{
		FlxG.switchState(new PlayState());
	}
}
