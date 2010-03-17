//
//  MyLocationGetter.m
//  
//
//  Created by Anthony Mittaz on 29/06/08.
//  Copyright 2008 Anthony Mittaz. All rights reserved.
//

#import "MyLocationGetter.h"
#import <CoreLocation/CoreLocation.h>

@implementation MyLocationGetter

@synthesize alwaysOn=_alwaysOn;
- (id) init
{
	self = [super init];
	if (self != nil) {
		self.alwaysOn = FALSE;
	}
	return self;
}


- (CLLocationManager *)locationManager
{
	if (!_locationManager) {
		_locationManager = [[CLLocationManager alloc] init];
		
		_locationManager.delegate = self;
		if (self.alwaysOn) {
			_locationManager.desiredAccuracy = kCLLocationAccuracyBest;
		} else {
			_locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
		}
		
		// Set a movement threshold for new events
		if (self.alwaysOn) {
			_locationManager.distanceFilter = kCLDistanceFilterNone;
		} else {
			_locationManager.distanceFilter = 500;
		}
		
	}
	return _locationManager;
}

- (void)startUpdates
{	
    [self.locationManager startUpdatingLocation];
}

- (void)stopUpdates
{	
    [self.locationManager stopUpdatingLocation];
}


// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation
{
    // Horizontal coordinates
	if (signbit(newLocation.horizontalAccuracy)) {
		// Invalid coordinate
		return;
	}
	if (!self.alwaysOn) {
		// If it's a relatively recent event, turn off updates to save power
		NSDate* eventDate = newLocation.timestamp;
		NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
		if (abs(howRecent) < 5.0)
		{
			// Stop updating location, save battery
			[manager stopUpdatingLocation];
		}
	} else {
		NSDate* eventDate = newLocation.timestamp;
		NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
		if (howRecent <= -(60*60*24))
		{
			// If it is older than one day don't care about this value
			return;
		}
	}
	
	// Tell everyone that gps got a fix
	[[NSNotificationCenter defaultCenter] postNotificationName:GPSLocationDidFix object:nil userInfo:nil];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	if ([error code] == kCLErrorDenied) {
		// should stop looking for coordinates
		[self.locationManager stopUpdatingLocation];
		[[NSNotificationCenter defaultCenter] postNotificationName:ShouldStopGPSLocationFix object:nil userInfo:nil];
	}
}

- (NSArray *)locations
{
	if (!_locations) {
		CLLocation *harajukuTrainStationDictLoc = [[[CLLocation alloc] initWithLatitude:35.669866 longitude:139.703114]autorelease];
		NSDictionary *harajukuTrainStationDict = [NSDictionary dictionaryWithObjectsAndKeys:@"Harajuku Train Station", @"name", harajukuTrainStationDictLoc, @"location", nil];
		_locations = [[NSArray alloc]initWithObjects:harajukuTrainStationDict, nil];
	}
	
	return _locations;
}

- (NSString *)selectedLocation
{
	return [[NSUserDefaults standardUserDefaults]objectForKey:SelectedLocationUserDefaults];
}

- (void)setSelectedLocation:(NSString *)selectedLocation
{
	if (self.selectedLocation != selectedLocation) {
		NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
		[defaults setObject:selectedLocation forKey:SelectedLocationUserDefaults];
		[defaults synchronize];
		
		// Tell everyone that gps got a fix
		[[NSNotificationCenter defaultCenter] postNotificationName:GPSLocationDidFix object:nil userInfo:nil];
	}
}

- (void)dealloc {
	[_locationManager release];
	[_locations release];
	
	[super dealloc];
}

@end
