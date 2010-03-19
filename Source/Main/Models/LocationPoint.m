#import "LocationPoint.h"

@implementation LocationPoint

// Custom logic goes here.
+ (id)locationPointWithId:(NSNumber *)serverId managedObjectContext:(NSManagedObjectContext *)context
{
	if (!serverId) {
		return nil;
	}
	
	LocationPoint *locationPoint = [LocationPoint fetchOneLocationPointWithMocId:context serverId:serverId];
	return locationPoint;
}

@end
