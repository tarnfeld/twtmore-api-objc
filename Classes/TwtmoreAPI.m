//
//  TwtmoreAPI.m
//  iPhone Library
//
//  Created by Tom Arnfeld on 19/09/2010.
//  Copyright 2010 Tom Arnfeld @ Twtmore. All rights reserved.
//

#import "TwtmoreAPI.h"


@implementation TwtmoreAPI
@synthesize delegate;

#pragma mark InitMethods
- (id)initWithAPIKey:(NSString *)key andDelegate:(id)twtmoreDelegate
{
    if (self = [super init])
    {
		
        apiKey = [[NSString alloc] initWithString:key];
		apiUrl = [[NSString alloc] initWithString:@"http://api.twtmore.com"];
		self.delegate = twtmoreDelegate;
		
		apiParams = [[NSMutableDictionary alloc] initWithObjects:nil forKeys:nil];
		
    }
    return self;
}

- (id)initWithStagingAPIKey:(NSString *)key andDelegate:(id)twtmoreDelegate
{
    if (self = [super init])
    {
		
        apiKey = [[NSString alloc] initWithString:key];
		apiUrl = [[NSString alloc] initWithString:@"http://api.twtmore.com"];
		self.delegate = twtmoreDelegate;
		
		apiParams = [[NSMutableDictionary alloc] initWithObjects:nil forKeys:nil];
		[apiParams setValue:@"true" forKey:@"staging"];
		
    }
    return self;
}

#pragma mark Methods

- (void)setMethod:(NSString *)method
{
	apiMethod = [[NSString alloc] initWithString:method];
}

- (void)setParam:(NSString *)param withValue:(NSString *)value
{
	[apiParams setValue:value forKey:param];
}

- (void)startRequest
{
	
	NSMutableString *body = [[NSMutableString alloc] initWithString:@""];
	bool isFirst = YES;
	for (id key in apiParams)
	{
		if (isFirst) {
			[body appendFormat:@"%@=%@", key, [apiParams objectForKey:key]];
		}
		else {
			[body appendFormat:@"&%@=%@", key, [apiParams objectForKey:key]];
		}
		isFirst = NO;
	}
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@", apiUrl, apiMethod, apiKey]]];
	
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
	[body release];
	
	APIConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	if (APIConnection)
	{
		receivedData = [[NSMutableData data] retain];
		
	} else {
		
		[self.delegate didReceiveErrorFromAPI:@"Error making connection"];
	}
	
}

#pragma mark NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	
	if([((NSHTTPURLResponse *)response) statusCode] >= 400)
	{
		[self.delegate didReceiveErrorFromAPI:[NSString stringWithFormat:@"API Error %i", [((NSHTTPURLResponse *)response) statusCode]]];
		[connection cancel];
	}
	
    [receivedData setLength:0];
	
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{

    [receivedData appendData:data];
	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{

    [APIConnection release];
    [receivedData release];
	
	[self.delegate didReceiveErrorFromAPI:[NSString stringWithFormat:@"Connection Error %@", [error localizedDescription]]];
	
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	
	apiData = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
	[self.delegate didReceiveResponseFromAPI:apiData ofMethod:apiMethod];
	
    [APIConnection release];
    [receivedData release];
	
}

#pragma mark ObjectMethods
- (void)dealloc
{
	
	[super dealloc];
	if(apiMethod != nil)
	{
		[apiMethod release]; apiMethod = nil;
	}
	if(apiData != nil)
	{
		[apiData release]; apiData = nil;
	}
	[apiKey release]; apiKey = nil;
	[apiUrl release]; apiUrl = nil;
	[apiParams release]; apiParams = nil;
	
}

@end