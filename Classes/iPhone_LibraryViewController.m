//
//  iPhone_LibraryViewController.m
//  iPhone Library
//
//  Created by Tom Arnfeld on 19/09/2010.
//  Copyright 2010 Tom Arnfeld @ Twtmore. All rights reserved.
//

#import "iPhone_LibraryViewController.h"

@implementation iPhone_LibraryViewController
@synthesize textView, doneButton, shortenButton, spinner, responseView, updatedTime, lengthCounter;

#pragma mark -
#pragma mark ViewControllerMethods
- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	[textView setFont:[UIFont systemFontOfSize:13]];
	[textView setDelegate:self];
	
}
- (void)updateTime
{
    
    NSLog(@"Called to update the time!");
    
	NSDate *today = [NSDate date];	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	
	[dateFormatter setDateStyle:NSDateFormatterShortStyle];	
	[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	NSString *time = [dateFormatter stringFromDate:today];
	
	[updatedTime setText:[NSString stringWithFormat:@"Last Updated: %@", time]];
	
	[dateFormatter release]; dateFormatter = nil;
}

#pragma mark -
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
    [lengthCounter setHidden:YES];
	
	// Use this when in production!
	// twtmore = [[Twtmore alloc] initWithAPIKey:@"API_KEY_HERE"];
	
	// Please use this when testing tweets, saves short URLs
	twtmore = [[Twtmore alloc] initWithStagingAPIKey:@"5cb2f94de6843d7dc69875687ce0bf0a"];
	
	// Set the delegate to be this object
	[twtmore setDelegate:self];
	
	// Shorten a tweet!
	[twtmore shortenTweet:[[textView text] URLEncodeString] forScreenName:@"twtmoretest"];
}

#pragma mark -
#pragma mark UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
	[doneButton setHidden:NO];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
	[doneButton setHidden:YES];
}
- (void)textViewDidChange:(UITextView *)thisTextView
{
    NSInteger length = [[thisTextView text] length];
    [lengthCounter setText:[NSString stringWithFormat:@"%i", length]];
    
    if(length > 140) {
        [lengthCounter setTextColor:[UIColor colorWithRed:0.250 green:0.536 blue:0.000 alpha:1.000]];
    } else {
        [lengthCounter setTextColor:[UIColor darkGrayColor]];
    }
    
}

#pragma mark -
#pragma mark TwtmoreDelegate
- (void)didReceiveShortenedTweet:(NSString *)tweet
{
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
	[shortenButton setHidden:NO];
    [lengthCounter setHidden:NO];
	
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
	[lengthCounter setHidden:NO];
    
	[spinner stopAnimating];
	[spinner setHidden:YES];
	
	[responseView setFont:[UIFont boldSystemFontOfSize:13]];
	[responseView setTextColor:[UIColor redColor]];
	[responseView setText:error];
	
	[self updateTime];
	
}

#pragma mark -
#pragma mark Memory Stuff
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)dealloc
{
    [lengthCounter release];
    [super dealloc];
	[twtmore release];
    twtmore = nil;
}

@end
