//
//  MyScene.m
//  Syncpong
//
//  Created by Sina Zargaran on 2013-11-08.
//  Copyright (c) 2013 Power 9. All rights reserved.
//

#import "MyScene.h"
#import "Packet.h"
#import "Game.h"
#import "PacketGameData.h"

static const uint32_t projectileCategory = 0x1 << 0;
static const uint32_t bodyCategory = 0x1 << 1;
static const uint32_t wallCategory = 0x1 << 2;
static const uint32_t topCategory = 0x1 << 3;

@implementation MyScene
{
    SKSpriteNode * _pong;
    SKSpriteNode * _ball;
    SKSpriteNode * _left;
    SKSpriteNode * _right;
    SKSpriteNode * _top;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor whiteColor];
        
        _pong = [SKSpriteNode spriteNodeWithImageNamed:@"pong.png"];
        _pong.position = CGPointMake(self.frame.size.width/2, 40);
        [_pong setName:kAnimalNodeName];
        _pong.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_pong.size];
        _pong.physicsBody.dynamic = YES;
        _pong.physicsBody.affectedByGravity = NO;
        _pong.physicsBody.categoryBitMask = bodyCategory;
        _pong.physicsBody.contactTestBitMask = projectileCategory;
        _pong.physicsBody.collisionBitMask = bodyCategory;
        _pong.physicsBody.friction = 0;
        _pong.physicsBody.restitution = 0.0f;
        [self addChild:_pong];
        
        _left = [SKSpriteNode spriteNodeWithImageNamed:@"side.png"];
        _left.position = CGPointMake(0, 0);
        _left.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_left.size];
        _left.physicsBody.dynamic = YES;
        _left.physicsBody.affectedByGravity = NO;
        _left.physicsBody.categoryBitMask = wallCategory;
        _left.physicsBody.contactTestBitMask = projectileCategory;
        _left.physicsBody.collisionBitMask = wallCategory;
        _left.physicsBody.friction = 0;
        _left.physicsBody.restitution = 0.0f;
        [self addChild:_left];
        
        _top = [SKSpriteNode spriteNodeWithImageNamed:@"top.png"];
        _top.position = CGPointMake(284, 300);
        _top.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_top.size];
        _top.physicsBody.dynamic = YES;
        _top.physicsBody.affectedByGravity = NO;
        _top.physicsBody.categoryBitMask = topCategory;
        _top.physicsBody.contactTestBitMask = projectileCategory;
        _top.physicsBody.collisionBitMask = topCategory;
        _top.physicsBody.friction = 0;
        _top.physicsBody.restitution = 0.0f;
        [self addChild:_top];
        
        _right = [SKSpriteNode spriteNodeWithImageNamed:@"side.png"];
        _right.position = CGPointMake(568, 320);
        _right.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_right.size];
        _right.physicsBody.dynamic = YES;
        _right.physicsBody.affectedByGravity = NO;
        _right.physicsBody.categoryBitMask = wallCategory;
        _right.physicsBody.contactTestBitMask = projectileCategory;
        _right.physicsBody.collisionBitMask = wallCategory;
        _right.physicsBody.friction = 0;
        _right.physicsBody.restitution = 0.0f;
        [self addChild:_right];
        
        _ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball.png"];
        _ball.position = CGPointMake(self.frame.size.width/2, self.frame.size.height-40);
        _ball.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_ball.size];
        _ball.physicsBody.dynamic = YES;
        _ball.physicsBody.categoryBitMask = projectileCategory;
        _ball.physicsBody.contactTestBitMask = bodyCategory;
        _ball.physicsBody.collisionBitMask = 0;
        _ball.physicsBody.friction = 0;
        _ball.physicsBody.velocity = CGVectorMake(100, 0);
        _ball.physicsBody.restitution = 0.0f;
        _ball.physicsBody.linearDamping = 0.0f;
        [self addChild:_ball];
        
        self.physicsWorld.contactDelegate = self;
    }
    return self;
}

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if ((firstBody.categoryBitMask & projectileCategory) != 0 &&
        (secondBody.categoryBitMask & bodyCategory) != 0)
    {
        firstBody.velocity = CGVectorMake(firstBody.velocity.dx+secondBody.velocity.dx/2, -firstBody.velocity.dy*1.01);
    }
    
    if ((firstBody.categoryBitMask & projectileCategory) != 0 &&
        (secondBody.categoryBitMask & wallCategory) != 0)
    {
        firstBody.velocity = CGVectorMake(-firstBody.velocity.dx, firstBody.velocity.dy);
    }
    
    if ((firstBody.categoryBitMask & projectileCategory) != 0 &&
        (secondBody.categoryBitMask & topCategory) != 0)
    {
        PacketGameData * pgd = [PacketGameData packetWithType:PacketTypeGameData];
//        pgd = [[PacketGameData alloc] initWithPacketWithX:firstBody.velocity.dx dx:firstBody.velocity.dx dy:firstBody.velocity.dy];
        pgd.xpos = firstBody.velocity.dx;
        pgd.dxvel = firstBody.velocity.dx;
        pgd.dyvel = firstBody.velocity.dy;
        [[[self vc] game] gameUpdate:pgd];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch * touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    [self selectNodeForTouch:positionInScene];
}

- (void)selectNodeForTouch:(CGPoint)touchLocation
{
    SKSpriteNode * touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];
    
    if (![_selectedNode isEqual:touchedNode]) {
        [_selectedNode removeAllActions];
        [_selectedNode runAction:[SKAction rotateToAngle:0.0f duration:0.1]];
        _selectedNode = touchedNode;
    }
}

float degToRad(float degree) {
	return degree / 180.0f * M_PI;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint positionInScene = [touch locationInNode:self];
	CGPoint previousPosition = [touch previousLocationInNode:self];
    
	CGPoint translation = CGPointMake(positionInScene.x - previousPosition.x, positionInScene.y - previousPosition.y);
    
	[self panForTranslation:translation];
}

- (void)panForTranslation:(CGPoint)translation {
    CGPoint position = [_selectedNode position];
    if([[_selectedNode name] isEqualToString:kAnimalNodeName]) {
        float newX = position.x + translation.x;
        if (newX <= 50 || newX >= 518) {
            if (newX <= 50) { newX = 50.0; }
            else { newX = 518.0; }
        }
        [_selectedNode setPosition:CGPointMake(newX, position.y)];
    } else {
        CGPoint newPos = CGPointMake(position.x + translation.x, position.y);
        [_background setPosition:[self boundLayerPos:newPos]];
    }
}

- (CGPoint)boundLayerPos:(CGPoint)newPos {
    CGSize winSize = self.size;
    CGPoint retval = newPos;
    retval.x = MIN(retval.x, 0);
    retval.x = MAX(retval.x, -[_background size].width+ winSize.width);
    retval.y = [self position].y;
    return retval;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
