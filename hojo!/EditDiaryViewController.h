//
//  EditDiaryViewController.h
//  hojo!
//
//  Created by slamet kristanto on 1/17/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkNameTableViewController.h"
#import "StartTimePickerViewController.h"


@interface EditDiaryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    IBOutlet UITableView *editTable;
    NSMutableArray *Label1,*Label2;
    NSString *workName;  
    NSString *startTimeString,*finishTimeString;
    IBOutlet UIButton *myButton;
}
@property (nonatomic,strong) NSMutableArray *Label1,*Label2;
-(IBAction)tes:(id)sender;
@end
