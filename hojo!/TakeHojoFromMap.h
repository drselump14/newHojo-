//
//  TakeHojoFromMap.h
//  hojo!
//
//  Created by slamet kristanto on 1/20/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol EditViewDelegate;

@interface TakeHojoFromMap : UIViewController<MKMapViewDelegate>{
    id<EditViewDelegate> delegate;
    IBOutlet MKMapView *myMapView;
    NSString *editMap,*selectedHojo;
}
@property(strong,nonatomic) IBOutlet MKMapView *myMapView;
@property(strong,nonatomic) NSString *editMap,*selectedHojo;
@property (retain,nonatomic) id<EditViewDelegate> delegate;

-(IBAction)addHojo:(id)sender;

@end
