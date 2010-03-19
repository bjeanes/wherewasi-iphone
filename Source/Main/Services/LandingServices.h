//
//  LandingServices.h
//  wherewasi
//
//  Created by Anthony Mittaz on 19/03/10.
//  Copyright 2010 Mogeneration. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OD2/OD2Services.h>

@interface LandingServices : OD2Services {

}

@property (nonatomic, readonly) NSArray *landings;

+ (LandingServices *)sharedLandingServices;

@end
