//
//  EditViewController.h
//  hojo!
//
//  Created by slamet kristanto on 1/19/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TakeHojoFromMap.h"

@protocol EditViewDelegate

-(void)didReceiveWork:(NSString *)work;
-(void)didReceiveStartTime:(NSString *)startTime didReceiveFinishTime:(NSString *)finishTime;
-(void)didReceiveWorkPlace:(NSString *)workPlace;
-(void)didReceiveCrop:(NSString *)crop;
-(void)didreceivePestiside:(NSString *)pest;
-(void)didreceivePestisideVolume:(NSString *)pestVol;

@end

@protocol DiaryViewDelegate;

@interface EditViewController : UIViewController<EditViewDelegate, UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    id<DiaryViewDelegate> delegate;
    TakeHojoFromMap *takeHojoFromMap;
    IBOutlet UITableView *editTable;
    NSMutableArray *Label1,*Label2,*Label3;
    NSString *workName,*cropName,*workPlaceString,*carrierString,*pestiside,*pestVolume,*pestDilution;
    NSString *startTimeString,*finishTimeString;
    NSString *editTableSignal;
    NSInteger editTableRow;
    IBOutlet UIStepper *mySteppr;
    IBOutlet UITableViewCell *dilutionCell,*carrierCell;
    IBOutlet UILabel *dilutionLabel,*carrierLabel;
    IBOutlet UISlider *dilutionSlider;
    IBOutlet UIStepper *carrierStepper;
    
    
}
@property (nonatomic,strong) NSMutableArray *Label1,*Label2,*Label3;
@property (nonatomic,retain) TakeHojoFromMap *takeHojoFromMap;
@property (retain,nonatomic) id<DiaryViewDelegate> delegate;
@property (nonatomic,copy) NSString *workName,*cropName,*workPlaceString,*carrierString,*pestiside,*pestVolume,*pestDilution,*startTimeString,*finishTimeString;
@property (copy) NSString *editTableSignal;
@property NSInteger editTableRow;

-(IBAction)saveDiary:(id)sender;
-(IBAction)changeDilution:(id)sender;
-(IBAction)changeCarrier:(id)sender;
@end
