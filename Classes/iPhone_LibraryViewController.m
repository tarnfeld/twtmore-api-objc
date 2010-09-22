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

- (void)didReceiveShortenedTweet:(NSString *)tweet
{
	NSLog(@"Shortened Tweet ::: %@", tweet);
}

- (void)didReceiveError:(NSString *)error
{
	NSLog(@"Error ::: %@", error);
}

- (void)didReceiveLongTweet:(NSString *)tweet
{
	NSLog(@"Long Tweet ::: %@", tweet);
}

#pragma mark ViewControllerMethods

- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	NSString *tweet = [[NSString alloc] initWithString:@"Etiam at risus et justo dignissim congue. Donec congue lacinia dui, a porttitor lectus condimentum laoreet. Nunc eu ullamcorper orci. Quisque."];
	
	Twtmore *twtmore = [[Twtmore alloc] initWithStagingAPIKey:@"930093af638b6dfc3b885a658735eecd"];
	[twtmore setDelegate:self];
	[twtmore shortenTweet:[tweet URLEncodeString] forUser:@"twtmoretest"];

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
