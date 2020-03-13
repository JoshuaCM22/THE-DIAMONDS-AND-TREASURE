package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.getTimer;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.media.SoundChannel;
	public class TheDiamondsAndTreasure extends MovieClip // Created by: Joshua C. Magoliman
	{
		static const $GRAVITY_VALUE:Number = .004;
		static const $EDGE_DISTANCE_VALUE:Number = 0;
		private var _fixedObjects:Array;
		private var _otherObjects:Array;
		private var _enemiesLevel1:Array;
		private var _enemiesLevel2:Array;
		private var _enemiesLevel3:Array;
		private var _enemiesLevel4:Array;
		private var _level5Group1Enemies:Array;
		private var _level5Group2Enemies:Array;
		private var _torches:Array;
		private var _hiddenFloor:Array;
		private var _playerObjects:Array;
		private var _triangleSpikes:Array;
		private var _spinningSpikes:Array;
		private var _hero:Object;
		private var _heroHeadObject:Object;
		private var _heroHat:Object;
		private var _tunnel:Object;
		private var _deadLine:Object;
		private var _buttonAudio:Object;
		private var _buttonPause:Object;
		private var _exitDoorForLevel5:Object;
		private var _gottenDiamonds:int;
		private var _remainingDiamonds:int;
		private var _isTreasureGot:Boolean;
		private var _playerLives:int;
		private var _gameMode:String = "start";
		private var _currentLevel:String = "level1";
		private var _lastTime:Number = 0;
		private var _hiddenLeftSide:Array;
		private var _hiddenRightSide:Array;
		private var _soundTransform:SoundTransform = new SoundTransform();
		private var _soundHeroJump = new heroJump();
		private var _soundEnemyDied = new enemyDied();
		private var _soundHeroDied = new heroDied();
		private var _soundGotDiamond = new gotDiamond();
		private var _soundGotKey = new gotKey();
		private var _soundMain = new main();
		private var _soundLevel1 = new level1();
		private var _soundChannelLevel1:SoundChannel = new SoundChannel();
		private var _soundLevel2 = new level2();
		private var _soundChannelLevel2:SoundChannel = new SoundChannel();
		private var _soundLevel3 = new level3();
		private var _soundChannelLevel3:SoundChannel = new SoundChannel();
		private var _soundLevel4 = new level4();
		private var _soundChannelLevel4:SoundChannel = new SoundChannel();
		private var _soundLevel5 = new level5();
		private var _soundChannelLevel5:SoundChannel = new SoundChannel();
		public function startInitializingTheGame():void
		{
			_playerObjects = new Array();
			_buttonAudio = new Object();
			_buttonAudio = btnAudio;
			_buttonPause = new Object();
			_buttonPause = btnPause;
			_isTreasureGot = false;
			createHero();
			createHiddenFloors();
			examineLevel();
			this.addEventListener(Event.ENTER_FRAME,gameLoop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownFunction);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyUpFunction);
			plusGottenDiamonds(0);
			_gameMode = "play";
		}
		public function startGameLevel1():void
		{
			createEnemiesLevel1();
			createTunnel();
			createTorches();
			_gottenDiamonds = 0;
			_remainingDiamonds = 10;
			_currentLevel = "level1";
			_playerLives = 5;
			showLives();
			txtLevel.text = String("1");
			txtRemainingDiamonds.text = String("10");
			_soundChannelLevel1 = _soundLevel1.play(10,500);
		}
		public function startGameLevel2():void
		{
			createEnemiesLevel2();
			createHiddenWalls();
			createDeadLine();
			_remainingDiamonds = 10;
			txtLevel.text = String("2");
			txtRemainingDiamonds.text = String("10");
			_currentLevel = "level2";
			showLives();
			_soundChannelLevel1.stop();
			_soundChannelLevel2 = _soundLevel2.play(10,500);
		}
		public function startGameLevel3():void
		{
			createEnemiesLevel3();
			createHiddenWalls();
			createTriangleSpikes();
			createSpinningSpikes();
			_remainingDiamonds = 10;
			txtLevel.text = String("3");
			txtRemainingDiamonds.text = String("10");
			_currentLevel = "level3";
			showLives();
			_soundChannelLevel2.stop();
			_soundChannelLevel3 = _soundLevel3.play(10,500);
		}
		public function startGameLevel4():void
		{
			createEnemiesLevel4();
			createHiddenWalls();
			createDeadLine();
			createTriangleSpikes();
			_remainingDiamonds = 10;
			txtLevel.text = String("4");
			txtRemainingDiamonds.text = String("10");
			_currentLevel = "level4";
			showLives();
			_soundChannelLevel3.stop();
			_soundChannelLevel4 = _soundLevel4.play(10,500);
		}
		public function startGameLevel5():void
		{
			createEnemiesLevel5Group1();
			createEnemiesLevel5Group2();
			createExitDoorForLevel5();
			createSpinningSpikes();
			createTriangleSpikes();
			createTorches();
			createHiddenWalls();
			_remainingDiamonds = 10;
			txtLevel.text = String("5");
			txtRemainingDiamonds.text = String("10");
			_currentLevel = "level5";
			showLives();
			_soundChannelLevel4.stop();
			_soundChannelLevel5 = _soundLevel5.play(10,500);
		}
		private function createHero():void
		{
			_hero = new Object();
			_hero.mc = gamelevel.hero;
			_hero.dx = 0.0;
			_hero.dy = 0.0;
			_hero.inAir = false;
			_hero.direction = 1;
			_hero.animstate = "stand";
			_hero.walkAnimation = new Array(2,3,4,5,6,7,8);
			_hero.animstep = 0;
			_hero.jump = false;
			_hero.moveLeft = false;
			_hero.moveRight = false;
			_hero.jumpSpeed = .8;
			_hero.walkSpeed = .15;
			_hero.width = 20.0;
			_hero.height = 40.0;
			_hero.startx = _hero.mc.x;
			_hero.starty = _hero.mc.y;
			_heroHat = new Object();
			_heroHat.mc = gamelevel.hero.hat;
			_heroHeadObject = new Object();
			_heroHeadObject.mc = gamelevel.hero.headObject;
		}
		private function createTunnel():void
		{
			_tunnel = new Object();
			_tunnel.mc = gamelevel.tunnel;
		}
		private function createDeadLine():void
		{
			_deadLine = new Object();
			_deadLine.mc = gamelevel.deadLine;
		}
		private function createExitDoorForLevel5():void
		{
			_exitDoorForLevel5 = new Object();
			_exitDoorForLevel5.mc = gamelevel.door_Level5;
			_exitDoorForLevel5.mc.visible = false;
		}
		private function createEnemiesLevel1():void
		{
			_enemiesLevel1= new Array();
			var i:int = 1;
			while (true)
			{
				if (gamelevel["level1Enemy" + i] == null)
				{
					break;
				}
				var enemy = new Object();
				enemy.mc = gamelevel["level1Enemy" + i];
				enemy.dx = 0.0;
				enemy.dy = 0.0;
				enemy.inAir = false;
				enemy.direction = 1;
				enemy.animstate = "stand";
				enemy.walkAnimation = new Array(2,3,4,5);
				enemy.animstep = 0;
				enemy.jump = false;
				enemy.moveRight = true;
				enemy.moveLeft = false;
				enemy.jumpSpeed = 1.0;
				enemy.walkSpeed = .08;
				enemy.width = 30.0;
				enemy.height = 30.0;
				enemy.mc.visible = true;
				_enemiesLevel1.push(enemy);
				i++;
			}
		}
		private function createEnemiesLevel2():void
		{
			_enemiesLevel2 = new Array();
			var i:int = 1;
			while (true)
			{
				if (gamelevel["level2Enemy" + i] == null)
				{
					break;
				}
				var enemy = new Object();
				enemy.mc = gamelevel["level2Enemy" + i];
				enemy.dx = 0.0;
				enemy.dy = 0.0;
				enemy.inAir = false;
				enemy.direction = 1;
				enemy.animstate = "stand";
				enemy.walkAnimation = new Array(2,3,4,5);
				enemy.animstep = 0;
				enemy.jump = false;
				enemy.moveRight = true;
				enemy.moveLeft = false;
				enemy.jumpSpeed = 1.0;
				enemy.walkSpeed = .08;
				enemy.width = 30.0;
				enemy.height = 30.0;
				enemy.mc.visible = true;
				_enemiesLevel2.push(enemy);
				i++;
			}
		}
		private function createEnemiesLevel3():void
		{
			_enemiesLevel3= new Array();
			var i:int = 1;
			while (true)
			{
				if (gamelevel["level3Enemy" + i] == null)
				{
					break;
				}
				var enemy = new Object();
				enemy.mc = gamelevel["level3Enemy" + i];
				enemy.dx = 0.0;
				enemy.dy = 0.0;
				enemy.inAir = false;
				enemy.direction = 1;
				enemy.animstate = "stand";
				enemy.walkAnimation = new Array(2,3,4,5);
				enemy.animstep = 0;
				enemy.jump = false;
				enemy.moveRight = true;
				enemy.moveLeft = false;
				enemy.jumpSpeed = 1.0;
				enemy.walkSpeed = .08;
				enemy.width = 30.0;
				enemy.height = 30.0;
				enemy.mc.visible = true;
				_enemiesLevel3.push(enemy);
				i++;
			}
		}
		private function createEnemiesLevel4():void
		{
			_enemiesLevel4= new Array();
			var i:int = 1;
			while (true)
			{
				if (gamelevel["level4Enemy" + i] == null)
				{
					break;
				}
				var enemy = new Object();
				enemy.mc = gamelevel["level4Enemy" + i];
				enemy.dx = 0.0;
				enemy.dy = 0.0;
				enemy.inAir = false;
				enemy.direction = 1;
				enemy.animstate = "stand";
				enemy.walkAnimation = new Array(2,3,4,5);
				enemy.animstep = 0;
				enemy.jump = false;
				enemy.moveRight = true;
				enemy.moveLeft = false;
				enemy.jumpSpeed = 1.0;
				enemy.walkSpeed = .08;
				enemy.width = 30.0;
				enemy.height = 30.0;
				enemy.mc.visible = true;
				_enemiesLevel4.push(enemy);
				i++;
			}
		}
		private function createEnemiesLevel5Group1():void
		{
			_level5Group1Enemies= new Array();
			var i:int = 1;
			while (true)
			{
				if (gamelevel["level5Group1Enemy" + i] == null)
				{
					break;
				}
				var enemy = new Object();
				enemy.mc = gamelevel["level5Group1Enemy" + i];
				enemy.dx = 0.0;
				enemy.dy = 0.0;
				enemy.inAir = false;
				enemy.direction = 1;
				enemy.animstate = "stand";
				enemy.walkAnimation = new Array(2,3,4,5);
				enemy.animstep = 0;
				enemy.jump = false;
				enemy.moveRight = true;
				enemy.moveLeft = false;
				enemy.jumpSpeed = 1.0;
				enemy.walkSpeed = .09;
				enemy.width = 30.0;
				enemy.height = 30.0;
				enemy.mc.visible = true;
				_level5Group1Enemies.push(enemy);
				i++;
			}
		}
		private function createEnemiesLevel5Group2():void
		{
			_level5Group2Enemies= new Array();
			var i:int = 1;
			while (true)
			{
				if (gamelevel["level5Group2Enemy" + i] == null)
				{
					break;
				}
				var enemy = new Object();
				enemy.mc = gamelevel["level5Group2Enemy" + i];
				enemy.dx = 0.0;
				enemy.dy = 0.0;
				enemy.inAir = false;
				enemy.direction = 1;
				enemy.animstate = "stand";
				enemy.walkAnimation = new Array(2,3,4,5);
				enemy.animstep = 0;
				enemy.jump = false;
				enemy.moveRight = false;
				enemy.moveLeft = true;
				enemy.jumpSpeed = 1.0;
				enemy.walkSpeed = .15;
				enemy.width = 30.0;
				enemy.height = 30.0;
				enemy.mc.visible = true;
				_level5Group2Enemies.push(enemy);
				i++;
			}
		}
		private function createTorches():void
		{
			_torches = new Array();
			var t:int = 1;
			while (true)
			{
				if (gamelevel["torch" + t] == null)
				{
					break;
				}
				var Torch = new Object();
				Torch.mc = gamelevel["torch" + t];
				Torch.dx = 0.0;
				Torch.dy = 0.0;
				Torch.inAir = false;
				Torch.jump = false;
				Torch.moveRight = false;
				Torch.moveLeft = false;
				_torches.push(Torch);
				t++;
			}
		}
		private function createHiddenFloors():void
		{
			_hiddenFloor = new Array();
			var h:int = 1;
			while (true)
			{
				if (gamelevel["hiddenFloor" + h] == null)
				{
					break;
				}
				var hiddenFloor = new Object();
				hiddenFloor.mc = gamelevel["hiddenFloor" + h];
				hiddenFloor.mc.visible = false;
				hiddenFloor.dx = 0.0;
				hiddenFloor.dy = 0.0;
				hiddenFloor.inAir = false;
				hiddenFloor.jump = false;
				hiddenFloor.moveRight = false;
				hiddenFloor.moveLeft = false;
				_hiddenFloor.push(hiddenFloor);
				h++;
			}
		}
		private function createTriangleSpikes():void
		{
			_triangleSpikes = new Array();
			var h:int = 1;
			while (true)
			{
				if (gamelevel["triangleSpike" + h] == null)
				{
					break;
				}
				var triangleSpike = new Object();
				triangleSpike.mc = gamelevel["triangleSpike" + h];
				_triangleSpikes.push(triangleSpike);
				h++;
			}
		}
		private function createSpinningSpikes():void
		{
			_spinningSpikes = new Array();
			var h:int = 1;
			while (true)
			{
				if (gamelevel["spinningSpike" + h] == null)
				{
					break;
				}
				var spinningSpike = new Object();
				spinningSpike.mc = gamelevel["spinningSpike" + h];
				spinningSpike.dx = 0.0;
				spinningSpike.dy = 0.0;
				_spinningSpikes.push(spinningSpike);
				h++;
			}
		}
		private function createHiddenWalls():void
		{
			_hiddenLeftSide = new Array();
			var n:int = 1;
			while (true)
			{
				if (gamelevel["leftSide" + n] == null)
				{
					break;
				}
				var leftSide = new Object();
				leftSide.mc = gamelevel["leftSide" + n];
				_hiddenLeftSide.push(leftSide);
				n++;
			}
			var i:int = 1;
			_hiddenRightSide = new Array();
			while (true)
			{
				if (gamelevel["rightSide" + i] == null)
				{
					break;
				}
				var rightSide = new Object();
				rightSide.mc = gamelevel["rightSide" + i];
				_hiddenRightSide.push(rightSide);
				i++;
			}
		}
		private function examineLevel():void
		{
			_fixedObjects = new Array();
			_otherObjects = new Array();
			for (var i:int=0; i<this.gamelevel.numChildren; i++)
			{
				var mc = this.gamelevel.getChildAt(i);
				if ((mc is floor_Level1) || (mc is wall_Level1))
				{
					var floorObject:Object = new Object();
					floorObject.mc = mc;
					floorObject.leftside = mc.x;
					floorObject.rightside = mc.x + mc.width;
					floorObject.topside = mc.y;
					floorObject.bottomside = mc.y + mc.height;
					_fixedObjects.push(floorObject);
				}
				else if ( (mc is diamond) || (mc is key_Level1) || (mc is door_Level1) || (mc is key_Level2) || (mc is door_Level2) || (mc is key_Level3) || (mc is door_Level3) || (mc is key_Level4) || (mc is door_Level4) || (mc is treasure) || (mc is door_Level5)   )
				{
					_otherObjects.push(mc);
				}
			}
		}
		private function keyDownFunction(event:KeyboardEvent):void
		{
			if (_gameMode != "play")
			{
				return;
			}
			switch (event.keyCode)
			{
				case 37 :// 37 = Left Arrow
					_hero.moveLeft = true;
					break;

				case 39 :// 39 = Right Arrow
					_hero.moveRight = true;
					break;
				case 32 :// 32 = Spacebar
					if (! _hero.inAir)
					{
						_hero.jump = true;
					}
					break;
			}
		}
		private function keyUpFunction(event:KeyboardEvent):void
		{
			if (event.keyCode == 37)
			{
				_hero.moveLeft = false;
			}
			else if (event.keyCode == 39)
			{
				_hero.moveRight = false;
			}
		}
		private function gameLoop(event:Event):void
		{
			if (_lastTime == 0)
			{
				_lastTime = getTimer();
			}
			var timeDiff:int = getTimer() - _lastTime;
			_lastTime +=  timeDiff;
			if (_gameMode == "play" )
			{
				if (_currentLevel == "level1")
				{
					moveCharacter(_hero,timeDiff);
					moveEnemies(timeDiff, _enemiesLevel1);
					collisionByEnemy(_enemiesLevel1);
				}
				else if (_currentLevel == "level2")
				{
					moveCharacter(_hero,timeDiff);
					moveEnemies(timeDiff, _enemiesLevel2);
					collisionByEnemy(_enemiesLevel2);
				}
				else if (_currentLevel == "level3")
				{
					moveCharacter(_hero,timeDiff);
					moveEnemies(timeDiff, _enemiesLevel3);
					collisionByEnemy(_enemiesLevel3);
				}
				else if (_currentLevel == "level4")
				{
					moveCharacter(_hero,timeDiff);
					moveEnemies(timeDiff, _enemiesLevel4);
					collisionByEnemy(_enemiesLevel4);
				}
				else if (_currentLevel == "level5")
				{
					moveCharacter(_hero,timeDiff);
					moveEnemies(timeDiff, _level5Group1Enemies);
					moveEnemies(timeDiff, _level5Group2Enemies);
					collisionByEnemy(_level5Group1Enemies);
					collisionByEnemy(_level5Group2Enemies);
					if (txtRemainingDiamonds.text == ("0") && _isTreasureGot == true)
					{
						_exitDoorForLevel5.mc.visible = true;
					}
				}
				checkCollisions();
			}
		}
		private function moveEnemies(param_Time:int, param_enemyLevelName:Array):void
		{
			for (var i:int=0; i<param_enemyLevelName.length; i++)
			{
				moveCharacter(param_enemyLevelName[i],param_Time);
				if (_currentLevel == "level1")
				{
					if (param_enemyLevelName[i].hitWallRight)
					{
						param_enemyLevelName[i].moveLeft = true;
						param_enemyLevelName[i].moveRight = false;
					}
					else if (param_enemyLevelName[i].hitWallLeft)
					{
						param_enemyLevelName[i].moveLeft = false;
						param_enemyLevelName[i].moveRight = true;
					}
				}
				else if (_currentLevel == "level2" || _currentLevel == "level3" || _currentLevel == "level4" || _currentLevel == "level5")
				{
					for (var b:int=param_enemyLevelName.length-1; b>=0; b--)
					{
						for (var left:int=_hiddenLeftSide.length-1; left>=0; left--)
						{
							if (param_enemyLevelName[b].mc.hitTestObject(_hiddenLeftSide[left].mc))
							{
								param_enemyLevelName[b].moveLeft = false;
								param_enemyLevelName[b].moveRight = true;
							}
						}
						for (var right:int=_hiddenRightSide.length-1; right>=0; right--)
						{
							if (param_enemyLevelName[b].mc.hitTestObject(_hiddenRightSide[right].mc))
							{
								param_enemyLevelName[b].moveLeft = true;
								param_enemyLevelName[b].moveRight = false;
							}
						}
					}
				}
			}
		}
		private function moveCharacter(param_Hero:Object,param_Time:Number):void
		{
			if (param_Time < 1)
			{
				return;
			}
			// assume character pulled down by gravity
			var verticalChange:Number = param_Hero.dy * param_Time + param_Time * $GRAVITY_VALUE;
			if (verticalChange > 15.0)
			{
				verticalChange = 15.0;
			}
			param_Hero.dy +=  param_Time * $GRAVITY_VALUE;
			// react to changes from key presses
			var horizontalChange = 0;
			var newAnimState:String = "stand";
			var newDirection:int = param_Hero.direction;
			if (param_Hero.moveLeft)
			{
				// walk left
				horizontalChange =  -  param_Hero.walkSpeed * param_Time;
				newAnimState = "walk";
				newDirection = -1;
			}
			else if (param_Hero.moveRight)
			{
				// walk right
				horizontalChange = param_Hero.walkSpeed * param_Time;
				newAnimState = "walk";
				newDirection = 1;
			}
			if (param_Hero.jump)
			{
				// start jump
				param_Hero.jump = false;
				newAnimState = "jump";
				param_Hero.dy =  -  param_Hero.jumpSpeed;
				verticalChange =  -  param_Hero.jumpSpeed;
				_soundTransform.volume = 1;
				_soundHeroJump.play(0,0,_soundTransform);
			}
			// assume no wall hit, and hanging in air
			param_Hero.hitWallRight = false;
			param_Hero.hitWallLeft = false;
			param_Hero.inAir = true;
			// find new vertical position
			var newY:Number = param_Hero.mc.y + verticalChange;
			// loop through all fixed objects to see if character has landed
			for (var i:int=0; i<_fixedObjects.length; i++)
			{
				if ((param_Hero.mc.x+param_Hero.width/2 > _fixedObjects[i].leftside) && (param_Hero.mc.x-param_Hero.width/2 < _fixedObjects[i].rightside))
				{
					if ((param_Hero.mc.y <= _fixedObjects[i].topside) && (newY > _fixedObjects[i].topside))
					{
						newY = _fixedObjects[i].topside;
						param_Hero.dy = 0;
						param_Hero.inAir = false;
						break;
					}
				}
			}
			// find new horizontal position
			var newX:Number = param_Hero.mc.x + horizontalChange;
			// loop through all objects to see if character has bumped into a wall
			for (i=0; i<_fixedObjects.length; i++)
			{
				if ((newY > _fixedObjects[i].topside) && (newY-param_Hero.height < _fixedObjects[i].bottomside))
				{
					if ((param_Hero.mc.x-param_Hero.width/2 >= _fixedObjects[i].rightside) && (newX-param_Hero.width/2 <= _fixedObjects[i].rightside))
					{
						newX = _fixedObjects[i].rightside + param_Hero.width / 2;
						param_Hero.hitWallLeft = true;
						break;
					}
					if ((param_Hero.mc.x+param_Hero.width/2 <= _fixedObjects[i].leftside) && (newX+param_Hero.width/2 >= _fixedObjects[i].leftside))
					{
						newX = _fixedObjects[i].leftside - param_Hero.width / 2;
						param_Hero.hitWallRight = true;
						break;
					}
				}
			}
			// set position of character
			param_Hero.mc.x = newX;
			param_Hero.mc.y = newY;
			// set animation state
			if (param_Hero.inAir)
			{
				newAnimState = "jump";
			}
			param_Hero.animstate = newAnimState;
			// move along walk cycle
			if (param_Hero.animstate == "walk")
			{
				param_Hero.animstep +=  param_Time / 100;
				if (param_Hero.animstep > param_Hero.walkAnimation.length)
				{
					param_Hero.animstep = 0;
				}
				// not walking, show stand or jump state
				param_Hero.mc.gotoAndStop(param_Hero.walkAnimation[Math.floor(param_Hero.animstep)]);
			}
			else
			{
				param_Hero.mc.gotoAndStop(param_Hero.animstate);
			}
			// changed directions;
			if (newDirection != param_Hero.direction)
			{
				param_Hero.direction = newDirection;
				param_Hero.mc.scaleX = param_Hero.direction;
			}
		}
		private function checkCollisions():void
		{
			if (_currentLevel == "level1")
			{
				if (_hero.mc.hitTestObject(_tunnel.mc))
				{
					if (_hero.inAir)
					{
						_hero.dy = 5;
					}
				}
				hitTestOfHeroAndTorches();
			}
			else if (_currentLevel == "level2" || _currentLevel == "level4")
			{
				if (_heroHat.mc.hitTestObject(_deadLine.mc))
				{
					heroCurrentlyDiedByFallen();
					_soundHeroDied.play();
					_hero.mc.visible = false;
				}
			}
			else if (_currentLevel == "level3")
			{
				hitTestOfHeroAndTriangleSpikes();
				hitTestOfHeroAndSpinningSpikes();
			}
			if (_currentLevel == "level4")
			{
				hitTestOfHeroAndTriangleSpikes();
			}
			else if (_currentLevel == "level5")
			{
				hitTestOfHeroAndTorches();
				hitTestOfHeroAndTriangleSpikes();
				hitTestOfHeroAndSpinningSpikes();
			}
			for (var h:int=_hiddenFloor.length-1; h>=0; h--)
			{
				if (_heroHat.mc.hitTestObject(_hiddenFloor[h].mc))
				{
						_hero.dy = 1;
				}
			}
			for (h=_otherObjects.length-1; h>=0; h--)
			{
				if (_hero.mc.hitTestObject(_otherObjects[h]))
				{
					getObject(h);
				}
			}
		}
		private function hitTestOfHeroAndTorches():void
		{
			for (var t:int=_torches.length-1; t>=0; t--)
			{
				if (_hero.mc.hitTestObject(_torches[t].mc))
				{
					heroCurrentlyDiedByFire();
					_hero.mc.gotoAndPlay("burn");
				}
			}
		}
		private function hitTestOfHeroAndSpinningSpikes():void
		{
			for (var sp:int=_spinningSpikes.length-1; sp>=0; sp--)
			{
				if (_heroHeadObject.mc.hitTestObject(_spinningSpikes[sp].mc))
				{
					heroCurrentlyDiedByEnemy();
					_soundHeroDied.play();
				}
			}
		}
		private function hitTestOfHeroAndTriangleSpikes():void
		{
			for (var ts:int=_triangleSpikes.length-1; ts>=0; ts--)
			{
				if (_hero.mc.hitTestObject(_triangleSpikes[ts].mc))
				{
					heroCurrentlyDiedByEnemy();
					_soundHeroDied.play();
				}
			}
		}
		private function collisionByEnemy(enemyLevelName:Array):void
		{
			for (var i:int=enemyLevelName.length-1; i>=0; i--)
			{
				if (_hero.mc.hitTestObject(enemyLevelName[i].mc))
				{
					if (_hero.inAir && (_hero.dy > 0)) // If hero is jumped in enemy
					{
						enemyDie(i, enemyLevelName); // Enemy die
						_soundEnemyDied.play();
					}
					else // If not
					{
						heroCurrentlyDiedByEnemy(); // Hero die
						_soundHeroDied.play();
					}
				}
			}
		}
		private function enemyDie(enemyNum:int, enemyLevelName:Array):void
		{
			var pointBurst:PointBurst = new PointBurst(gamelevel,"I got you!",enemyLevelName[enemyNum].mc.x,enemyLevelName[enemyNum].mc.y - 20);
			enemyLevelName[enemyNum].mc.visible = false;
			enemyLevelName.splice(enemyNum,1);
		}
		private function turnTheHeroInRightSide(char:Object):void
		{
			var horizontalChange = 0;
			var newAnimState:String = "stand";
			var newDirection:int = char.direction;
			// Face right side
			newDirection = 1;
			// Changed directions
			if (newDirection != char.direction)
			{
				char.direction = newDirection;
				char.mc.scaleX = char.direction;
			}
		}
		private function heroCurrentlyDiedByEnemy():void
		{			
			var d:dialogMessage = new dialogMessage();
			d.x = 410;
			d.y = 130;
			addChild(d); // show dialog box
			if (_playerLives == 0)
			{
				_gameMode = "gameover";
				d.message.text = "Game Over!";
			}
			else
			{
				_gameMode = "dead";
				d.message.text = "You are dead!";
				_playerLives--;
			}
			_hero.mc.gotoAndPlay("die");
		}
		private function heroCurrentlyDiedByFire():void
		{
			var d:dialogMessage = new dialogMessage();
			d.x = 410;
			d.y = 130;
			addChild(d); // show dialog box
			if (_playerLives == 0)
			{
				_gameMode = "gameover";
				d.message.text = "Game Over!";
			}
			else
			{
				_gameMode = "dead";
				d.message.text = "You are burned!";
				_playerLives--;
			}
			_soundHeroDied.play();
		}
		private function heroCurrentlyDiedByFallen():void
		{
			var d:dialogMessage = new dialogMessage();
			d.x = 410;
			d.y = 130;
			addChild(d); // show dialog box
			if (_playerLives == 0)
			{
				_gameMode = "gameover";
				d.message.text = "Game Over!";
			}
			else
			{
				_playerLives--;
				_gameMode = "dead";
				d.message.text = "You are fallen!";
			}
		}
		// Player collides with objects
		private function getObject(param_ObjectNumber:int)
		{
			if (_otherObjects[param_ObjectNumber] is diamond)
			{
				var pointBurst:PointBurst = new PointBurst(gamelevel,"Yeah!",_otherObjects[param_ObjectNumber].x,_otherObjects[param_ObjectNumber].y);
				gamelevel.removeChild(_otherObjects[param_ObjectNumber]);
				_otherObjects.splice(param_ObjectNumber,1);
				_soundGotDiamond.play();
				plusGottenDiamonds(1);
				minusRemainingDiamonds(1);
			}
			else if (_otherObjects[param_ObjectNumber] is key_Level1)
			{
				pointBurst = new PointBurst(gamelevel,"I got a key!",_otherObjects[param_ObjectNumber].x,_otherObjects[param_ObjectNumber].y);
				_playerObjects.push("key_Level1");
				gamelevel.removeChild(_otherObjects[param_ObjectNumber]);
				_soundGotKey.play();
				_otherObjects.splice(param_ObjectNumber,1);
			}
			else if (_otherObjects[param_ObjectNumber] is door_Level1 && txtRemainingDiamonds.text == ("0"))
			{
				if (_playerObjects.indexOf("key_Level1") == -1)
				{
					return;
				}
				if (_otherObjects[param_ObjectNumber].currentFrame == 1)
				{
					_otherObjects[param_ObjectNumber].gotoAndPlay("open");
					completeLevel1();
				}
			}
			else if (_otherObjects[param_ObjectNumber] is key_Level2)
			{
				pointBurst = new PointBurst(gamelevel,"I got a key!",_otherObjects[param_ObjectNumber].x,_otherObjects[param_ObjectNumber].y);
				_playerObjects.push("key_Level2");
				gamelevel.removeChild(_otherObjects[param_ObjectNumber]);
				_soundGotKey.play();
				_otherObjects.splice(param_ObjectNumber,1);
			}
			else if (_otherObjects[param_ObjectNumber] is door_Level2 && txtRemainingDiamonds.text == ("0"))
			{
				if (_playerObjects.indexOf("key_Level2") == -1)
				{
					return;
				}
				if (_otherObjects[param_ObjectNumber].currentFrame == 1)
				{
					_otherObjects[param_ObjectNumber].gotoAndPlay("open");
					completeLevel2();
				}
			}
			else if (_otherObjects[param_ObjectNumber] is key_Level3)
			{
				pointBurst = new PointBurst(gamelevel,"I got a key!",_otherObjects[param_ObjectNumber].x,_otherObjects[param_ObjectNumber].y);
				_playerObjects.push("key_Level3");
				gamelevel.removeChild(_otherObjects[param_ObjectNumber]);
				_soundGotKey.play();
				_otherObjects.splice(param_ObjectNumber,1);
			}
			else if (_otherObjects[param_ObjectNumber] is door_Level3 && txtRemainingDiamonds.text == ("0"))
			{
				if (_playerObjects.indexOf("key_Level3") == -1)
				{
					return;
				}
				if (_otherObjects[param_ObjectNumber].currentFrame == 1)
				{
					_otherObjects[param_ObjectNumber].gotoAndPlay("open");
					completeLevel3();
				}
			}
			else if (_otherObjects[param_ObjectNumber] is key_Level4)
			{
				pointBurst = new PointBurst(gamelevel,"I got a key!",_otherObjects[param_ObjectNumber].x,_otherObjects[param_ObjectNumber].y);
				_playerObjects.push("key_Level4");
				gamelevel.removeChild(_otherObjects[param_ObjectNumber]);
				_soundGotKey.play();
				_otherObjects.splice(param_ObjectNumber,1);
			}
			else if (_otherObjects[param_ObjectNumber] is door_Level4 && txtRemainingDiamonds.text == ("0"))
			{
				if (_playerObjects.indexOf("key_Level4") == -1)
				{
					return;
				}
				if (_otherObjects[param_ObjectNumber].currentFrame == 1)
				{
					_otherObjects[param_ObjectNumber].gotoAndPlay("open");
					completeLevel4();
				}
			}
			else if (_otherObjects[param_ObjectNumber] is door_Level5 && txtRemainingDiamonds.text == ("0") && _isTreasureGot == true)
			{
				if (_otherObjects[param_ObjectNumber].currentFrame == 1)
				{
					completeLevel5();
				}
			}
			else if (_otherObjects[param_ObjectNumber] is treasure)
			{
				_otherObjects[param_ObjectNumber].gotoAndStop("open");
				pointBurst = new PointBurst(gamelevel,"YES!",_otherObjects[param_ObjectNumber].x,_otherObjects[param_ObjectNumber].y);
				_playerObjects.push("treasure");
				gamelevel.removeChild(_otherObjects[param_ObjectNumber]);
				_isTreasureGot = true;
				_soundGotKey.play();
				_otherObjects.splice(param_ObjectNumber,1);
			}
		}
		private function plusGottenDiamonds(numPoints:int):void
		{
			_gottenDiamonds +=  numPoints;
			txtGottenDiamonds.text = String(_gottenDiamonds);
		}
		private function minusRemainingDiamonds(numPoints:int):void
		{
			_remainingDiamonds -=  numPoints;
			txtRemainingDiamonds.text = String(_remainingDiamonds);
		}
		private function showLives():void
		{
			txtLives.text = String(_playerLives);
		}
		private function completeLevel1():void
		{
			_gameMode = "completelevel1";
			var d:dialogMessage = new dialogMessage();
			d.x = 410;
			d.y = 130;
			addChild(d);
			d.message.text = "Level 1 Complete!";
		}
		private function completeLevel2():void
		{
			_gameMode = "completelevel2";
			var d:dialogMessage = new dialogMessage();
			d.x = 410;
			d.y = 130;
			addChild(d);
			d.message.text = "Level 2 Complete!";
		}
		private function completeLevel3():void
		{
			_gameMode = "completelevel3";
			var d:dialogMessage = new dialogMessage();
			d.x = 410;
			d.y = 130;
			addChild(d);
			d.message.text = "Level 3 Complete!";
		}
		private function completeLevel4():void
		{
			_gameMode = "completelevel4";
			var d:dialogMessage = new dialogMessage();
			d.x = 410;
			d.y = 130;
			addChild(d);
			d.message.text = "Level 4 Complete!";
		}
		private function completeLevel5():void
		{
			_gameMode = "completelevel5";
			var d:dialogMessage = new dialogMessage();
			d.x = 410;
			d.y = 130;
			addChild(d);
			d.message.text = "Level 5 Complete!";
		}
		public function clickDialogButton(event:MouseEvent):void
		{
			removeChild(MovieClip(event.currentTarget.parent));
			if (_gameMode == "dead")
			{
				// reset _hero
				_hero.mc.visible = true;
				turnTheHeroInRightSide(_hero);
				_hero.dx = 0.0;
				_hero.dy = 0.0;
				_hero.mc.x = _hero.startx;
				_hero.mc.y = _hero.starty;
				_gameMode = "play";
				showLives();
				creatingSpecificEnemies();
			}
			if (_gameMode == "gameover")
			{
				showContinueDialog();
			}
			else if (_gameMode == "completelevel1")
			{
				cleanUp();
				nextFrame();
			}
			else if (_gameMode == "completelevel2")
			{
				cleanUp();
				nextFrame();
			}
			else if (_gameMode == "completelevel3")
			{
				cleanUp();
				nextFrame();
			}
			else if (_gameMode == "completelevel4")
			{
				cleanUp();
				nextFrame();
			}
			else if (_gameMode == "completelevel5")
			{
				_soundChannelLevel5.stop();
				cleanUp();
				gotoAndPlay(180);
			}
			// Give the keyboard focus in game
			stage.focus = stage;
		}
		private function creatingSpecificEnemies():void
		{
			switch (_currentLevel)
			{
				case "level1" :
					createEnemiesLevel1();
					break;
				case "level2" :
					createEnemiesLevel2();
					break;
				case "level3" :
					createEnemiesLevel3();
					break;
				case "level4" :
					createEnemiesLevel4();
					break;
				case "level5" :
					createEnemiesLevel5Group1();
					createEnemiesLevel5Group2();
					break;
			}
		}
		public function continueDialogYesButtonClicked(event:MouseEvent):void
		{
			removeChild(MovieClip(event.currentTarget.parent));
			if (_playerLives == 0)
			{
				_playerLives = 5;
				showLives();
				turnTheHeroInRightSide(_hero);
				_hero.mc.x = _hero.startx;
				_hero.mc.y = _hero.starty;
				_hero.dx = 0.0;
				_hero.dy = 0.0;
				_hero.mc.visible = true;
				creatingSpecificEnemies();
				_gameMode = "play";
			}
			// Give the keyboard focus in game
			stage.focus = stage;
		}
		public function continueDialogNoButtonClicked(event:MouseEvent):void
		{
			switch (_currentLevel)
			{
				case "level1" :
					_soundChannelLevel1.stop();
					break;
				case "level2" :
					_soundChannelLevel2.stop();
					break;
				case "level3" :
					_soundChannelLevel3.stop();
					break;
				case "level4" :
					_soundChannelLevel4.stop();
					break;
				case "level5" :
					_soundChannelLevel5.stop();
					break;
			}
			removeChild(MovieClip(event.currentTarget.parent));
			gotoAndStop(12);
			// Give the keyboard focus in game
			stage.focus = stage;
		}
		public function buttonResumeClicked(event:MouseEvent):void
		{
			removeChild(MovieClip(event.currentTarget.parent));
			btnPause.visible = true;
			btnPlay.visible = false;
			_gameMode = "play";
			// Give the keyboard focus in game
			stage.focus = stage;
		}
		public function buttonQuitClicked(event:MouseEvent):void
		{
			removeChild(MovieClip(event.currentTarget.parent));
			var d:dialogQuit = new dialogQuit();
			d.x = 360;
			d.y = 120;
			addChild(d);
			// Give the keyboard focus in game
			stage.focus = stage;
		}
		public function quitDialogButtonYesClicked(event:MouseEvent):void
		{
			removeChild(MovieClip(event.currentTarget.parent));
			switch (_currentLevel)
			{
				case "level1" :
					_soundChannelLevel1.stop();
					break;
				case "level2" :
					_soundChannelLevel2.stop();
					break;
				case "level1" :
					_soundChannelLevel3.stop();
					break;
				case "level4" :
					_soundChannelLevel4.stop();
					break;
				case "level5" :
					_soundChannelLevel5.stop();
					break;
			}
			SoundMixer.soundTransform = new SoundTransform(1);
			gotoAndStop(12);
			// Give the keyboard focus in game
			stage.focus = stage;
		}
		public function quitDialogButtonNoClicked(event:MouseEvent):void
		{
			removeChild(MovieClip(event.currentTarget.parent));
			var d:dialogPaused = new dialogPaused();
			d.x = 340;
			d.y = 120;
			addChild(d);
			// Give the keyboard focus in game
			stage.focus = stage;
		}
		public function showContinueDialog():void
		{
			var d:dialogContinue = new dialogContinue();
			d.x = 410;
			d.y = 130;
			addChild(d);
		}
		private function cleanUp():void
		{
			removeChild(gamelevel);
			this.removeEventListener(Event.ENTER_FRAME,gameLoop);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyDownFunction);
			stage.removeEventListener(KeyboardEvent.KEY_UP,keyUpFunction);
		}
	}
}