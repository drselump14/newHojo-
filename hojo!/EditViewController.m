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

@implementation EditViewController
@synthesize Label1,Label2;
@synthesize takeHojoFromMap;
@synthesize workName,cropName,workPlaceString,startTimeString,finishTimeString;
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
    else
        self.title=@"作業項目を編集";
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    editTable.dataSource=self;
    editTable.delegate=self;
    Label1=[NSArray arrayWithObjects:@"作業名",@"農作物",@"作業場",@"作業時間",nil];
    Label2=[NSArray arrayWithObjects:@"農薬種", @"農薬のボリューム",@"希釈(倍)",nil];
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
        return [Label2 count];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if(section == 1){
        if (workName==@"防除") {
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
        if (workName==@"防除") {
            cell.textLabel.text=[Label2 objectAtIndex:indexPath.row];
            /*if(indexPath.row==2){
                cell.detailTextLabel.text=workPlaceString;
            }
            else if(indexPath.row==1){
                cell.detailTextLabel.text=cropName;
            }
            else if(indexPath.row==0){
                //cell.detailTextLabel.text=theWorkData.workData;
                cell.detailTextLabel.text=workName;
            }*/

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
            [self.navigationController pushViewController:timeView animated:YES];
        }

    }
    else{
        
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
        [delegate didAddPlayer:player];
    }
    else{
        Player *player=[[Player alloc]init];
        player.workName=workName;
        player.crop=cropName;
        player.hojo=workPlaceString;
        player.startTime=startTimeString;
        player.finishTime=finishTimeString;
        NSInteger row=editTableRow;
        [delegate didEditPlayer:player editRow:row];
    }
    [self.navigationController popViewControllerAnimated:YES];

}
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
