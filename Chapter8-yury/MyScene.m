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
@property SKSpriteNode* myOctagon;
@property SKSpriteNode* sand;
@property CGPoint pointTouched;

@end

@implementation MyScene


-(void) myCircleAdd{
    
    _myCircle = [SKSpriteNode spriteNodeWithImageNamed:@"circle"];
    [_myCircle setPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))];
    _myCircle.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_myCircle.size.width/2];
    
    [self addChild:_myCircle];
    
}

-(void) mySquareAdd{
    _mySquare = [SKSpriteNode spriteNodeWithImageNamed:@"square"];
    [_mySquare setPosition:CGPointMake(self.size.width * 0.25, self.size.height * 0.5)];
    _mySquare.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_mySquare.size];
    [self addChild:_mySquare];

}

-(void) myTriangleAdd{
    _myTriangle = [SKSpriteNode spriteNodeWithImageNamed:@"triangle"];
    [_myTriangle setPosition:CGPointMake(self.size.width*0.75, self.size.height/2)];
    
    CGMutablePathRef trianglePath = CGPathCreateMutable();
    CGPathMoveToPoint(trianglePath, nil, _myTriangle.size.width/2, -_myTriangle.size.height/2);
    CGPathAddLineToPoint(trianglePath, nil, 0, _myTriangle.size.height/2);
    CGPathAddLineToPoint(trianglePath, nil, -_myTriangle.size.width/2, -_myTriangle.size.height/2);
    CGPathAddLineToPoint(trianglePath, nil, _myTriangle.size.width/2, -_myTriangle.size.height/2);
    
    _myTriangle.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:trianglePath];
    CGPathRelease(trianglePath);
    
    [self addChild:_myTriangle];
}



-(void) myOctagonAdd{
    
    _myOctagon = [SKSpriteNode spriteNodeWithImageNamed:@"octagon"];
    [_myOctagon setPosition:CGPointMake(self.size.width*0.45, self.size.height * 0.75)];
    
    CGMutablePathRef octPath = CGPathCreateMutable();
    CGPathMoveToPoint(octPath, nil, _myOctagon.size.width/4, -_myOctagon.size.height/2);
    CGPathAddLineToPoint(octPath, nil, _myOctagon.size.width/2, -_myOctagon.size.height/4);
    CGPathAddLineToPoint(octPath, nil, _myOctagon.size.width/2, _myOctagon.size.height/4);
    CGPathAddLineToPoint(octPath, nil, _myOctagon.size.width/4, _myOctagon.size.height/2);
    CGPathAddLineToPoint(octPath, nil, -_myOctagon.size.width/4, _myOctagon.size.height/2);
    CGPathAddLineToPoint(octPath, nil, -_myOctagon.size.width/2, _myOctagon.size.height/4);
    CGPathAddLineToPoint(octPath, nil, -_myOctagon.size.width/2, -_myOctagon.size.height/4);
    CGPathAddLineToPoint(octPath, nil, -_myOctagon.size.width/4, -_myOctagon.size.height/2);
    CGPathAddLineToPoint(octPath, nil, _myOctagon.size.width/4, -_myOctagon.size.height/2);

    _myOctagon.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:octPath];
    CGPathRelease(octPath);
    
    [self addChild:_myOctagon];
    
    
}

-(void) spawnSand{
    
    _sand = [SKSpriteNode spriteNodeWithImageNamed:@"sand"];
   
    _sand.position = CGPointMake((float)(arc4random()%(int)self.size.width), self.size.height - _sand.size.height);
    _sand.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_sand.size.width/2];
    _sand.physicsBody.restitution = 1.0;
    
    
    //   _pointTouched = CGPointMake(self.size.width, self.size.height/2);
//    _sand.position = CGPointMake(self.size.width/2, self.size.height/2);
//    _sand.position = _pointTouched;
    
    [self addChild:_sand];
}

-(void) spawnBunchOfSand{
    [self runAction:[SKAction repeatAction:[SKAction sequence:@[[SKAction performSelector:@selector(spawnSand) onTarget:self] ,
                                                                [SKAction waitForDuration:0.02]
                                                                ]]
            count:30]
     ];
     
}


-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor whiteColor];
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody.restitution = 1.0;
        
        [self labelAdd];
        [self myCircleAdd];
        [self mySquareAdd];
        [self myTriangleAdd];
        [self myOctagonAdd];
        [self spawnBunchOfSand  ];
        
        }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
    //    _pointTouched = location;
        [self spawnBunchOfSand];
        
        //        [_sand setPosition:location];
        
        }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
   //     [self spawnSand];
   //     [_sand setPosition:location];
        
    }
    
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event  {
    _myTriangle.physicsBody.affectedByGravity = YES;
    _myTriangle.physicsBody.dynamic = YES;
    
    
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
















