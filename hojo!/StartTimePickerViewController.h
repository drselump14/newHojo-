//
//  StartTimePickerViewController.h
//  hojo!
//
//  Created by slamet kristanto on 1/17/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditViewDelegate;

@interface StartTimePickerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    id<EditViewDelegate> delegate;
    IBOutlet UITableView *workTimeTable;
    IBOutlet UIDatePicker *TimePicker;
    NSArray *label;
    NSString *startTimeLabel,*finishTimeLabel,*Time;
    NSInteger timeSelection;
}
@property (strong,nonatomic) NSString *startTimeLabel;
@property (strong,nonatomic) NSString *finishTimeLabel;
@property (strong,nonatomic) NSString *Time;
@property (retain,nonatomic) id<EditViewDelegate> delegate;

-(IBAction)PickWorkTime:(id)sender;
-(IBAction)SubmitTable:(id)sender;
@end
