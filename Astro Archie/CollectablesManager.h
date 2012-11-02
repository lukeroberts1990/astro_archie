//
//  CoinManager.h
//  Astro Archie
//
//  Created by Luke Roberts on 21/10/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Player.h"

@interface CollectablesManager : CCNode {
}

@property(nonatomic,retain)NSMutableArray *visibleCoins;
@property(nonatomic,retain)NSMutableArray *hiddenCoins;

-(id)initWithParentNode:(id)parentNode;
-(void)handleCollisionsWith:(Player *)player;
-(void)animateCoins:(int)distance;
-(void)populateObjects;
-(void)drawRandomLine;
-(void)drawSquare;
-(void)drawCircle;
-(void)drawDiamond;
-(void)drawTriangle;
-(void)shuffleHidden;
@end
