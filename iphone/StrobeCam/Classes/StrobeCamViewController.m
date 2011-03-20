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
- (void)captureImage;
- (void)turnTorchOn;
- (void)turnTorchOff;

@end

@implementation StrobeCamViewController

- (void)dealloc {
  [torchSession release];
  [device release];
  [flashInput release];
  [flashTimer release];
  [output release];
  [videoConnection release];
  self.imageView = nil;
  [flashOnTimer release];
  [flashOffTimer release];
  [super dealloc];
}

- (IBAction)strobeButtonDown {
  NSLog(@"button down");
  [self captureImage];
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
      
      session.sessionPreset = AVCaptureSessionPresetLow;
      
      [self.device unlockForConfiguration];
      
      [session commitConfiguration];
      [session startRunning];
      
      self.torchSession = session;
      
      self.videoConnection = nil;
      for (AVCaptureConnection *connection in self.output.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
          if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
            self.videoConnection = connection;
            break;
          }
        }
        if (self.videoConnection) { break; }
      }
    }
    else {
      NSLog(@"It's currently on.. turning off now.");
      [torchSession stopRunning];
    }
  }
}

- (void)turnTorchOn {
  [self.device lockForConfiguration:nil];
  self.device.torchMode = AVCaptureTorchModeOn;
  [self.device unlockForConfiguration];
}

- (void)turnTorchOff {
  [self.device lockForConfiguration:nil];
  self.device.torchMode = AVCaptureTorchModeOff;
  [self.device unlockForConfiguration];
}

- (void)fireFlashFor {
  [self turnTorchOn];
  self.flashOffTimer = [NSTimer scheduledTimerWithTimeInterval:0.03
                                                        target:self
                                                      selector:@selector(turnTorchOff)
                                                      userInfo:nil
                                                       repeats:NO];
}

- (void)fireFlashIn:(NSTimeInterval)interval {
  self.flashOnTimer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                       target:self
                                                     selector:@selector(fireFlashFor)
                                                     userInfo:nil
                                                      repeats:NO];
}

- (void)captureImage {
  [self fireFlashIn:0.1];
  [self.output captureStillImageAsynchronouslyFromConnection:videoConnection
                                           completionHandler:
   ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
     NSLog(@"image callback fired");
     NSData *data = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
     UIImage *image = [UIImage imageWithData:data];
     self.imageView.image = image;
//     [self captureImage];
   }];
}

@end
