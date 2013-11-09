//
//  PacketGameData.m
//  Syncpong
//
//  Created by Ishan Thukral on 11/9/2013.
//  Copyright (c) 2013 Power 9. All rights reserved.
//

#import "PacketGameData.h"

@implementation PacketGameData

//+ (id)packetWithData:(NSData *)data
//{
//	size_t count;
//	NSString *playerName = [data rw_stringAtOffset:PACKET_HEADER_SIZE bytesRead:&count];
//	return [[self class] packetWithPlayerName:playerName];
//}

- (id)initWithPacketWithPeerID:(NSNumber *)xpos :(NSNumber *)dxvel :(NSNumber *)dyvel
{
    self = [super init];
    
    self.xpos = xpos;
    self.dxvel = dxvel;
    self.dyvel = dyvel;
    
    return self;
}

- (void)addPayloadToData:(NSMutableData *)data
{
	[data rw_appendString:self.playerName];
}

@end