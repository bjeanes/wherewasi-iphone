// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to LocationPoint.h instead.

#import <CoreData/CoreData.h>



@interface LocationPointID : NSManagedObjectID {}
@end

@interface _LocationPoint : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (LocationPointID*)objectID;



@property (nonatomic, retain) NSNumber *id;

@property long long idValue;
- (long long)idValue;
- (void)setIdValue:(long long)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *cached;

@property BOOL cachedValue;
- (BOOL)cachedValue;
- (void)setCachedValue:(BOOL)value_;

//- (BOOL)validateCached:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *message;

//- (BOOL)validateMessage:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *picture;

//- (BOOL)validatePicture:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *longitude;

@property double longitudeValue;
- (double)longitudeValue;
- (void)setLongitudeValue:(double)value_;

//- (BOOL)validateLongitude:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *latitude;

@property double latitudeValue;
- (double)latitudeValue;
- (void)setLatitudeValue:(double)value_;

//- (BOOL)validateLatitude:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSDate *occurred_at;

//- (BOOL)validateOccurred_at:(id*)value_ error:(NSError**)error_;





+ (id)fetchOneLocationPointWithMocId:(NSManagedObjectContext*)moc_ serverId:(NSNumber*)serverId_ ;
+ (id)fetchOneLocationPointWithMocId:(NSManagedObjectContext*)moc_ serverId:(NSNumber*)serverId_ error:(NSError**)error_;



+ (NSArray*)fetchManyLocationPointsWithMocCached:(NSManagedObjectContext*)moc_ cached:(NSNumber*)cached_ ;
+ (NSArray*)fetchManyLocationPointsWithMocCached:(NSManagedObjectContext*)moc_ cached:(NSNumber*)cached_ error:(NSError**)error_;


@end

@interface _LocationPoint (CoreDataGeneratedAccessors)

@end
