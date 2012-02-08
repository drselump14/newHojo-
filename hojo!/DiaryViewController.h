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
#import "MBProgressHUD.h"

@protocol DiaryViewDelegate <NSObject>

-(void)didAddPlayer:(Player *)player;
-(void)didEditPlayer:(Player *)player editRow:(NSInteger)row;
-(void)getUser:(NSString *)user;
-(void)getUserName:(NSString *)userName;
@end

@interface DiaryViewController : UITableViewController<DiaryViewDelegate,UIActionSheetDelegate,MBProgressHUDDelegate>
{
    NSMutableArray *players;
    EditViewController *editViewController;
    int badgeNumber;
    NSMutableData *responseData;
    NSString *userNameString;
    MBProgressHUD *HUD;
}

@property (nonatomic, strong) NSMutableArray *players;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic,retain) EditViewController *editViewController;

-(IBAction)EditTable:(id)sender;
-(IBAction)SubmitTable:(id)sender;
-(IBAction)AddTable:(id)sender;


@end
