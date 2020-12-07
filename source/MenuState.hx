package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;

class MenuState extends FlxState
{
	var playButton:FlxButton;

	override public function create()
	{
		var background:FlxSprite = new FlxSprite(0, 0);
		background.loadGraphic("assets/images/spr_title.png", false, 480, 270);
		add(background);

		playButton = new FlxButton(0, 0, "Play", clickPlay);
		playButton.y = 10 * 540 / 32;
		playButton.screenCenter(X);
		add(playButton);

		super.create();
	}

	function clickPlay()
	{
		FlxG.switchState(new PlayState());
	}
}
