//
//  NSData+SnapAdditions.m
//  Snap
//
//  Created by Ray Wenderlich on 5/25/12.
//  Copyright (c) 2012 Hollance. All rights reserved.
//

#import "NSData+SnapAdditions.h"

@implementation NSData (SnapAdditions)

- (int)rw_int32AtOffset:(size_t)offset
{
	const int *intBytes = (const int *)[self bytes];
	return ntohl(intBytes[offset / 4]);
}

- (short)rw_int16AtOffset:(size_t)offset
{
	const short *shortBytes = (const short *)[self bytes];
	return ntohs(shortBytes[offset / 2]);
}

- (char)rw_int8AtOffset:(size_t)offset
{
	const char *charBytes = (const char *)[self bytes];
	return charBytes[offset];
}

- (NSString *)rw_stringAtOffset:(size_t)offset bytesRead:(size_t *)amount
{
	const char *charBytes = (const char *)[self bytes];
	NSString *string = [NSString stringWithUTF8String:charBytes + offset];
	*amount = strlen(charBytes + offset) + 1;
	return string;
}

- (float)xCoorditane:(size_t)xCoordinate
{
    const float * x = (const float *)[self bytes];
    return ntohl(x[xCoordinate/4]);
}

- (float)dxVelocity:(size_t)dxVelocity
{
    const float * dx = (const float *)[self bytes];
    return ntohl(dx[dxVelocity/4]);
}

- (float)dyVelocity:(size_t)dyVelocity
{
    const float * dy = (const float *)[self bytes];
    return ntohl(dy[dyVelocity/4]);
}

@end

@implementation NSMutableData (SnapAdditions)

- (void)rw_appendInt32:(int)value
{
	value = htonl(value);
	[self appendBytes:&value length:4];
}

- (void)rw_appendInt16:(short)value
{
	value = htons(value);
	[self appendBytes:&value length:2];
}

- (void)rw_appendInt8:(char)value
{
	[self appendBytes:&value length:1];
}

- (void)rw_appendString:(NSString *)string
{
	const char *cString = [string UTF8String];
	[self appendBytes:cString length:strlen(cString) + 1];
}

- (void)appendFloat:(float)value
{
    value = htonl(value);
    [self appendBytes:&value length:4];
}

@end
