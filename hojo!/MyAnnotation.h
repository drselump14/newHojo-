//
//  MyAnnotation.h
//  tabBarTest
//
//  Created by slamet kristanto on 1/11/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mapkit/Mapkit.h>

@interface MyAnnotation : NSObject<MKAnnotation>{
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
}

@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *subtitle;
@end
