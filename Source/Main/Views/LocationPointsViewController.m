//
//  LocationPointsViewController.m
//  wherewasi
//
//  Created by Anthony Mittaz on 19/03/10.
//  Copyright 2010 Mogeneration. All rights reserved.
//

#import "LocationPointsViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation LocationPointsViewController

#pragma mark -
#pragma mark Initialisation

@synthesize accuracy=_accuracy;
@synthesize messageTextView=_messageTextView;
@synthesize pictureImageView=_pictureImageView;
@synthesize coordinateLabel=_coordinateLabel;
@synthesize accuracyLabel=_accuracyLabel;

- (void)setupCustomInitialisation
{
	[super setupCustomInitialisation];
	
	if (!self.managedObjectContext) {
		self.managedObjectContext = [AppDelegate sharedAppDelegate].managedObjectContext;
	}
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Create point";
	
	CALayer *layer = self.messageTextView.layer;
	layer.borderColor = [[UIColor blackColor]CGColor];
	layer.borderWidth = 1.0;
	[self.messageTextView becomeFirstResponder];
	
	CALayer *imageLayer = self.pictureImageView.layer;
	imageLayer.borderColor = [[UIColor blackColor]CGColor];
	imageLayer.borderWidth = 1.0;
	
	[self refreshContent:self];
	
	self.accuracy = 0.0;
	
	if ([AppDelegate sharedAppDelegate].locationGetter.locationManager.locationServicesEnabled) {
		// Try to see when location getter got a fix
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(locationDidFix:) 
													 name:GPSLocationDidFix
												   object:nil];
	}
}

#pragma mark -
#pragma mark Setup

- (void)setupNavigationBar
{
	[super setupNavigationBar];
	
	UIBarButtonItem *cancelItem = [[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
																				target:self 
																				action:@selector(cancel:)]autorelease];
	self.navigationItem.leftBarButtonItem = cancelItem;
	
	UIBarButtonItem *refreshItem = [[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
																				target:self 
																				action:@selector(refreshContent:)]autorelease];
	self.navigationItem.rightBarButtonItem = refreshItem;
	
	UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
	self.navigationItem.backBarButtonItem = backBarButtonItem;
	[backBarButtonItem release];
}

#pragma mark -
#pragma mark UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
	// Any new character added is passed in as the "text" parameter
    if ([text isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        [textView resignFirstResponder];
		
        // Return FALSE so that the final '\n' character doesn't get added
        return FALSE;
    }
    // For any other character return TRUE so that the text gets added to the view
    return TRUE;
}

- (void)locationDidFix:(id)sender
{
	if ([AppDelegate sharedAppDelegate].currentLocation.horizontalAccuracy != self.accuracy) {
		[self refreshContent:sender];
	}
}

- (void)refreshContent:(id)sender
{
	CLLocation *currentLocation = [AppDelegate sharedAppDelegate].currentLocation;
	CLLocationAccuracy accuracy = currentLocation.horizontalAccuracy;
	
	self.coordinateLabel.text = [NSString stringWithFormat:@"%f, %f", 
								 currentLocation.coordinate.latitude, 
								 currentLocation.coordinate.longitude];
	self.accuracyLabel.text = [NSString stringWithFormat:@"%.1fm accuracy", accuracy];
}

- (IBAction)pickImage:(id)sender
{
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.delegate = self;
	[self presentModalViewController:imagePicker animated:YES];
	[imagePicker release];
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[self dismissModalViewControllerAnimated:YES];
	UIImage *image = [info valueForKey:@"UIImagePickerControllerOriginalImage"];
	NSString *imageURL = nil;
	if (image) {
		self.pictureImageView.image = image;
		NSString *imagePath = nil;
		// Save the image
		NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
		// save the image somewhere
		//Build the path we want the file to be at 
		imageURL = [[AppDelegate sharedAppDelegate] applicationDocumentsDirectory];
		NSString *guid = [[NSProcessInfo processInfo] globallyUniqueString]; 
		imagePath = [NSString stringWithFormat:@"%@.jpeg", guid];
		imageURL = [imageURL stringByAppendingPathComponent:imagePath];
		[imageData writeToFile:imageURL atomically:FALSE];
	}
	self.object = imageURL;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)save:(id)sender
{
	CLLocation *currentLocation = [AppDelegate sharedAppDelegate].currentLocation;
	
	LocationPoint *point = [LocationPoint insertInManagedObjectContext:self.managedObjectContext];
	point.occurred_at = [NSDate date];
	point.latitudeValue = currentLocation.coordinate.latitude;
	point.longitudeValue =currentLocation.coordinate.longitude ;
	point.message = self.messageTextView.text;
	if (self.object) {
		// do something
		NSString *picturePath = (NSString *)self.object;
		point.picture = picturePath;
	}
	
	[self.managedObjectContext save:nil];
	
	[self.navigationController dismissModalViewControllerAnimated:TRUE];
}

- (IBAction)cancel:(id)sender
{
	[self.navigationController dismissModalViewControllerAnimated:TRUE];
}

- (void)dealloc {
	
	[[NSNotificationCenter defaultCenter]removeObserver:self];
	
	[_accuracyLabel release];
	[_coordinateLabel release];
	[_pictureImageView release];
	[_messageTextView release];
	
    [super dealloc];
}

@end
