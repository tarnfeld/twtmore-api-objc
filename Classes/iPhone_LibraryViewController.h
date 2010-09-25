//
//  iPhone_LibraryViewController.h
//  iPhone Library
//
//  Created by Tom Arnfeld on 19/09/2010.
//  Copyright 2010 Tom Arnfeld @ Twtmore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Twtmore.h"
#import "URLEncodeString.h"

@interface iPhone_LibraryViewController : UIViewController <TwtmoreDelegate, UITextViewDelegate> {

	Twtmore *twtmore;
	IBOutlet UITextView *textView;
	IBOutlet UITextView *responseView;
	IBOutlet UIButton *doneButton;
	IBOutlet UIButton *shortenButton;
	IBOutlet UIActivityIndicatorView *spinner;
	IBOutlet UILabel *updatedTime;
	
}

@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) IBOutlet UITextView *responseView;
@property (nonatomic, retain) IBOutlet UIButton *doneButton;
@property (nonatomic, retain) IBOutlet UIButton *shortenButton;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, retain) IBOutlet UILabel *updatedTime;

- (IBAction)doneButtonPressed;
- (IBAction)shortenTweet;
- (void)updateTime;

@end

