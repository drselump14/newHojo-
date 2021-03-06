//
//  WorkInfoViewController.h
//  hojo!
//
//  Created by slamet kristanto on 1/21/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MemberPickerController.h"

@protocol WorkInfoViewControllerDelegate

-(void)didReceiveMember:(NSString *)newMember;

@end

@interface WorkInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate>{
    //IBOutlet UITableView *weatherTable;
    //IBOutlet UIImageView *weatherImage;
    IBOutlet UITableView *memberTable;
    IBOutlet UILabel *currentTempLabel,*highTempLabel,*lowTempLabel,*conditionLabel,*cityLabel,*humidityLabel;
    IBOutlet UIImageView *conditionsImageView;
    UIImage *conditionsImage;
    CLLocationManager *locationManager;
    id<CLLocationManagerDelegate> locationDelegate;
    double userLocationLat,userLocationLong;
    NSString *city,*pref,*address;
    NSMutableArray *member;
}
@property (nonatomic,retain) IBOutlet UILabel *currentTempLabel,*highTempLabel,*lowTempLabel,*conditionLabel,*cityLabel,*humidityLabel;
@property (nonatomic,retain) IBOutlet UIImageView *conditionImageView;
@property (nonatomic,retain) UIImage *conditionImage;
@property (nonatomic,retain) CLLocationManager *locationManager;
@property (copy)id<CLLocationManagerDelegate> locationDelegate;
@property (nonatomic,retain) NSMutableArray *member;

-(IBAction)addTodayMember:(id)sender;


@end
