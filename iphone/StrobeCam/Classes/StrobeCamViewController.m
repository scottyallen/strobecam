//
//  StrobeCamViewController.m
//  StrobeCam
//
//  Created by Scotty Allen on 3/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StrobeCamViewController.h"

@implementation StrobeCamViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
  [self.imageController release];
  [self.timer release];
  [super dealloc];
}

- (IBAction)strobeButtonDown {
  NSLog(@"button down");
  self.imageController = [[[UIImagePickerController alloc] init] autorelease];
  self.imageController.delegate = self;
  self.imageController.sourceType = UIImagePickerControllerSourceTypeCamera;
  self.imageController.showsCameraControls = NO;
  self.imageController.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
  [self presentModalViewController:self.imageController animated:NO];
  self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0
                                                target:self
                                              selector:@selector(takePicture)
                                              userInfo:nil
                                               repeats:NO];
}

- (void)takePicture {
  [self.imageController takePicture];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  NSLog(@"didFinishPickingMediaWithInfo");
  [self.imageController takePicture];
}

@end
