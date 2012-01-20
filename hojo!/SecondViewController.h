//
//  SecondViewController.h
//  hojo!
//
//  Created by slamet kristanto on 1/12/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface SecondViewController : UIViewController
<MKMapViewDelegate>
{
    IBOutlet MKMapView *myMapView;
    IBOutlet UIToolbar *toolBar;
    NSString *editMap;
    //IBOutlet UINavigationBar *mapBar;
}
@property(strong,nonatomic) IBOutlet MKMapView *myMapView;
@property(strong,nonatomic) IBOutlet UIToolbar *toolBar;
@property(strong,nonatomic) NSString *editMap;
@end

