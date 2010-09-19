//
//  iPhone_LibraryViewController.m
//  iPhone Library
//
//  Created by Tom Arnfeld on 19/09/2010.
//  Copyright 2010 Tom Arnfeld @ Twtmore. All rights reserved.
//

#import "iPhone_LibraryViewController.h"

@implementation iPhone_LibraryViewController

#pragma mark TwtmoreDelegate

- (void)didReceiveResponseFromAPI:(NSString *)responseData ofMethod:(NSString *)method
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Shortened Tweet:" message:responseData delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

- (void)didReceiveErrorFromAPI:(NSString *)error
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"API Error" message:error delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

#pragma mark ViewControllerMethods

- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	NSString *tweet = [[NSString alloc] initWithString:@"Etiam at risus et justo dignissim congue. Donec congue lacinia dui, a porttitor lectus condimentum laoreet. Nunc eu ullamcorper orci. Quisque."];
	
	Twtmore *twtmore = [[Twtmore alloc] initWithStagingAPIKey:@"930093af638b6dfc3b885a658735eecd" andDelegate:self];
	[twtmore shortenTweetWithUsername:@"twtmoretest" andTweet:tweet];
	
	[tweet release]; tweet = nil;
	[twtmore release]; twtmore = nil;
	
}

- (void)didReceiveMemoryWarning {
	
    [super didReceiveMemoryWarning];
	
}

- (void)dealloc {
	
    [super dealloc];
	
}

@end
