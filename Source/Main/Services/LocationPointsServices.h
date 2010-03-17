//
//  LocationPointsServices.h
//  wherewasi
//
//  Created by Anthony Mittaz on 17/03/10.
//  Copyright 2010 Mogeneration. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OD2/OD2Services.h>

@interface LocationPointsServices : OD2Services {

}

+ (LocationPointsServices *)sharedLocationPointsServices;

- (void)postLocationPoint:(LocationPoint *)locationPoint;

@end
