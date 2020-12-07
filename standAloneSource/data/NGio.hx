package data;

/*
EXAMPLE APIStuff layout, create APIStuff.hx, put it in the data folder and paste this
into it with all the right info about your project file. 

package data;

class APIStuff
{
	// look in your project for the following info
	inline public static var APIID = "12345:abcdefgh";
	inline public static var EncKey = "";// use the Base64 Rc4 one
	inline public static var DebugSession = 
		#if debug
		"########.longAssStringOfLettersAndNumbers";
		#else
		null;
		#end
}
*/

import io.newgrounds.NG;
import io.newgrounds.objects.Medal;
import io.newgrounds.objects.Score;
import io.newgrounds.objects.ScoreBoard;
import io.newgrounds.components.ScoreBoardComponent.Period;
import io.newgrounds.objects.Error;
import io.newgrounds.objects.events.Response;
import io.newgrounds.objects.events.Result.GetDateTimeResult;

import openfl.display.Stage;

import flixel.FlxG;
import flixel.util.FlxSignal;

class NGio
{
	inline static var DEBUG_SESSION = #if NG_DEBUG true #else false #end;
	
	inline static var SCOREBOARD_ID = 0;//todo
	
	public static var isLoggedIn(default, null):Bool = false;
	public static var userName(default, null):String;
	public static var scoreboardsLoaded(default, null):Bool = false;
	public static var ngDate(default, null):Date;
	
	public static var ngDataLoaded(default, null):FlxSignal = new FlxSignal();
	public static var ngScoresLoaded(default, null):FlxSignal = new FlxSignal();
	
	static var loggedEvents = new Array<NgEvent>();
	
	static public function attemptAutoLogin(callback:Void->Void) {
		
		#if NG_BYPASS_LOGIN
		NG.create(APIStuff.APIID, null, DEBUG_SESSION);
		NG.core.requestScoreBoards(onScoreboardsRequested);
		callback();
		return;
		#end
		
		if (isLoggedIn)
		{
			log("already logged in");
			return;
		}
		
		ngDataLoaded.addOnce(callback);
		
		function onSessionFail(e:Error)
		{
			log("session failed:" + e.toString());
			ngDataLoaded.remove(callback);
			callback();
		}
		
		logDebug("connecting to newgrounds");
		NG.createAndCheckSession(APIStuff.APIID, DEBUG_SESSION, APIStuff.DebugSession, onSessionFail);
		NG.core.initEncryption(APIStuff.EncKey);
		NG.core.onLogin.add(onNGLogin);
		#if NG_VERBOSE NG.core.verbose = true; #end
		
		// Load scoreboards even if not logging in
		NG.core.requestScoreBoards(onScoreboardsRequested);
		
		if (!NG.core.attemptingLogin)
			callback();
	}
	
	static public function startManualSession(callback:ConnectResult->Void, onPending:((Bool)->Void)->Void):Void
	{
		if (NG.core == null)
			throw "call NGio.attemptLogin first";
		
		function onClickDecide(connect:Bool):Void
		{
			if (connect)
				NG.core.openPassportUrl();
			else
			{
				NG.core.cancelLoginRequest();
				callback(Cancelled);
			}
		}
		
		NG.core.requestLogin(
			callback.bind(Succeeded),
			onPending.bind(onClickDecide),
			(error)->callback(Failed(error)),
			callback.bind(Cancelled)
		);
	}
	
	static function onNGLogin():Void
	{
		isLoggedIn = true;
		userName = NG.core.user.name;
		logDebug('logged in! user:${NG.core.user.name}');
		NG.core.requestMedals(onMedalsRequested);
		
		ngDataLoaded.dispatch();
	}
	
	// --- SCOREBOARDS
	static function onScoreboardsRequested():Void
	{
		for (board in NG.core.scoreBoards)
		{
			log('Scoreboard loaded ${board.name}:${board.id}');
		}
	}
	
	// --- MEDALS
	static function onMedalsRequested():Void
	{
		#if NG_LOG
		var numMedals = 0;
		var numMedalsLocked = 0;
		for (medal in NG.core.medals)
		{
			trace('${medal.unlocked ? "unlocked" : "locked  "} - ${medal.name}');
			
			if (!medal.unlocked)
				numMedalsLocked++;
			
			numMedals++;
		}
		trace('loaded $numMedals medals, $numMedalsLocked locked ');
		#end
	}
	
	static public function unlockMedal(id:Int, showDebugUnlock = true):Void
	{
		if (isLoggedIn && !Calendar.isDebugDay)
		{
			log("unlocking " + id);
			var medal = NG.core.medals.get(id);
			if (!medal.unlocked)
				medal.sendUnlock();
			else if (showDebugUnlock)
				#if debug medal.onUnlock.dispatch();
				#else log("already unlocked");
				#end
		}
		else
			log('no medal unlocked, loggedIn:$isLoggedIn debugDay${!Calendar.isDebugDay}');
	}
	
	static public function hasMedal(id:Int):Bool
	{
		return isLoggedIn && NG.core.medals.get(id).unlocked;
	}
	
	inline static function logDebug(msg:String)
	{
		#if debug trace(msg); #end
	}
	
	inline static function log(msg:String)
	{
		#if NG_LOG trace(msg); #end
	}
}

enum ConnectResult
{
	Succeeded;
	Failed(error:Error);
	Cancelled;
}

