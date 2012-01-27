//
//  StartTimePickerViewController.m
//  hojo!
//
//  Created by slamet kristanto on 1/17/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import "StartTimePickerViewController.h"
#import "EditViewController.h"

@implementation StartTimePickerViewController
@synthesize startTimeLabel,finishTimeLabel,Time;
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"開始と終了";
    UIBarButtonItem *submitButton = [[UIBarButtonItem alloc] initWithTitle:@"完了" style:UIBarButtonItemStyleDone target:self action:@selector(SubmitTable:)];
    [self.navigationItem setRightBarButtonItem:submitButton];
    workTimeTable.delegate=self;
    workTimeTable.dataSource=self;
    label=[[NSArray alloc]initWithObjects:@"作業開始",@"作業終了",@"終日", nil];
    timeSelection=0;
    editStartTime=startTimeLabel;
    editFinishTime=finishTimeLabel;
    //startTimeLabel=Time;
    //self.view.backgroundColor=[UIColor clearColor];
    
    // Do any additional setup after loading the view from its nib.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text=[label objectAtIndex:indexPath.row];
    if (indexPath.row==0) {
        cell.detailTextLabel.text=startTimeLabel;
    }
    else if(indexPath.row==1){
        cell.detailTextLabel.text=finishTimeLabel;
    }
    else{
        /*cell.detailTextLabel.text=nil;
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.highlighted=NO;
        UISwitch *switchObj = [[UISwitch alloc] init];
        //switchObj.on = NO;
        cell.accessoryView = switchObj;*/
        return oneDay;
    }
    
    return cell;
}
-(IBAction)allDays:(id)sender{
    if (oneDaySwitch.on==YES) {
        startTimeLabel=@"09:00";
        finishTimeLabel=@"17:00";
        [workTimeTable reloadData];
    }
    else{
        startTimeLabel=editStartTime;
        finishTimeLabel=editFinishTime;
        [workTimeTable reloadData];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        timeSelection = 0;
    } else {
        timeSelection = 1;
    }
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

-(IBAction)PickWorkTime:(id)sender{
    NSDateFormatter *workTime=[[NSDateFormatter alloc]init];
    workTime.dateFormat=@"HH:mm";
    if (timeSelection==0) {
        startTimeLabel=[workTime stringFromDate:TimePicker.date];
    } else {
        finishTimeLabel=[workTime stringFromDate:TimePicker.date];
    }
    [workTimeTable reloadData];

}
-(IBAction)SubmitTable:(id)sender{
    [delegate didReceiveStartTime:startTimeLabel didReceiveFinishTime:finishTimeLabel];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
