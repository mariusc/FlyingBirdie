//
//  HelloWorldLayer.m
//  joc
//
//  Created by Marius Constantinescu on 8/3/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#define bal_no 5
// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        CGSize size = [[CCDirector sharedDirector] winSize];
        dead = NO;
        
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"bum.mp3"]; 
        bg = [CCSprite spriteWithFile:@"bg.png"];
        bgf = [CCSprite spriteWithFile:@"bg.png"];
        bg.anchorPoint = ccp(0,0);
        bg.position = ccp(0,0); 
        bgf.anchorPoint = ccp(0,0);
        bgf.flipX = YES;
        bgf.position = ccp(size.width-4, 0);
        [self addChild:bg];
        [self addChild:bgf];
        [self scheduleUpdate];
        acc=1;
        self.isTouchEnabled=YES;
        
        speed = 3.0f;
        
        
        copaci = [CCSprite spriteWithFile:@"copaci-jos.png"];
        copaci.anchorPoint = ccp(0,0);
        copaci.position = ccp(0,-copaci.contentSize.height/4);
        [self addChild:copaci];
        
        copacif = [CCSprite spriteWithFile:@"copaci-jos.png"];
        copacif.anchorPoint = ccp(0,0);
        copacif.flipX = YES;
        copacif.position = ccp(size.width, -copaci.contentSize.height/4);
        [self addChild:copacif];
        
        nori =  [CCSprite spriteWithFile:@"nori-sus.png"];
        nori.anchorPoint = ccp(0, 0);
        nori.position = ccp(0, size.height-nori.contentSize.height);
        [self addChild:nori];
        
        norif = [CCSprite spriteWithFile:@"nori-sus.png"];
        norif.anchorPoint = ccp(0,0);
        norif.flipX = YES;
        norif.position = ccp(size.width, size.height-nori.contentSize.height);
        [self addChild:norif];
        
        
        baloane = [[CCArray alloc] initWithCapacity:bal_no];
        baloane_rezerva = [[CCArray alloc] initWithCapacity:bal_no];
        for(int i = 0; i < bal_no; i++)
        {
            float y=CCRANDOM_0_1()*(int)size.height;
            CCSprite* balon = [CCSprite spriteWithFile:@"balon.png"];
            balon.position = ccp(size.width + balon.contentSize.width/2 , y);
            //NSLog([NSString stringWithFormat:@"%f, %f", size.width, balon.contentSize.width]);
            [self addChild:balon z:10 tag:i];
            if (i==0)
            {
                [baloane addObject:balon];
                NSLog(@"count in init %d", [baloane count]);
            }
            else
                 [baloane_rezerva addObject:balon];
        }
        
        
        
        //baloane = [[CCArray alloc] initWithCapacity:bal_no];
        //baloane_rezerva = [[CCArray alloc] initWithCapacity:bal_no];
        //turn = 0;
        CCSpriteFrameCache *frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
        [frameCache addSpriteFramesWithFile:@"pasarici.plist"];
        
        
        pasarica = [CCSprite spriteWithSpriteFrameName:@"1.png" ];
        //[pasarica retain];
        
        
        
		// position the label on the center of the screen
		pasarica.position =  ccp( size.width /4 , size.height/2);
        //pasarica.scale = 0.5f;
        
        
        CCSpriteFrame *frame1 = [frameCache spriteFrameByName:@"1.png"];
        CCSpriteFrame *frame2 = [frameCache spriteFrameByName:@"2.png"];
        CCSpriteFrame *frame3 = [frameCache spriteFrameByName:@"3.png"];
        CCSpriteFrame *frame4 = [frameCache spriteFrameByName:@"4.png"];
        CCSpriteFrame *frame5 = [frameCache spriteFrameByName:@"5.png"];
        CCSpriteFrame *frame6 = [frameCache spriteFrameByName:@"6.png"];
        CCSpriteFrame *frame7 = [frameCache spriteFrameByName:@"7.png"];
        CCSpriteFrame *frame8 = [frameCache spriteFrameByName:@"8.png"];
        
        
        
        NSMutableArray *frames = [[[NSMutableArray alloc] init] autorelease];
        [frames addObject:frame1];
        [frames addObject:frame2];
        [frames addObject:frame3];
        [frames addObject:frame4];
        [frames addObject:frame5];
        [frames addObject:frame6];
        [frames addObject:frame7];
        [frames addObject:frame8];
        
        
        CCAnimation *anim = [CCAnimation animationWithName:@"move" delay:0.1f frames:frames];
        CCAnimate *animate = [CCAnimate actionWithAnimation:anim];
        CCRepeatForever *repeat = [CCRepeatForever actionWithAction:animate];
        
        [pasarica runAction:repeat];
        [self addChild: pasarica z:50];


        score = 0;
        
        label = [CCLabelTTF labelWithString:@"Distance: 0" fontName:@"STHeitiJ-Light" fontSize:15];
        //CCLOG(s);
        
        // position the label on the center of the screen
        label.position =  ccp( 10 + label.contentSize.width /2 , size.height - label.contentSize.height/2 - 2);
        label.color = ccBLACK;
        
        // add the label as a child to this Layer
        [self addChild: label z:40];
        /*
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Marker Felt" fontSize:64];

			
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height/2 );
		
		// add the label as a child to this Layer
		[self addChild: label];
         */
	}
	return self;
    
    
}





