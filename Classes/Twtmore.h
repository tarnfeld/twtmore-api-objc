//
//  Twtmore.h
//  iPhone Library
//
//  Created by Tom Arnfeld on 19/09/2010.
//  Copyright 2010 Tom Arnfeld @ Twtmore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLEncodeString.h"

@protocol TwtmoreDelegate

- (void)didReceiveResponseFromAPI:(NSString *)responseData ofMethod:(NSString *)method;
- (void)didReceiveErrorFromAPI:(NSString *)error;

@end


@interface Twtmore : NSObject {
	
	NSString *apiKey;
	NSString *apiUrl;
	NSString *method;
	bool staging;
	
	id delegate;
	
	NSURLConnection *APIConnection;
	NSMutableData *receivedData;

}

#pragma mark Properties
@property (assign) id delegate;

#pragma mark InitMethods
- (id)initWithStagingAPIKey:(NSString *)key andDelegate:(id)twtmoreDelegate;
- (id)initWithAPIKey:(NSString *)key andDelegate:(id)twtmoreDelegate;

#pragma mark Methods
- (void)shortenTweetWithUsername:(NSString *)username andTweet:(NSString *)tweet;

@end
