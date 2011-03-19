//
//  StrobeCamViewController.h
//  StrobeCam
//
//  Created by Scotty Allen on 3/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVCaptureSession;
@class AVCaptureDevice;
@class AVCaptureDeviceInput;

@interface StrobeCamViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {

}

- (IBAction)strobeButtonDown;

@property(nonatomic, retain) AVCaptureSession *torchSession;
@property(nonatomic, retain) AVCaptureDevice *device;
@property(nonatomic, retain) AVCaptureDeviceInput *flashInput;
@property(nonatomic, retain) NSTimer *flashTimer;
@property(nonatomic, retain) AVCaptureStillImageOutput *output;


@end