//==================== TOUCHES ======================




-(CGPoint) locationFromTouches:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView: [touch view]];
    return [[CCDirector sharedDirector] convertToGL:touchLocation];
}


//Called when a finger just begins touching the screen:
-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    //CGPoint touch = [self locationFromTouches:touches];
    
    //CGSize size = [[CCDirector sharedDirector] winSize];
    touched = YES;
    acc = 3;
    //NSLog(@"apas");
}

//Called when a finger is lifted off the screen:
-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    touched = NO;
    acc = 3;
}


//=======================================================




// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}








-(void) update:(ccTime)delta
{
    //CCSprite* sprite;
    if (dead == YES)
    {
        if (dead_timer > 0)
            dead_timer -= delta;
        else
        {
            
            //schimba scena
            [[CCDirector sharedDirector ] replaceScene: [HelloWorldLayer scene]];
        }
            return;
        
    }
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    ttime+=delta;
    //CCLOG(@"%f", ttime);
    score+=1;
    
    CCLOG(@"%d", score/20);
    
    CGPoint pos = pasarica.position;
    //NSLog(@"intru aici");
     if(touched)
     {
         if (pos.y < size.height - pasarica.contentSize.height*0.7)
         {
             //NSLog(@"intru si aici");
             pos.y += (delta * 30 * acc);
             acc += 0.2;
         }
     } 
    else 
    {
        if (pos.y > pasarica.contentSize.height*0.67)
        {
            pos.y -= (delta * 30 * acc);
            acc+=0.2;
        }
    }
    pasarica.position=pos;
    
    
    CGPoint bgpos = bg.position;
    bgpos.x -= 1;
    if (bgpos.x < -size.width+4)
    {
        bgpos.x += size.width*2 -4;
    }
    
    bg.position = bgpos;
    
    
    
    bgpos = bgf.position;
    bgpos.x -= 1;
    if (bgpos.x < -size.width+4)
    {
        bgpos.x += size.width*2 -4;
    }
    
    bgf.position = bgpos;
    
    bgpos = copacif.position;
    bgpos.x -= 2;
    if (bgpos.x < -size.width+4)
    {
        bgpos.x += size.width*2 -4;
    }
    
    copacif.position = bgpos;
    
    bgpos = copaci.position;
    bgpos.x -= 2;
    if (bgpos.x < -size.width+4)
    {
        bgpos.x += size.width*2 -4;
    }
    
    copaci.position = bgpos;
    
    bgpos = norif.position;
    bgpos.x -= 2;
    if (bgpos.x < -size.width+4)
    {
        bgpos.x += size.width*2 -4;
    }
    
    norif.position = bgpos;
    
    bgpos = nori.position;
    bgpos.x -= 2;
    if (bgpos.x < -size.width+4)
    {
        bgpos.x += size.width*2 -4;
    }
    
    nori.position = bgpos;
    
    total_timer += delta;
    if (total_timer > 10.0)
    {
        NSLog(@"increase speed");
        speed += 0.1;
        total_timer= 0;
    }
    timer += delta;
    
    //CCSprite * bal =[baloane objectAtIndex:turn]; 
    //CCSprite * bal2;
    //NSLog([NSString stringWithFormat:@"tagul este %d", bal.tag]);
    
    //NSLog(@"BLAAAAA %d ", [baloane count]);
    for (CCSprite *bal in baloane)
    {
        //NSLog(@"intru aici");
        bgpos = bal.position;
        bgpos.x -= speed;
        bal.position = bgpos;
        if (bal.position.x < -bal.contentSize.width/2)
        {
            [baloane_rezerva addObject:bal];
            [baloane removeObject:bal];
        }
    }
    CCSprite *bal = [baloane objectAtIndex:0];
    float delta_T = CCRANDOM_0_1();
    if (delta_T + timer > 2.0f)
    {
        timer=0;
        float y = CCRANDOM_0_1()*size.height;
        NSLog(@"baloane count %d, baloane_rezerva count %d", [baloane count], [baloane_rezerva count]);
        bal = [baloane_rezerva objectAtIndex:0];
        bal.position = ccp(size.width + bal.contentSize.width/2, y);
        [baloane addObject:bal];
        [baloane_rezerva removeObject:bal];
    }
    
    
    CGRect balonRect = CGRectMake(bal.position.x - bal.contentSize.width/2 + 10, bal.position.y - bal.contentSize.height/2, bal.contentSize.width, bal.contentSize.height);
    
    CGRect pasaricaRect = CGRectMake(pasarica.position.x - pasarica.contentSize.width/2, pasarica.position.y - pasarica.contentSize.height/2, pasarica.contentSize.width, pasarica.contentSize.height);
    
    
    
    if(CGRectIntersectsRect(balonRect, pasaricaRect)) 
    {
        CCSprite * bum = [CCSprite spriteWithFile:@"hit.png"];
        bum.scale=0.5;
        [[SimpleAudioEngine sharedEngine] playEffect:@"poc.mp3"];
        bum.position = pasarica.position;
        //CCScaleTo *scale =[CCScaleTo actionWithDuration:1 scale:3];
        CCHide *hide =[CCHide action];
        //CCSequence *seq = [CCSequence actions:scale, hide, nil];
        //[bum runAction:scale];
        [self addChild:bum];
        [pasarica runAction:hide];
        [bal stopAllActions];
        //bal.position = ccp(size.width + bal.contentSize.width/2 , 0);
        for (CCSprite *bal in baloane)
        {
            [bal stopAllActions];
        }
        [copaci stopAllActions];
        [nori stopAllActions];
        [bg stopAllActions];
        [bgf stopAllActions];
        //[self unscheduleUpdate];
        dead = YES;
        dead_timer = 2;
        
        
    }
    
    // create and initialize a Label
    NSString *s = [NSString stringWithFormat:@"Distance: %d", score/20];
    //label = [CCLabelTTF labelWithString:s fontName:@"STHeitiJ-Light" fontSize:15];
    //CCLOG(s);
    label.string = s;
    label.color = ccBLACK;
}





@end
/*==========================================
 - sa tin minte best distance in cadrul aceleiasi sesiuni a jocului - de intrebat alex cum tin minte
 - prezentare - la sfarsit
 
*/