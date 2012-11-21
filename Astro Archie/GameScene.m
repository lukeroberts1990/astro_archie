//
//  GameScene.m
//  Astro Archie
//
//  Created by Luke Roberts on 17/10/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "PauseLayer.h"
#import "HUDLayer.h"
#import "SimpleAudioEngine.h"
#import "GameOverScene.h"


@implementation GameScene
@synthesize collectableManager = _coinManager;
@synthesize bgManager = _bgManager;

+(id)scene
{
  CCScene *scene =  [CCScene node];
  return scene;
}

-(id)init
{
  if((self = [super init])){
    _pauseScreenUp = NO;
    screenSize = [[CCDirector sharedDirector] winSize];
    gameLayer =  [CCLayer node];
    [self addChild:gameLayer z:0];
    [self setUpScene];
    [player takeOff];
  }
  return self;
}


-(void)beginGameplay{
  [[SimpleAudioEngine  sharedEngine] playBackgroundMusic:@"luke loop 3.mp3" loop:YES];
  self.isTouchEnabled = YES;
  self.isAccelerometerEnabled = YES;
  [self scheduleUpdate];
  [self schedule:@selector(increaseSpeed) interval:8];
}

-(void)setUpScene
{
  [self addBackgroundManager];
  [self addPlayer];
  [self addHUD];
}

-(void)addBackgroundManager
{
  self.bgManager = [[BackgroundManagerLayer alloc] initWithParentNode:gameLayer];
  [self setCollectableManager:[[CollectablesManager alloc] initWithParentNode:gameLayer]];
}

-(void)addPlayer
{
  player = [[Player alloc] initWithParentNode:gameLayer];
}

-(void)addHUD
{
  hudLayer = [[HUDLayer alloc] initWithParentNode:self];
  [self addChild:hudLayer];
}

-(void)pauseGame
{
  if(_pauseScreenUp == NO){
    [self buttonPushed];
    _pauseScreenUp= YES;
    [[SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
    [[CCDirector sharedDirector] pause];
    [PauseLayer pauseLayerWithParentNode:hudLayer];
  }
}

-(void)pushGameOverScene
{
  [[SimpleAudioEngine  sharedEngine] stopBackgroundMusic];
  [[SimpleAudioEngine  sharedEngine] playEffect:@"game_over.wav"];

  GameOverScene * gos = [[GameOverScene alloc] initWithScore:[player score]];
  [self unscheduleAllSelectors];
  [[CCDirector sharedDirector] replaceScene: [CCTransitionZoomFlipX  transitionWithDuration:0.5 scene: gos]];
}

-(void)gameResumed
{
  _pauseScreenUp = NO;
}

-(void)increaseSpeed
{
  float current = player.getYVelocity;
  current += current/4;
  [player  setTargetYVelocity:current];
  NSLog(@"increasing speed");
  
  //testing special creation having it create one every time velocity increases, Specials can be added elswhere to better effect
  [[self collectableManager] addSpecial:gameLayer];
  
}


-(void)update:(ccTime)delta
{
  [self increaseAltitude];
  [[self collectableManager] populateObjects];
  [[self collectableManager] handleCollisionsWith:player];
  [hudLayer updateWithPlayer:(Player *)player];
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
  [player applyAcceleration:acceleration];
}

-(void)buttonPushed
{
  [[SimpleAudioEngine sharedEngine] playEffect:@"button_pushed.wav"];
}

-(void)increaseAltitude
{
  [self.bgManager increaseAltitudeWithVelocity:[player getYVelocity]];
  //[player decrementFuel];
  if([player fuel] < 0){
    [self pushGameOverScene];
  }
  [[self collectableManager] animateCoins:[player getYVelocity]];
}

-(void)dealloc
{
  [self removeChild:player cleanup:YES];
  player = nil;
  [super dealloc];
}

@end
