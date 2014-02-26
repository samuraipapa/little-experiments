//
//  MyScene.m
//  Chapter8-yury
//
//  Created by yg on 2/26/14.
//  Copyright (c) 2014 YuryGitman. All rights reserved.
//

#import "MyScene.h"
@interface MyScene()

@property SKSpriteNode * myCircle;
@property SKSpriteNode* mySquare;
@property SKSpriteNode* myTriangle;

@end

@implementation MyScene

-(void) myCircleAdd{
    
    _myCircle = [SKSpriteNode spriteNodeWithImageNamed:@"circle"];
    [_myCircle setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
    [self addChild:_myCircle];
    
}

-(void) mySquareAdd{
    _mySquare = [SKSpriteNode spriteNodeWithImageNamed:@"square"];
    [_mySquare setPosition:CGPointMake(self.size.width * 0.25, self.size.height * 0.5)];
    [self addChild:_mySquare];

}

-(void) myTriangleAdd{
    _myTriangle = [SKSpriteNode spriteNodeWithImageNamed:@"triangle"];
    [_myTriangle setPosition:CGPointMake(self.size.width*0.75, self.size.height/2)];
    [self addChild:_myTriangle];
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor blackColor];
        [self labelAdd];
        [self myCircleAdd];
        [self mySquareAdd];
        [self myTriangleAdd];
        
        }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

-(void) labelAdd{
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"TimeNewRoman"];
    
    myLabel.text = @"Chapter 8 - Yury";
    myLabel.fontSize = 18;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMaxY(self.frame)-30);
    
    [self addChild:myLabel];

}

@end
