//
//  MapDetailsViewController.h
//  hojo!
//
//  Created by slamet kristanto on 1/23/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>{
    IBOutlet UITableView *mapDetail;
    NSMutableArray *mapDetailArray,*mapLabelArray;
    NSString *destinationPoint,*sourcePoint;
    double userLocationLat,userLocationLong;
    CLLocationManager *locationManager;
    id<CLLocationManagerDelegate> locationDelegate;
}
@property (nonatomic,retain) NSMutableArray *mapDetailArray,*mapLabelArray;
@property (nonatomic,retain) NSString *destinationCoordinate;
@property (nonatomic,retain) CLLocationManager *locationManager;
@property (copy)id<CLLocationManagerDelegate> locationDelegate;

@end
