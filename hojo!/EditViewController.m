//
//  EditViewController.m
//  hojo!
//
//  Created by slamet kristanto on 1/19/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import "EditViewController.h"
#import "WorkNameTableViewController.h"
#import "StartTimePickerViewController.h"
#import "CropsTableViewController.h"
#import "TakeHojoFromMap.h"
#import "DiaryViewController.h"
#import "Player.h"
#import "pestisideViewController.h"
#import "VolumeInputViewController.h"

@implementation EditViewController
@synthesize Label1,Label2,Label3;
@synthesize takeHojoFromMap;
@synthesize workName,cropName,workPlaceString,startTimeString,finishTimeString,carrierString,pestiside,pestVolume,pestDilution;
@synthesize editTableSignal;
@synthesize editTableRow;
@synthesize delegate;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [editTable reloadData];
    if (editTableSignal!=@"edit") {
        self.title=@"作業項目を追加";
    }
    else{
        self.title=@"作業項目を編集";
        [dilutionLabel setText:pestDilution];
        [carrierLabel setText:carrierString];

    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    dilutionLabel.textColor=[UIColor colorWithRed:0.22 green:0.33 blue:0.53 alpha:1.0];
    dilutionLabel.font=[UIFont fontWithName:@"System" size:17];
    carrierLabel.textColor=[UIColor colorWithRed:0.22 green:0.33 blue:0.53 alpha:1.0];
    carrierLabel.font=[UIFont fontWithName:@"System" size:17];
    editTable.dataSource=self;
    editTable.delegate=self;
    Label1=[NSArray arrayWithObjects:@"作業名",@"農作物",@"作業場",@"作業時間",nil];
    Label2=[NSArray arrayWithObjects:@"農薬種", @"農薬のボリューム",@"希釈(倍)",nil];
    Label3=[NSArray arrayWithObjects:@"キャリー数", nil];
    UIBarButtonItem *addButton=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveDiary:)];
    [self.navigationItem setRightBarButtonItem:addButton];
    // Do any additional setup after loading the view from its nib.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return [Label1 count];
    }
    else{
        if ([workName isEqualToString:@"防除"]) {
            return [Label2 count];
                        
        }
        else{
            return [Label3 count];
        }
        
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if(section == 1){
        if ([workName isEqualToString:@"防除"]||[workName isEqualToString:@"収穫"]) {
            return @"備考";
        }
        else
            return nil;
    }
    else
        return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    NSString *workTimeString=[[NSString alloc]initWithFormat:@"%@~%@",startTimeString,finishTimeString];
    
    if (indexPath.section==0) {
        cell.textLabel.text=[Label1 objectAtIndex:indexPath.row];
        if (indexPath.row==3) {
            //cell.detailTextLabel.text=workTimeString;
            //cell.detailTextLabel.text=workTimeString;
            cell.detailTextLabel.text=workTimeString;
            if (startTimeString==(NULL)||finishTimeString==(NULL)) {
                cell.detailTextLabel.text=@"";
            }
            
        }
        else if(indexPath.row==2){
            cell.detailTextLabel.text=workPlaceString;
        }
        else if(indexPath.row==1){
            cell.detailTextLabel.text=cropName;
        }
        else if(indexPath.row==0){
            //cell.detailTextLabel.text=theWorkData.workData;
            cell.detailTextLabel.text=workName;
        }

    }
    else{
        if ([workName isEqualToString:@"防除"]) {
            cell.textLabel.text=[Label2 objectAtIndex:indexPath.row];
            if(indexPath.row==2){
                //cell.detailTextLabel.text=pestDilution;
                return dilutionCell;
            }
            else if(indexPath.row==1){
                cell.detailTextLabel.text=pestVolume;

                
            }
            else{
                cell.detailTextLabel.text=pestiside;
            }

        }
        else if([workName isEqualToString:@"収穫"]){
            return carrierCell;
        }
        else{
            cell.hidden=YES;
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            WorkNameTableViewController *workTable=[[WorkNameTableViewController alloc]init];
            workTable.delegate=self;
            workTable.workName=workName;
            [self.navigationController pushViewController:workTable animated:YES];
        }
        else if(indexPath.row==1){
            CropsTableViewController *cropTable=[[CropsTableViewController alloc]init];
            cropTable.delegate=self;
            [self.navigationController pushViewController:cropTable animated:YES];
        }
        else if(indexPath.row==2){
            //TakeHojoFromMap *TakeHojoFromMap=[[TakeHojoFromMap alloc]init];
            //hojoMap.delegate=self;
            if (self.takeHojoFromMap==nil) {
                TakeHojoFromMap *viewTwo=[[TakeHojoFromMap alloc]initWithNibName:@"TakeHojoFromMap" bundle:[NSBundle mainBundle]];
                self.takeHojoFromMap=viewTwo;
            }
            //takeHojoFromMap.editMap=@"edit";
            takeHojoFromMap.delegate=self;
            [self.navigationController pushViewController:self.takeHojoFromMap animated:YES];
            
        }
        else {
            //WorkNameTableViewController *detailViewController = [[WorkNameTableViewController alloc] initWithNibName:@"WorkNameTableViewController" bundle:nil];
            // ...
            // Pass the selected object to the new view controller.
            StartTimePickerViewController *timeView=[[StartTimePickerViewController alloc]init];
            timeView.delegate=self;
            timeView.startTimeLabel=startTimeString;
            timeView.finishTimeLabel=finishTimeString;
            [self.navigationController pushViewController:timeView animated:YES];
        }

    }
    else{
        if (indexPath.row==0) {
            if ([workName isEqualToString:@"防除"]) {
                pestisideViewController *pestisideView=[[pestisideViewController alloc]initWithNibName:@"pestisideViewController" bundle:nil];
                pestisideView.delegate=self;
                [self.navigationController pushViewController:pestisideView animated:YES];
            } else {
                /*UIAlertView *carrierInput=[[UIAlertView alloc]initWithTitle:@"キャリー数" message:@"キャリー数を入れてください" delegate:self cancelButtonTitle:@"キャンセル" otherButtonTitles:@"キャリー数を挿入", nil];
                carrierInput.alertViewStyle=UIAlertViewStylePlainTextInput;
                //UITextField *emailField=[[UITextField alloc]init];
                [carrierInput show];*/
            }
        }
        else if(indexPath.row==1){
            if ([workName isEqualToString:@"防除"]) {
                VolumeInputViewController *volumeInputView=[[VolumeInputViewController alloc]initWithNibName:@"VolumeInputViewController" bundle:nil];
                volumeInputView.delegate=self;
                [self.navigationController pushViewController:volumeInputView animated:YES];
            }
        }
        else {
            
        }
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *title=[alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"キャリー数を挿入"]) {
        UITextField *carrierInput=[alertView textFieldAtIndex:0];
        //carrierInput.keyboardType=UIKeyboardTypeEmailAddress;
        carrierString=carrierInput.text;
        NSLog(@"%@",carrierString);
        [editTable reloadData];
    }
}
-(IBAction)saveDiary:(id)sender{
    if (editTableSignal!=@"edit") {
        Player *player=[[Player alloc]init];
        player.workName=workName;
        player.crop=cropName;
        player.hojo=workPlaceString;
        player.startTime=startTimeString;
        player.finishTime=finishTimeString;
        if ([workName isEqualToString:@"防除"]) {
            player.pestiside=pestiside;
            player.pestisideVolume=pestVolume;
            player.pestisideDilution=pestDilution;
        }
        else if([workName isEqualToString:@"収穫"]){
            player.CarrierCount=carrierString;
        }
        [delegate didAddPlayer:player];
    }
    else{
        Player *player=[[Player alloc]init];
        player.workName=workName;
        player.crop=cropName;
        player.hojo=workPlaceString;
        player.startTime=startTimeString;
        player.finishTime=finishTimeString;
        if ([workName isEqualToString:@"防除"]) {
            player.pestiside=pestiside;
            player.pestisideVolume=pestVolume;
            player.pestisideDilution=pestDilution;
        }
        else if([workName isEqualToString:@"収穫"]){
            player.CarrierCount=carrierString;
        }

        NSInteger row=editTableRow;
        [delegate didEditPlayer:player editRow:row];
    }
    [self.navigationController popViewControllerAnimated:YES];

}

