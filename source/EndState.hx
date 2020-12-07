package;

import blocks.*;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.text.FlxBitmapText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class EndState extends FlxState
{
	public function new(score:Int, giftsCollected:Int, blocksDestroyed:Int, enemiesKilled:Int, maxDepth:Int)
	{
		super();

		var background:FlxBackdrop = new FlxBackdrop("assets/images/spr_end.png", 2, 1);
		background.velocity.set(16, 8);

		var font = new ui.DigFont.DigNokiaFont16();
		// var gameOverText = new FlxText(0, 0, 0, 32);
		var gameOverText = new FlxBitmapText(font);
		gameOverText.scale.set(2, 2);
		gameOverText.y = 4 * 540 / 32;
		gameOverText.text = "GAME OVER";
		gameOverText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		gameOverText.screenCenter(X);
		gameOverText.scrollFactor.set(0, 0);

		// var scoreText = new FlxText(0, 0, 0, 16);
		var scoreText = new FlxBitmapText(font);
		scoreText.y = 7 * 540 / 32;
		scoreText.text = "Final Score: " + score;
		scoreText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		scoreText.screenCenter(X);
		scoreText.scrollFactor.set(0, 0);

		// var giftsText = new FlxText(0, 0, 0, 16);
		var giftsText = new FlxBitmapText(font);
		giftsText.y = 8 * 540 / 32;
		giftsText.text = "Gifts Collected: " + giftsCollected;
		giftsText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		giftsText.screenCenter(X);
		giftsText.scrollFactor.set(0, 0);

		// var blocksText = new FlxText(0, 0, 0, 16);
		var blocksText = new FlxBitmapText(font);
		blocksText.y = 9 * 540 / 32;
		blocksText.text = "Blocks Destroyed: " + blocksDestroyed;
		blocksText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		blocksText.screenCenter(X);
		blocksText.scrollFactor.set(0, 0);

		// var enemiesText = new FlxText(0, 0, 0, 16);
		var enemiesText = new FlxBitmapText(font);
		enemiesText.y = 10 * 540 / 32;
		enemiesText.text = "Enemies Killed: " + enemiesKilled;
		enemiesText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		enemiesText.screenCenter(X);
		enemiesText.scrollFactor.set(0, 0);

		// var depthText = new FlxText(0, 0, 0, 16);
		var depthText = new FlxBitmapText(font);
		depthText.y = 11 * 540 / 32;
		depthText.text = "Depth Dug: " + maxDepth + " meters";
		depthText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		depthText.screenCenter(X);
		depthText.scrollFactor.set(0, 0);

		var playButton = new FlxButton(0, 13 * 540 / 32, null, clickRestart);
		playButton.loadGraphic("assets/images/spr_button_restart.png", true, 80, 26);
		playButton.screenCenter(X);
		playButton.scrollFactor.set(0, 0);

		FlxG.sound.play("assets/sounds/sfx_times_up.wav");
		var timer = new FlxTimer();
		timer.start(4, (_) ->
		{
			FlxG.sound.playMusic("assets/music/mus_jingle.mp3", 0.5, true);
			FlxG.sound.music.loopTime = 3692;
		}, 1);

		add(background);
		add(gameOverText);
		add(scoreText);
		add(giftsText);
		add(blocksText);
		add(enemiesText);
		add(depthText);
		add(playButton);
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.anyJustPressed([J, Z]))
		{
			clickRestart();
		}

		super.update(elapsed);
	}

	function clickRestart()
	{
		FlxG.switchState(new PlayState());
	}
}
