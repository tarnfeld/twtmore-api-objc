//
//  Twtmore.h
//  iPhone Library
//
//  Created by Tom Arnfeld on 20/09/2010.
//  Copyright 2010 Tom Arnfeld @ Twtmore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TwtmoreAPI.h"

@protocol TwtmoreDelegate

- (void)didReceiveShortenedTweet:(NSString *)tweet;
- (void)didReceiveError:(NSString *)error;

@optional - (void)didReceiveLongTweet:(NSString *)tweet;

@end

@interface Twtmore : NSObject <TwtmoreAPIDelegate> {

	id delegate;
	NSString *apiKey;
	bool staging;
	
	TwtmoreAPI *twtmoreAPIObject;
	
}

#pragma mark Properties
@property (assign) id delegate;

#pragma mark InitMethods
- (id)initWithStagingAPIKey:(NSString *)key;
- (id)initWithAPIKey:(NSString *)key;

#pragma mark Methods
- (void)shortenTweet:(NSString *)tweet forScreenName:(NSString *)user;
- (void)getTweetContentForTweetId:(NSString *)tweetId;

@end
