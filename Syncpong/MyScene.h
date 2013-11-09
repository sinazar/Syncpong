//
//  MyScene.h
//  Syncpong
//

//  Copyright (c) 2013 Power 9. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameViewController.h"
#import "ITScene.h"

static NSString * const kAnimalNodeName = @"movable";

@interface MyScene : ITScene <SKPhysicsContactDelegate>

@property (nonatomic, strong) SKSpriteNode * background;
@property (nonatomic, strong) SKSpriteNode * selectedNode;

@end
