//
//  LocationPointsServices.m
//  wherewasi
//
//  Created by Anthony Mittaz on 17/03/10.
//  Copyright 2010 Mogeneration. All rights reserved.
//

#import "LocationPointsServices.h"


@implementation LocationPointsServices

SYNTHESIZE_SINGLETON_FOR_CLASS(LocationPointsServices)

- (NSManagedObjectContext *)managedObjectContext
{
	// override
	return [AppDelegate sharedAppDelegate].managedObjectContext;
}

- (NSArray *)uncachedLocationPoints
{
	NSArray *cachedLocationPoints = [LocationPoint fetchManyLocationPointsWithMocCached:self.managedObjectContext 
																				 cached:[NSNumber numberWithBool:FALSE]];
	return cachedLocationPoints;
}

- (void)postLocationPoint:(LocationPoint *)locationPoint
{
	NSString *apiToken = [[NSUserDefaults standardUserDefaults]valueForKey:APITokenUserDefaults];
	if (!apiToken) {
		// Should alert user
		UIAlertView *alertView = [[[UIAlertView alloc]
								   initWithTitle:@"No API token found"
								   message:@"Would you like to generate an API token now, the server sync will be canceled"
								   delegate:nil
								   cancelButtonTitle:nil
								   otherButtonTitles:@"Yes", nil] autorelease];
		[alertView show];
		// Ok relogin
		[[LoginServices sharedLoginServices]apiToken];
		return;
	}
	
	NSString *url = WHEREWASIURL(BASE_URL, POINTS_PATH);
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
	request.userInfo = [NSDictionary dictionaryWithObject:locationPoint forKey:@"object"];
	[request setUsername:apiToken];
	[request setPassword:@"x"];
	//Post values
	// required
	[request setPostValue:locationPoint.latitude forKey:@"point[latitude]"];
	[request setPostValue:locationPoint.longitude forKey:@"point[longitude]"];
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc]init]autorelease];
	[dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
	[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'.000Z'"];
	[request setPostValue:[dateFormatter stringFromDate:locationPoint.occurred_at] forKey:@"point[occurred_at]"];
	// Not required
	if (locationPoint.picture && locationPoint.picture.length > 0) {
		// only if an image is given
//		[request setData:UIImageJPEGRepresentation([UIImage imageNamed:@"stpatricksday10-hp.gif"], 1.0) 
//			withFileName:@"google.jpeg" 
//		  andContentType:@"image/jpeg"
//				  forKey:@"point[picture]"];
		[request setFile:locationPoint.picture 
			withFileName:@"picture.jpeg" 
		  andContentType:@"image/jpeg" 
				  forKey:@"point[picture"];
		[request setShouldStreamPostDataFromDisk:YES];
	}
	if (locationPoint.message && locationPoint.message.length > 0) {
		[request setPostValue:locationPoint.message forKey:@"point[message]"];
	}
	
	[self.networkQueue addOperation:request];

	[self.networkQueue go];

	[[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:TRUE];
}

- (void)postLocationPoints:(NSArray *)locationPoints
{
	for (LocationPoint *point in locationPoints) {
		[self postLocationPoint:point];
	}
}

- (void)fetchCompleted:(ASIHTTPRequest *)request
{
	[self savedLastFetchedUrl:[request.url absoluteString]];
	
	NSError *error = [request error];
	if (!error) {
		NSString *response = [request responseString];
		DLog(@"%@", response);
		// If succeed consider object as being synced with server
		LocationPoint *point = [request.userInfo  valueForKey:@"object"];
		point.cachedValue = TRUE;
		[self.managedObjectContext save:NULL];
		
		NSFileManager *manager = [NSFileManager defaultManager];
		if ([manager fileExistsAtPath:point.picture]) {
			[manager removeItemAtPath:point.picture error:NULL];
		}
		
		[[NSNotificationCenter defaultCenter] postNotificationName:DidPostLocationPoint object:self];
	}
	
	// should refetch content
	DLog(@"fetch complete");
}

- (void)fetchFailed:(ASIHTTPRequest *)request
{
	[self savedLastFetchedUrl:[request.url absoluteString]];
	DLog(@"fetch failed");
}

- (void)queueFinished:(ASINetworkQueue *)queue
{
	DLog(@"queue finished");
	[[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:FALSE];
}

- (void)dealloc
{
	
	[super dealloc];
}

@end
