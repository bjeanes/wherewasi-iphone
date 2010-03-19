//
//  LandingServices.m
//  wherewasi
//
//  Created by Anthony Mittaz on 19/03/10.
//  Copyright 2010 Mogeneration. All rights reserved.
//

#import "LandingServices.h"


@implementation LandingServices

SYNTHESIZE_SINGLETON_FOR_CLASS(LandingServices)

- (NSArray *)landings
{
	return [NSArray arrayWithObjects:
			@"Generate Token", 
			@"Create Point", 
			@"Sync",
			nil];
}

@end
