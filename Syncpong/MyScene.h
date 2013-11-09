//
//  MyScene.h
//  Syncpong
//

//  Copyright (c) 2013 Power 9. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

static NSString * const kAnimalNodeName = @"movable";

@interface MyScene : SKScene <SKPhysicsContactDelegate>

@property (nonatomic, strong) SKSpriteNode * background;
@property (nonatomic, strong) SKSpriteNode * selectedNode;

@end
