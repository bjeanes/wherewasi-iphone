//
//  LocationPointsViewController.h
//  wherewasi
//
//  Created by Anthony Mittaz on 19/03/10.
//  Copyright 2010 Mogeneration. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OD2/OD2ViewController.h>

@interface LocationPointsViewController : OD2ViewController <UIImagePickerControllerDelegate, UITextViewDelegate>{
	double _accuracy;
	
	UITextView *_messageTextView;
	UIImageView *_pictureImageView;
	UILabel *_coordinateLabel;
	UILabel *_accuracyLabel;
}

@property (nonatomic) double accuracy;

@property (nonatomic, retain) IBOutlet UITextView *messageTextView;
@property (nonatomic, retain) IBOutlet UIImageView *pictureImageView;
@property (nonatomic, retain) IBOutlet UILabel *coordinateLabel;
@property (nonatomic, retain) IBOutlet UILabel *accuracyLabel;

- (void)refreshContent:(id)sender;

- (IBAction)pickImage:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;

@end
