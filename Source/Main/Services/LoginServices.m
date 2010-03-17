//
//  LoginServices.m
//  wherewasi
//
//  Created by Anthony Mittaz on 17/03/10.
//  Copyright 2010 Mogeneration. All rights reserved.
//

#import "LoginServices.h"


@implementation LoginServices

SYNTHESIZE_SINGLETON_FOR_CLASS(LoginServices)

- (NSString *)apiToken
{
	NSString *apiToken = nil;
	
	NSString *url = WHEREWASIURL(BASE_URL, LOGIN_PATH);
	if ([self contentHasExpiredForUrl:url]) {
		[self downloadContentForUrl:url withObject:nil];
	} else {
		// Get the key from the prefs
		apiToken = [[NSUserDefaults standardUserDefaults]valueForKey:APITokenUserDefaults];
	}
	
	return apiToken;
}

- (BOOL)contentHasExpiredForUrl:(NSString *)url
{
	if ([self lastFetchedDateForUrl:url]) {
		return FALSE;
	} else {
		return TRUE;
	}
}

- (void)downloadContentForUrl:(NSString *)url withObject:(id)object
{
	//NSDictionary *userInfo = [NSDictionary dictionaryWithObject:object forKey:@"object"];
	
	ASIHTTPRequest *request;
	request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
	[request addRequestHeader:@"User-Agent" value:@"iPhone"];
	request.shouldPresentAuthenticationDialog = TRUE;
	//request.userInfo = userInfo;
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
		[[NSUserDefaults standardUserDefaults]setValue:response forKey:APITokenUserDefaults];
		// notifie that it is now possible to use credentials
		[[NSNotificationCenter defaultCenter] postNotificationName:LoginShouldReloadContentNotification object:self];
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
