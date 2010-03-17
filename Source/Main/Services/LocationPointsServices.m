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

- (void)postLocationPoint:(LocationPoint *)locationPoint
{
	NSString *apiToken = [[NSUserDefaults standardUserDefaults]valueForKey:APITokenUserDefaults];
	if (!apiToken) {
		// Should alert user
		// Ok relogin
		return;
	}
	
	NSString *url = WHEREWASIURL(BASE_URL, POINTS_PATH);
	ASIFormDataRequest *request;
	request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
	[request setUsername:apiToken];
	[request setPassword:@"x"];
	//Post values
	// required
	[request setPostValue:@"27.12421" forKey:@"point[latitude]"];
	[request setPostValue:@"53.13412" forKey:@"point[longitude]"];
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc]init]autorelease];
	[dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
	[dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'.000Z'"];
	[request setPostValue:[dateFormatter stringFromDate:[NSDate date]] forKey:@"point[occurred_at]"];
	// Not required
	[request setPostValue: @"Hello from anthony" forKey:@"point[message]"];
	[self.networkQueue addOperation:request];

	[self.networkQueue go];

	[[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:TRUE];
}

- (void)fetchCompleted:(ASIHTTPRequest *)request
{
	[self savedLastFetchedUrl:[request.url absoluteString]];
	
	NSError *error = [request error];
	if (!error) {
		NSString *response = [request responseString];
		DLog(@"%@", response);
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
