//
//  ViewController.h
//  Syncpong
//

//  Copyright (c) 2013 Power 9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "Game.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) Game * game;

- (id)initWIthGame:(Game *)game;

@end
