#import "AppDelegate.h"


@implementation AppDelegate

@synthesize window=_window;
@synthesize navigationController=_navigationController;

SYNTHESIZE_SINGLETON_FOR_CLASS(AppDelegate)

#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    

	[self.window addSubview:[self.navigationController view]];
    [self.window makeKeyAndVisible];
	
	[self.locationGetter startUpdates];
	
	if (self.locationGetter.locationManager.locationServicesEnabled) {
		// Try to see when location getter got a fix
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(locationDidFix:) 
													 name:GPSLocationDidFix
												   object:nil];
		// Try to see when user does not allow core location
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(locationShouldStop:) 
													 name:ShouldStopGPSLocationFix
												   object:nil];
	}
}

/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
	
    NSError *error = nil;
    if (_managedObjectContext != nil) {
        if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
        } 
    }
}

#pragma mark -
#pragma mark Geolocation:

- (MyLocationGetter *)locationGetter
{
	if (!_locationGetter) {
		_locationGetter = [[MyLocationGetter alloc]init];
		_locationGetter.alwaysOn = TRUE;
	}
	return _locationGetter;
}

- (CLLocation *)currentLocation
{
	CLLocation *current = nil;
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", self.locationGetter.selectedLocation];
	NSArray *locations = [self.locationGetter.locations filteredArrayUsingPredicate:predicate];
	if (locations.count == 1) {
		NSDictionary *dict = [locations objectAtIndex:0];
		current = [dict valueForKey:@"location"];
	}
	
	if (!current) {
		// Use current location
		if (TARGET_IPHONE_SIMULATOR) {
			// harajuku
			current = [[[CLLocation alloc]initWithLatitude:35.67165182 longitude:139.7016934]autorelease];
			// tokyo city
			// current = [[[CLLocation alloc]initWithLatitude:35.67500798914924 longitude:139.72867012023926]autorelease];
		} else {
			current = [self.locationGetter.locationManager location];
		}
	}
	
	return current;
}

- (void)locationDidFix:(id)sender
{
	// Do something
	DLog(@"user got a fix with core location");
}

- (void)locationShouldStop:(id)sender
{
	// Do something
	DLog(@"user does not want to use core location");
}


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
	
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return _managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
	
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    _managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return _managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
	
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"Database.sqlite"]];
	
	NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
	// Setup light migration
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
							 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
							 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible
		 * The schema for the persistent store is incompatible with current managed object model
		 Check the error message to determine what the actual problem was.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }    
	
    return _persistentStoreCoordinator;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	
	[[NSNotificationCenter defaultCenter]removeObserver:self];
	
    [_locationGetter release];
	
	[_managedObjectContext release];
    [_managedObjectModel release];
    [_persistentStoreCoordinator release];
    
	[_navigationController release];
	[_window release];
	[super dealloc];
}


@end

