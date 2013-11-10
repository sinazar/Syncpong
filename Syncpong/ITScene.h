//
//  ITScene.h
//  Syncpong
//
//  Created by Ishan Thukral on 11/9/2013.
//  Copyright (c) 2013 Power 9. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameViewController.h"

@interface ITScene : SKScene

@property (nonatomic, strong) GameViewController * vc;
@property (nonatomic) BOOL isHost;

@end
