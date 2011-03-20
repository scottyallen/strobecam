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
@class AVCaptureStillImageOutput;
@class AVCaptureConnection;

@interface StrobeCamViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {

}

- (IBAction)strobeButtonDown;

@property(nonatomic, retain) AVCaptureSession *torchSession;
@property(nonatomic, retain) AVCaptureDevice *device;
@property(nonatomic, retain) AVCaptureDeviceInput *flashInput;
@property(nonatomic, retain) NSTimer *flashTimer;
@property(nonatomic, retain) AVCaptureStillImageOutput *output;
@property(nonatomic, retain) AVCaptureConnection *videoConnection;
@property(nonatomic, retain) IBOutlet UIImageView *imageView;
@property(nonatomic, retain) NSTimer *flashOffTimer;
@property(nonatomic, retain) NSTimer *flashOnTimer;


@end

