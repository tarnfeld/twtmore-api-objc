//
//  Twtmore.m
//  iPhone Library
//
//  Created by Tom Arnfeld on 19/09/2010.
//  Copyright 2010 Tom Arnfeld @ Twtmore. All rights reserved.
//

#import "Twtmore.h"


@implementation Twtmore
@synthesize delegate;

- (id)initWithAPIKey:(NSString *)key andDelegate:(id)twtmoreDelegate
{
    if (self = [super init])
    {
        apiKey = [NSString stringWithString:key];
		apiUrl = [NSString stringWithFormat:@"http://api.twtmore.com"];
		self.delegate = twtmoreDelegate;
    }
    return self;
}

- (id)initWithStagingAPIKey:(NSString *)key andDelegate:(id)twtmoreDelegate
{
    if (self = [super init])
    {
        apiKey = [NSString stringWithString:key];
		apiUrl = [NSString stringWithFormat:@"http://api.twtmore.com"];
		self.delegate = twtmoreDelegate;
		staging = YES;
    }
    return self;
}

- (void)shortenTweetWithUsername:(NSString *)username andTweet:(NSString *)tweet
{
	
	method = [NSString stringWithFormat:@"shorten"];
	
	NSMutableString *body = [[NSMutableString alloc] initWithFormat:@"user=%@&tweet=%@", username, [tweet URLEncodeString]];
	if(staging)
	{
		[body appendString:@"&staging=true"];
	}
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/%@", apiUrl, method, apiKey]]];
	
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
	
	[body release]; body = nil;
	
	APIConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	if(APIConnection) {
		
		receivedData = [[NSMutableData data] retain];
		
	} else {
		
		[[self delegate] didReceiveErrorFromAPI:@"Error making connection"];
		
	}
	
}

#pragma mark NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	
	if([((NSHTTPURLResponse *)response) statusCode] >= 400)
	{
		[[self delegate] didReceiveErrorFromAPI:[NSString stringWithFormat:@"API Error: %i", [((NSHTTPURLResponse *)response) statusCode]]];
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
	
	[[self delegate] didReceiveErrorFromAPI:[NSString stringWithFormat:@"Connection Error: %@", [error localizedDescription]]];
	
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	
	NSString *data = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
	[[self delegate] didReceiveResponseFromAPI:data ofMethod:method];
	[data release];
	
    [connection release];
    [receivedData release];
}

@end