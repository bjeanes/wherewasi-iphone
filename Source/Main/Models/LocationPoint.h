#import "_LocationPoint.h"

@interface LocationPoint : _LocationPoint {}

// Custom logic goes here.
+ (id)locationPointWithId:(NSNumber *)serverId managedObjectContext:(NSManagedObjectContext *)context;

@end
