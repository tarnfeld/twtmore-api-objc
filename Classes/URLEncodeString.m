//
//  URLEncodeString.m
//  iPhone Library
//
//  Created by Tom Arnfeld on 20/09/2010.
//  Copyright 2010 Tom Arnfeld @ Twtmore. All rights reserved.
//

#import "URLEncodeString.h"

@implementation NSString (URLEncode) 

+ (NSString *)URLEncodeString:(NSString *)string
{

	NSString *result = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR("% '\"?=&+<>;:-"), kCFStringEncodingUTF8); 
    return [result autorelease]; 
	
} 

- (NSString *)URLEncodeString
{
	
    return [NSString URLEncodeString:self];
	
} 

@end 