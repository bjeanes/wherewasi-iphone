//
//  LandingServices.m
//  wherewasi
//
//  Created by Anthony Mittaz on 19/03/10.
//  Copyright 2010 Mogeneration. All rights reserved.
//

#import "LandingServices.h"


@implementation LandingServices

SYNTHESIZE_SINGLETON_FOR_CLASS(LandingServices)

- (NSManagedObjectContext *)managedObjectContext
{
	// override
	return [AppDelegate sharedAppDelegate].managedObjectContext;
}

- (NSArray *)landings
{
	NSString *apiToken = [[NSUserDefaults standardUserDefaults]valueForKey:APITokenUserDefaults];
	NSInteger notSyncedPoints = [[LocationPointsServices sharedLocationPointsServices]uncachedLocationPoints].count;
	CLLocationAccuracy accuracy = [AppDelegate sharedAppDelegate].currentLocation.horizontalAccuracy;
	
	NSArray *topGroup = [NSArray arrayWithObjects:
						 [CellObject cellObjectWithLabel1:@"Create Point" 
												   label2:[NSString stringWithFormat:@"%.1fm accuracy", accuracy]], 
						 [CellObject cellObjectWithLabel1:@"Sync" 
												   label2:(notSyncedPoints > 0) ? [NSString stringWithFormat:@"%d to sync", notSyncedPoints] : @"none"],
						 nil];
	NSArray *bottomGroup = [NSArray arrayWithObjects:
							[CellObject cellObjectWithLabel1:@"Generate Token" 
													  label2:(apiToken) ? @"installed" : @"missing"],
							nil];
	
	return [NSArray arrayWithObjects:
			topGroup,
			bottomGroup,
			nil];
}

@end
