//
//  StrobeCamViewController.m
//  StrobeCam
//
//  Created by Scotty Allen on 3/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "StrobeCamViewController.h"

@interface StrobeCamViewController ()

- (void)setupTorch;
- (void)fireFlash;

@end

@implementation StrobeCamViewController

- (void)dealloc {
  [torchSession release];
  [device release];
  [flashInput release];
  [flashTimer release];
  [output release];
  [super dealloc];
}

- (IBAction)strobeButtonDown {
  NSLog(@"button down");
  [self fireFlash];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupTorch];
}

- (void) setupTorch {
  self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
  if ([self.device hasTorch] && [self.device hasFlash]){
    if (self.device.torchMode == AVCaptureTorchModeOff) {
      NSLog(@"It's currently off.. turning on now.");
      self.flashInput = [[AVCaptureDeviceInput deviceInputWithDevice:self.device error: nil] autorelease];
      self.output = [[[AVCaptureStillImageOutput alloc] init] autorelease];
      
      AVCaptureSession *session = [[AVCaptureSession alloc] init];
      
      [session beginConfiguration];
      [self.device lockForConfiguration:nil];
      
      [session addInput:flashInput];
      [session addOutput:output];
      
      self.device.flashMode = AVCaptureFlashModeOn;
      
      [self.device unlockForConfiguration];
      
      [session commitConfiguration];
      [session startRunning];
      
      self.torchSession = session;
    }
    else {
      NSLog(@"It's currently on.. turning off now.");
      [torchSession stopRunning];
    }
  }
}

- (void)fireFlash {
  AVCaptureConnection *videoConnection = nil;
  for (AVCaptureConnection *connection in self.output.connections) {
    for (AVCaptureInputPort *port in [connection inputPorts]) {
      if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
        videoConnection = connection;
        break;
      }
    }
    if (videoConnection) { break; }
  }
  [self.output captureStillImageAsynchronouslyFromConnection:videoConnection
                                           completionHandler:
   ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
     NSLog(@"image callback fired");
   }];
}

@end
