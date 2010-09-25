//
//  iPhone_LibraryViewController.m
//  iPhone Library
//
//  Created by Tom Arnfeld on 19/09/2010.
//  Copyright 2010 Tom Arnfeld @ Twtmore. All rights reserved.
//

#import "iPhone_LibraryViewController.h"

@implementation iPhone_LibraryViewController
@synthesize textView, doneButton, shortenButton, spinner, responseView, updatedTime;

#pragma mark TwtmoreDelegate

- (void)didReceiveShortenedTweet:(NSString *)tweet
{
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
	[shortenButton setHidden:NO];
	
	[spinner stopAnimating];
	[spinner setHidden:YES];
	
	[responseView setFont:[UIFont boldSystemFontOfSize:13]];
	[responseView setText:tweet];
	
	[self updateTime];
	 
}

- (void)didReceiveError:(NSString *)error
{
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
	[shortenButton setHidden:NO];
	
	[spinner stopAnimating];
	[spinner setHidden:YES];
	
	[responseView setFont:[UIFont boldSystemFontOfSize:13]];
	[responseView setTextColor:[UIColor redColor]];
	[responseView setText:error];
	
	[self updateTime];
	
}

#pragma mark UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
	[doneButton setHidden:NO];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
	[doneButton setHidden:YES];
}

#pragma mark IBActions

- (IBAction)doneButtonPressed
{
	[textView resignFirstResponder];
}

- (IBAction)shortenTweet
{
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	[textView resignFirstResponder];
	[shortenButton setHidden:YES];
	[spinner setHidden:NO];
	[spinner startAnimating];
	
	// Create an instance of Twtmore and send over your api key
	twtmore = [[Twtmore alloc] initWithAPIKey:@"API_KEY_HERE"];
	
	// PLEASE USE THIS WHEN TESTING...
	// twtmore = [[Twtmore alloc] initWithStagingAPIKey:@"API_KEY_HERE"];
	
	// Set the delegate to be this object
	[twtmore setDelegate:self];
	
	// Shorten a tweet!
	[twtmore shortenTweet:[[textView text] URLEncodeString] forScreenName:@"twtmoretest"];
	
}

#pragma mark ViewControllerMethods

- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	[textView setFont:[UIFont systemFontOfSize:13]];
	[textView setDelegate:self];
	
}

- (void)updateTime
{
	NSDate *today = [NSDate date];	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	
	[dateFormatter setDateStyle:NSDateFormatterShortStyle];	
	[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	NSString *time = [dateFormatter stringFromDate:today];
	
	[updatedTime setText:[NSString stringWithFormat:@"Last Updated: %@", time]];
	
	[dateFormatter release]; dateFormatter = nil;
	
}

- (void)didReceiveMemoryWarning {
	
    [super didReceiveMemoryWarning];
	
}

- (void)dealloc {
	
    [super dealloc];
	[twtmore release]; twtmore = nil;
	
}

@end
