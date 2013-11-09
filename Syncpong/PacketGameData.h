//
//  PacketGameData.h
//  Syncpong
//
//  Created by Ishan Thukral on 11/9/2013.
//  Copyright (c) 2013 Power 9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Packet.h"

@interface PacketGameData : Packet

@property (nonatomic) float xpos;
@property (nonatomic) float dxvel;
@property (nonatomic) float dyvel;

@property (nonatomic, strong) NSString * playerName;

- (id)initWithPacketWithX:(float)xpos dx:(float)dxvel dy:(float)dyvel;

@end