//
//  GameScene.h
//  Astro Archie
//
//  Created by Luke Roberts on 17/10/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MenuScene.h"
#import "Player.h"
#import "CollectablesManager.h"
#import "BackgroundManagerLayer.h"

@interface GameScene : CCLayer {
  CCLayer *gameLayer;
  CCLayer *hudLayer;
  CGSize screenSize;
  CCSprite *bg;
  BOOL _pauseScreenUp;
  CCMenu *_pauseScreenMenu;
  CCLayer *pauseLayer;
  Player *player;
}

@property(nonatomic, retain)CollectablesManager *collectableManager;
@property(nonatomic, retain)BackgroundManagerLayer *bgManager;

+(id)scene;
-(void)beginGameplay;
-(void)setUpScene;
-(void)gameResumed;
-(void)increaseAltitude;
-(void)startScoreTimer;

@end
