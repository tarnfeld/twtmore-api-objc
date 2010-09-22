//
//  Twtmore.m
//  iPhone Library
//
//  Created by Tom Arnfeld on 20/09/2010.
//  Copyright 2010 Tom Arnfeld @ Twtmore. All rights reserved.
//

#import "Twtmore.h"

@implementation Twtmore
@synthesize delegate;

#pragma mark InitMethods
- (id)initWithAPIKey:(NSString *)key
{
    if (self = [super init])
    {
		apiKey = [NSString stringWithString:key];
		staging = NO;
    }
    return self;
}

- (id)initWithStagingAPIKey:(NSString *)key
{
    if (self = [super init])
    {
		apiKey = [NSString stringWithString:key];
		staging = YES;
    }
    return self;
}

#pragma mark Methods

- (void)shortenTweet:(NSString *)tweet forUser:(NSString *)user
{
	
	twtmoreAPIObject = [[TwtmoreAPI alloc] initWithAPIKey:apiKey andDelegate:self];
	[twtmoreAPIObject setMethod:@"shorten"];
	
	[twtmoreAPIObject setParam:@"tweet" withValue:tweet];
	[twtmoreAPIObject setParam:@"user" withValue:user];
	
	if(staging)
	{
		[twtmoreAPIObject setParam:@"staging" withValue:@"true"];
	}
	
	[twtmoreAPIObject startRequest];
	
} 

#pragma mark TwtmoreDelegateMethods

- (void)didReceiveResponseFromAPI:(NSString *)responseData ofMethod:(NSString *)method
{
	
	// Short Tweet
	if([responseData isEqualToString:@"shorten"])
	{
		[self.delegate didReceiveShortenedTweet:responseData];
	}
	
}

- (void)didReceiveErrorFromAPI:(NSString *)error
{
	[self.delegate didReceiveErrorFromAPI:error];
}

#pragma mark ObjectMethods
- (void)dealloc
{
	
    [super dealloc];
	[twtmoreAPIObject release]; twtmoreAPIObject = nil;
	
}
	

@end
