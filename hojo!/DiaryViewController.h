//
//  DiaryViewController.h
//  hojo!
//
//  Created by slamet kristanto on 1/12/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import "EditViewController.h"
#import "SBJson.h"

@protocol DiaryViewDelegate <NSObject>

-(void)didAddPlayer:(Player *)player;
-(void)didEditPlayer:(Player *)player editRow:(NSInteger)row;

@end

@interface DiaryViewController : UITableViewController<DiaryViewDelegate,UIActionSheetDelegate>
{
    NSMutableArray *players;
    EditViewController *editViewController;
    int badgeNumber;
    NSMutableData *responseData;
}

@property (nonatomic, strong) NSMutableArray *players;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic,retain) EditViewController *editViewController;

-(IBAction)EditTable:(id)sender;
-(IBAction)SubmitTable:(id)sender;
-(IBAction)AddTable:(id)sender;


@end
