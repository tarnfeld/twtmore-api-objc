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

- (void)shortenTweet:(NSString *)tweet forScreenName:(NSString *)user
{
	
	if(staging)
	{
		twtmoreAPIObject = [[TwtmoreAPI alloc] initWithStagingAPIKey:apiKey andDelegate:self];
	}
	else
	{
		twtmoreAPIObject = [[TwtmoreAPI alloc] initWithAPIKey:apiKey andDelegate:self];
	}
	
	[twtmoreAPIObject setMethod:@"shorten"];
	
	[twtmoreAPIObject setParam:@"tweet" withValue:tweet];
	[twtmoreAPIObject setParam:@"user" withValue:user];
	
	[twtmoreAPIObject startRequest];
	
}

- (void)getTweetContentForTweetId:(NSString *)tweetId
{
	
	twtmoreAPIObject = [[TwtmoreAPI alloc] initWithAPIKey:apiKey andDelegate:self];
	[twtmoreAPIObject setMethod:@"get"];
	
	[twtmoreAPIObject setParam:@"id" withValue:tweetId];
	
	[twtmoreAPIObject startRequest];
	
}

#pragma mark TwtmoreDelegateMethods

- (void)didReceiveResponseFromAPI:(NSString *)responseData ofMethod:(NSString *)method
{
	
	// Short Tweet
	if([method isEqualToString:@"shorten"])
	{
		[self.delegate didReceiveShortenedTweet:responseData];
	}
	
	// Tweet Content
	if([method isEqualToString:@"get"])
	{
		[self.delegate didReceiveLongTweet:responseData];
	}
	
}

- (void)didReceiveErrorFromAPI:(NSString *)error
{
	[self.delegate didReceiveError:error];
}

#pragma mark ObjectMethods
- (void)dealloc
{
	
    [super dealloc];
	[twtmoreAPIObject release]; twtmoreAPIObject = nil;
	
}
	

@end
