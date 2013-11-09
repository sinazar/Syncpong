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

@property (nonatomic, copy) NSNumber * xpos;
@property (nonatomic, copy) NSNumber * dxvel;
@property (nonatomic, copy) NSNumber * dyvel;

@property (nonatomic, strong) NSString * playerName;


- (id)initWithPacketWithPeerID:(NSNumber *)xpos :(NSNumber *)dxvel :(NSNumber *)dyvel;

@end