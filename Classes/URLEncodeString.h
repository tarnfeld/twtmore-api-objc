//
//  URLEncodeString.h
//  iPhone Library
//
//  Created by Tom Arnfeld on 20/09/2010.
//  Copyright 2010 Tom Arnfeld @ Twtmore. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (URLEncode) 

	+ (NSString *)URLEncodeString:(NSString *)string; 
	- (NSString *)URLEncodeString; 

@end