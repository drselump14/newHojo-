//
//  MyReverseGeocoder.h
//  hojo!
//
//  Created by slamet kristanto on 1/22/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouchXML.h"

@interface MyReverseGeocoder : NSObject {
    NSString  *city;
    
}

@property (nonatomic,retain) NSString *city;

- (MyReverseGeocoder *)initWithLatitude:(NSString *)latitude initWithLongitude:(NSString *)longitude;

@end
