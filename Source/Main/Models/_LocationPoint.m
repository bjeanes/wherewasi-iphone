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






@dynamic cached;



- (BOOL)cachedValue {
	NSNumber *result = [self cached];
	return result ? [result boolValue] : 0;
}

- (void)setCachedValue:(BOOL)value_ {
	[self setCached:[NSNumber numberWithBool:value_]];
}






@dynamic message;






@dynamic picture;






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









+ (id)fetchOneLocationPointWithMocId:(NSManagedObjectContext*)moc_ serverId:(NSNumber*)serverId_ {
	NSError *error = nil;
	id result = [self fetchOneLocationPointWithMocId:moc_ serverId:serverId_ error:&error];
	if (error) {
#if TARGET_OS_IPHONE
		NSLog(@"error: %@", error);
#else
		[NSApp presentError:error];
#endif
	}
	return result;
}
+ (id)fetchOneLocationPointWithMocId:(NSManagedObjectContext*)moc_ serverId:(NSNumber*)serverId_ error:(NSError**)error_ {
	NSError *error = nil;
	
	NSManagedObjectModel *model = [[moc_ persistentStoreCoordinator] managedObjectModel];
	NSDictionary *substitutionVariables = [NSDictionary dictionaryWithObjectsAndKeys:
														
														serverId_, @"serverId",
														
														nil];
	NSFetchRequest *fetchRequest = [model fetchRequestFromTemplateWithName:@"oneLocationPointWithMocId"
													 substitutionVariables:substitutionVariables];
	NSAssert(fetchRequest, @"Can't find fetch request named \"oneLocationPointWithMocId\".");
	
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
				NSLog(@"WARN fetch request oneLocationPointWithMocId: 0 or 1 objects expected, %u found (substitutionVariables:%@, results:%@)",
					[results count],
					substitutionVariables,
					results);
		}
	}
	
	if (error_) *error_ = error;
	return result;
}



+ (NSArray*)fetchManyLocationPointsWithMocCached:(NSManagedObjectContext*)moc_ cached:(NSNumber*)cached_ {
	NSError *error = nil;
	NSArray *result = [self fetchManyLocationPointsWithMocCached:moc_ cached:cached_ error:&error];
	if (error) {
#if TARGET_OS_IPHONE
		NSLog(@"error: %@", error);
#else
		[NSApp presentError:error];
#endif
	}
	return result;
}
+ (NSArray*)fetchManyLocationPointsWithMocCached:(NSManagedObjectContext*)moc_ cached:(NSNumber*)cached_ error:(NSError**)error_ {
	NSError *error = nil;
	
	NSManagedObjectModel *model = [[moc_ persistentStoreCoordinator] managedObjectModel];
	NSFetchRequest *fetchRequest = [model fetchRequestFromTemplateWithName:@"manyLocationPointsWithMocCached"
													 substitutionVariables:[NSDictionary dictionaryWithObjectsAndKeys:
														
														cached_, @"cached",
														
														nil]
													 ];
	NSAssert(fetchRequest, @"Can't find fetch request named \"manyLocationPointsWithMocCached\".");
	
	NSArray *result = [moc_ executeFetchRequest:fetchRequest error:&error];
	if (error_) *error_ = error;
	return result;
}


@end
