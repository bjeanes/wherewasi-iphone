@interface AppDelegate : NSObject <UIApplicationDelegate> {
    
    NSManagedObjectModel *_managedObjectModel;
    NSManagedObjectContext *_managedObjectContext;	    
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;

    UIWindow *_window;
    UINavigationController *_navigationController;
	
	MyLocationGetter *_locationGetter;
}

+ (AppDelegate *)sharedAppDelegate;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

- (NSString *)applicationDocumentsDirectory;

// Core Location
@property (nonatomic, readonly) MyLocationGetter *locationGetter;
@property (nonatomic, readonly) CLLocation *currentLocation;

- (void)locationDidFix:(id)sender;
- (void)locationShouldStop:(id)sender;

@end

