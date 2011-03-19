//
//  StrobeCamAppDelegate.h
//  StrobeCam
//
//  Created by Scotty Allen on 3/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StrobeCamViewController;

@interface StrobeCamAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    StrobeCamViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet StrobeCamViewController *viewController;

@end

