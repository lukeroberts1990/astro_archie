//
//  MenuScene.m
//  Astro Archie
//
//  Created by Luke Roberts on 17/10/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuScene.h"
#include "SimpleAudioEngine.h"
#import "GameScene.h"


@implementation MenuScene

+(id)scene
{
  CCScene *scene =  [CCScene node];
  CCLayer *layer = [MenuScene node];
  [scene addChild:layer];
  return scene;
}

-(id)init
{
  if((self = [super init])){
    CCSprite *bg = [CCSprite spriteWithFile:@"menu_bg.png"];
    bg.anchorPoint = ccp(0,0);
    bg.position = ccp(0,0);
    [self addChild:bg z:-1];
    CCMenuItem *playButton = [CCMenuItemImage itemFromNormalImage:@"play_off.png" selectedImage:@"play_on.png"
                                                           target:self
                                                         selector:@selector(startGame)];
    CCMenuItem *settingsButton = [CCMenuItemImage itemFromNormalImage:@"settings_off.png" selectedImage:@"settings_on.png"
                                                           target:self
                                                         selector:@selector(startGame)];
    settingsButton.position = ccp(0, -60);
    CCMenu *menu = [CCMenu menuWithItems:playButton, settingsButton, nil];
    [self addChild:menu];
    [[SimpleAudioEngine  sharedEngine] playBackgroundMusic:@"luke loop 1.mp3" loop:YES];
  }
  return self;
}

-(void)startGame
{
  [[SimpleAudioEngine sharedEngine] playEffect:@"button_pushed.wav"];
  [[SimpleAudioEngine  sharedEngine] stopBackgroundMusic];
  GameScene * gs = [GameScene node];
  [[CCDirector sharedDirector] replaceScene: [CCTransitionZoomFlipX  transitionWithDuration:0.5 scene: gs]];
}

@end
