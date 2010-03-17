// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LocationPoint.m instead.

#import "_LocationPoint.h"

@implementation LocationPointID
@end

@implementation _LocationPoint

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"LocationPoint" inManagedObjectContext:moc_];
}

- (LocationPointID*)objectID {
	return (LocationPointID*)[super objectID];
}




@dynamic id;



- (long long)idValue {
	NSNumber *result = [self id];
	return result ? [result longLongValue] : 0;
}

- (void)setIdValue:(long long)value_ {
	[self setId:[NSNumber numberWithLongLong:value_]];
}






@dynamic longitude;



- (double)longitudeValue {
	NSNumber *result = [self longitude];
	return result ? [result doubleValue] : 0;
}

- (void)setLongitudeValue:(double)value_ {
	[self setLongitude:[NSNumber numberWithDouble:value_]];
}






@dynamic latitude;



- (double)latitudeValue {
	NSNumber *result = [self latitude];
	return result ? [result doubleValue] : 0;
}

- (void)setLatitudeValue:(double)value_ {
	[self setLatitude:[NSNumber numberWithDouble:value_]];
}






@dynamic occurred_at;






@dynamic message;






@dynamic picture;









+ (id)fetchOnePointWithMocId:(NSManagedObjectContext*)moc_ serverId:(NSNumber*)serverId_ {
	NSError *error = nil;
	id result = [self fetchOnePointWithMocId:moc_ serverId:serverId_ error:&error];
	if (error) {
#if TARGET_OS_IPHONE
		NSLog(@"error: %@", error);
#else
		[NSApp presentError:error];
#endif
	}
	return result;
}
+ (id)fetchOnePointWithMocId:(NSManagedObjectContext*)moc_ serverId:(NSNumber*)serverId_ error:(NSError**)error_ {
	NSError *error = nil;
	
	NSManagedObjectModel *model = [[moc_ persistentStoreCoordinator] managedObjectModel];
	NSDictionary *substitutionVariables = [NSDictionary dictionaryWithObjectsAndKeys:
														
														serverId_, @"serverId",
														
														nil];
	NSFetchRequest *fetchRequest = [model fetchRequestFromTemplateWithName:@"onePointWithMocId"
													 substitutionVariables:substitutionVariables];
	NSAssert(fetchRequest, @"Can't find fetch request named \"onePointWithMocId\".");
	
	id result = nil;
	NSArray *results = [moc_ executeFetchRequest:fetchRequest error:&error];
	
	if (!error) {
		switch ([results count]) {
			case 0:
				//	Nothing found matching the fetch request. That's cool, though: we'll just return nil.
				break;
			case 1:
				result = [results objectAtIndex:0];
				break;
			default:
				NSLog(@"WARN fetch request onePointWithMocId: 0 or 1 objects expected, %u found (substitutionVariables:%@, results:%@)",
					[results count],
					substitutionVariables,
					results);
		}
	}
	
	if (error_) *error_ = error;
	return result;
}


@end
