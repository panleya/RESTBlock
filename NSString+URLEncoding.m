//
//  NSString+URLEncoding.m
//  mySharp
//
//  Created by Jason Blood on 2/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSString+URLEncoding.h"

@implementation NSString (URLEncodingAdditions)

- (NSString *)encodedURLString
{
	return (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (__bridge CFStringRef)self,
                                                                           NULL,                   // characters to leave unescaped (NULL = all escaped sequences are replaced)
                                                                           CFSTR("?=&+"),          // legal URL characters to be escaped (NULL = all legal characters are replaced)
                                                                           kCFStringEncodingUTF8); // encoding
}

- (NSString *)encodedURLParameterString
{
    return (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (__bridge CFStringRef)self,
                                                                           NULL,
                                                                           CFSTR(":/=,!$&'()*+;[]@#?"),
                                                                           kCFStringEncodingUTF8);
}

- (NSString *)decodedURLString
{
	return (__bridge NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
																						  (__bridge CFStringRef)self,
																						  CFSTR(""),
																						  kCFStringEncodingUTF8);
}

-(NSString *)removeQuotes
{
	NSUInteger length = [self length];
	NSString *ret = self;
    
	if ([self characterAtIndex:0] == '"')
    {
		ret = [ret substringFromIndex:1];
	}
	if ([self characterAtIndex:length - 1] == '"')
    {
		ret = [ret substringToIndex:length - 2];
	}
	
	return ret;
}
- (NSString *)URLEncodedString 
{
    return [self stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    /*return (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (__bridge CFStringRef)self,
                                                                           NULL,
																		   CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                           kCFStringEncodingUTF8);*/
}

- (NSString *)URLDecodedString
{
	return (__bridge NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
																						   (__bridge CFStringRef)self,
																						   CFSTR(""),
																						   kCFStringEncodingUTF8);
}

- (NSString *)hashString
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), result );
    NSString *ret = [NSString stringWithFormat:
                     @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X %02X%02X%02X%02X",
                     result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
                     result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
                     ];
    return [ret stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *)stringByStrippingHTML
{
    NSRange r;
    NSString *s = [self copy];
    
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
    {
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    }
    
    return s;
}
@end
