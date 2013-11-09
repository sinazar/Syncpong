//
//  PacketGameData.m
//  Syncpong
//
//  Created by Ishan Thukral on 11/9/2013.
//  Copyright (c) 2013 Power 9. All rights reserved.
//

#import "PacketGameData.h"
#import "NSData+SnapAdditions.h"

@implementation PacketGameData

//+ (id)packetWithData:(NSData *)data
//{
//	size_t count;
//	NSString *playerName = [data rw_stringAtOffset:PACKET_HEADER_SIZE bytesRead:&count];
//	return [[self class] packetWithPlayerName:playerName];
//}

+ (id)packetWithData:(NSData *)data
{
	size_t count;
    NSString *xposstring = [data rw_stringAtOffset:PACKET_HEADER_SIZE bytesRead:&count];
    NSString *dxvelstring = [data rw_stringAtOffset:(PACKET_HEADER_SIZE+count) bytesRead:&count];
    NSString *dyvelstring = [data rw_stringAtOffset:(PACKET_HEADER_SIZE+2*count) bytesRead:&count];
    float xpos = [xposstring floatValue];
    float dxvel = [dxvelstring floatValue];
    float dyvel = [dyvelstring floatValue];
    
    NSLog(@"%f, %f, %f", xpos, dxvel, dyvel);
    
	return [[self class] packetWithGame:xpos dx:dxvel dy:dyvel];
}

+ (id)packetWithGame:(float) xpos dx:(float) dxvel dy:(float) dyvel
{
	return [[[self class] alloc] initWithGame:xpos dx:dxvel dy:dyvel];
}

- (id)initWithGame:(float) xpos dx:(float) dxvel dy:(float) dyvel
{
	if ((self = [super initWithType:PacketTypeGameData]))
	{
		self.xpos = xpos;
        self.dxvel = dxvel;
        self.dyvel = dyvel;
	}
	return self;
}

- (id)initWithPacketWithX:(float)xpos dx:(float)dxvel dy:(float)dyvel
{
    self = [super init];
    
    self.xpos = xpos;
    self.dxvel = dxvel;
    self.dyvel = dyvel;
    
    return self;
}

- (void)addPayloadToData:(NSMutableData *)data
{
	[data rw_appendString:[NSString stringWithFormat:@"%f", self.xpos]];
    [data rw_appendString:[NSString stringWithFormat:@"%f", self.dxvel]];
    [data rw_appendString:[NSString stringWithFormat:@"%f", self.dyvel]];
}

@end
