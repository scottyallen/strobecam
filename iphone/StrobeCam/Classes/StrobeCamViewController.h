//
//  StrobeCamViewController.h
//  StrobeCam
//
//  Created by Scotty Allen on 3/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StrobeCamViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {

}

@property(nonatomic, retain) UIImagePickerController *imageController;
@property(nonatomic, retain) NSTimer *timer;
- (IBAction)strobeButtonDown;

@end

