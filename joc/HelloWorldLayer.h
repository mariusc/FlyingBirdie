//
//  HelloWorldLayer.h
//  joc
//
//  Created by Marius Constantinescu on 8/3/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "SimpleAudioEngine.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    
    BOOL touched;
    BOOL dead;
    float dead_timer;
    CCSprite* pasarica;
    float acc;
    float timer;
    float total_timer;
    float speed;
    int score;
    float ttime;
    CCSprite *bg;
    CCSprite *bgf;
    CCSprite *copaci;
    CCSprite *copacif;
    CCSprite *nori;
    CCSprite *norif;
    CCArray *baloane;
    CCLabelTTF *label;
    CCArray *baloane_rezerva;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
