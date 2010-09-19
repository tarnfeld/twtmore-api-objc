//
//  iPhone_LibraryAppDelegate.h
//  iPhone Library
//
//  Created by Tom Arnfeld on 19/09/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iPhone_LibraryViewController;

@interface iPhone_LibraryAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    iPhone_LibraryViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet iPhone_LibraryViewController *viewController;

@end

