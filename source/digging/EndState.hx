package digging;

import blocks.*;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.text.FlxBitmapText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

import ui.Controls;
#if ADVENT
import utils.OverlayGlobal as Global;
#else
import utils.Global;
#end

class EndState extends FlxState
{
	var rollupComplete = false;
	var score = 0;
	var scoreText:FlxBitmapText;

	public function new(score:Int, giftsCollected:Int, blocksDestroyed:Int, enemiesKilled:Int, maxDepth:Int)
	{
		this.score = score;
		super();

		var background:FlxBackdrop = new FlxBackdrop(Global.asset("assets/images/spr_end.png"), 2, 1);
		background.velocity.set(16, 8);

		var font = new ui.Font.NokiaFont16();
		// var gameOverText = new FlxText(0, 0, 0, 32);
		var gameOverText = new FlxBitmapText(font);
		gameOverText.scale.set(2, 2);
		gameOverText.y = 4 * 540 / 32;
		gameOverText.text = "GAME OVER";
		gameOverText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		gameOverText.screenCenter(X);
		gameOverText.scrollFactor.set(0, 0);

		//scoreText = new FlxText(0, 0, 0, 16);
		scoreText = new FlxBitmapText(font);
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

		add(background);
		add(gameOverText);
		add(scoreText);
		add(giftsText);
		add(blocksText);
		add(enemiesText);
		add(depthText);
	}

	override public function create()
	{
		FlxG.sound.play(Global.asset("assets/sounds/sfx_times_up.mp3"));
		var timer = new FlxTimer();
		timer.start(4, (_) ->
		{
			FlxG.sound.playMusic(Global.asset("assets/music/mus_jingle.mp3"), 0.5, true);
			FlxG.sound.music.loopTime = 3692;
		}, 1);

		scoreText.text = "Final Score: 0";
		FlxTween.num(0, score, 1.0,
			{ ease:FlxEase.circIn, onComplete:onRollupComplete },
			(num)->{ scoreText.text = "Final Score: " + (Math.round(num / 5) * 5); }
		);

		super.create();
	}

	function onRollupComplete(tween:FlxTween)
	{
		rollupComplete = true;

		var playButton = new FlxButton(0, 13 * 540 / 32, null, clickRestart);
		playButton.loadGraphic(Global.asset("assets/images/spr_button_restart.png"), true, 80, 26);
		playButton.screenCenter(X);
		playButton.scrollFactor.set(0, 0);
		
		#if ADVENT
		playButton.x += playButton.width;
		var exitButton = new FlxButton(0, 13 * 540 / 32, null, data.Game.exitArcade);
		exitButton.loadGraphic(Global.asset("assets/images/spr_button_exit.png"), true, 80, 26);
		exitButton.screenCenter(X);
		exitButton.scrollFactor.set(0, 0);
		exitButton.x -= exitButton.width;
		#end

		add(playButton);
		#if ADVENT add(exitButton); #end
	}

	override public function update(elapsed:Float)
	{
		if (Controls.justPressed.A && rollupComplete)
		{
			clickRestart();
		}

		super.update(elapsed);
	}

	function clickRestart()
	{
		Global.switchState(new PlayState());
	}
}
