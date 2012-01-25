//
//  VolumeInputViewController.h
//  hojo!
//
//  Created by slamet kristanto on 1/25/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditViewController.h"

@protocol EditViewDelegate;

@interface VolumeInputViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    IBOutlet UITableView *volumePickerTable;
    id<EditViewDelegate> delegate;
    IBOutlet UIPickerView *volumePickerView;
    NSMutableArray *array1;
    NSMutableArray *array2;
    NSString *volumeString;
}
@property (nonatomic,retain)IBOutlet UIPickerView *volumePickerView;
@property (nonatomic,retain)id<EditViewDelegate> delegate;

@end
