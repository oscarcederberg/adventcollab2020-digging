package;

import blocks.*;

import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.text.FlxBitmapText;

class EndState extends FlxState
{
	public function new(score:Int, giftsCollected:Int, blocksDestroyed:Int, enemiesKilled:Int, maxDepth:Int)
	{
		super();

		var font = new ui.DigFont.DigNokiaFont16();
		// var gameOverText = new FlxText(0, 0, 0, 32);
		var gameOverText = new FlxBitmapText(font);
		gameOverText.scale.set(2, 2);
		gameOverText.y = 4 * 540 / 32;
		gameOverText.text = "GAME OVER";
		gameOverText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		gameOverText.screenCenter(X);

		// var scoreText = new FlxText(0, 0, 0, 16);
		var scoreText = new FlxBitmapText(font);
		scoreText.y = 7 * 540 / 32;
		scoreText.text = "Final Score: " + score;
		scoreText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		scoreText.screenCenter(X);

		// var giftsText = new FlxText(0, 0, 0, 16);
		var giftsText = new FlxBitmapText(font);
		giftsText.y = 8 * 540 / 32;
		giftsText.text = "Gifts Collected: " + giftsCollected;
		giftsText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		giftsText.screenCenter(X);

		// var blocksText = new FlxText(0, 0, 0, 16);
		var blocksText = new FlxBitmapText(font);
		blocksText.y = 9 * 540 / 32;
		blocksText.text = "Blocks Destroyed: " + blocksDestroyed;
		blocksText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		blocksText.screenCenter(X);

		// var enemiesText = new FlxText(0, 0, 0, 16);
		var enemiesText = new FlxBitmapText(font);
		enemiesText.y = 10 * 540 / 32;
		enemiesText.text = "Enemies Killed: " + enemiesKilled;
		enemiesText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		enemiesText.screenCenter(X);

		// var depthText = new FlxText(0, 0, 0, 16);
		var depthText = new FlxBitmapText(font);
		depthText.y = 11 * 540 / 32;
		depthText.text = "Depth Dug: " + maxDepth + " meters";
		depthText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		depthText.screenCenter(X);

		var playButton = new FlxButton(0, 13 * 540 / 32, "Restart", clickRestart);
		playButton.screenCenter(X);

		add(gameOverText);
		add(scoreText);
		add(giftsText);
		add(blocksText);
		add(enemiesText);
		add(depthText);
		add(playButton);
	}

	function clickRestart()
	{
		FlxG.switchState(new PlayState());
	}
}
