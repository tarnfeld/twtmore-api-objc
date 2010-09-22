//
//  TwtmoreAPI.h
//  iPhone Library
//
//  Created by Tom Arnfeld on 19/09/2010.
//  Copyright 2010 Tom Arnfeld @ Twtmore. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TwtmoreAPIDelegate

- (void)didReceiveResponseFromAPI:(NSString *)responseData ofMethod:(NSString *)method;
- (void)didReceiveErrorFromAPI:(NSString *)error;

@end

@interface TwtmoreAPI : NSObject {
	
	NSString *apiKey;
	NSString *apiUrl;
	NSString *apiMethod;
	NSMutableDictionary *apiParams;
	
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
- (void)setParam:(NSString *)param withValue:(NSString *)value;
- (void)setMethod:(NSString *)APIMethod;
- (void)startRequest;

@end