//delegate method
-(void)didReceiveWork:(NSString *)work{
    workName=work;
    //NSIndexPath *indexPath = [[NSIndexPath alloc] init];
    //UITableViewCell *cell=[editTable dequeueReusableCellWithIdentifier:@"Cell"];
    
    [editTable reloadData];
}
-(void)didReceiveStartTime:(NSString *)startTime didReceiveFinishTime:(NSString *)finishTime{
    startTimeString=startTime;
    finishTimeString=finishTime;
    [editTable reloadData];
}
-(void)didReceiveCrop:(NSString *)crop{
    cropName=crop;
    [editTable reloadData];
}
-(void)didReceiveWorkPlace:(NSString *)workPlace{
    workPlaceString=workPlace;
    [editTable reloadData];
}
-(void)didreceivePestiside:(NSString *)pest{
    pestiside=pest;
    [editTable reloadData];
}
-(void)didreceivePestisideVolume:(NSString *)pestVol{
    pestVolume=pestVol;
    [editTable reloadData];
}


///
-(IBAction)changeDilution:(id)sender{
    pestDilution=[NSString stringWithFormat:@"%1.1lf倍",dilutionSlider.value];
    [dilutionLabel setText:pestDilution];
    NSLog(@"%@",pestDilution);
}
-(IBAction)changeCarrier:(id)sender{
    carrierString=[NSString stringWithFormat:@"%.0f箱",carrierStepper.value];
    [carrierLabel setText:carrierString];
    NSLog(@"%@",carrierString);
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
