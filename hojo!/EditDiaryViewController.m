//
//  EditDiaryViewController.m
//  hojo!
//
//  Created by slamet kristanto on 1/17/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import "EditDiaryViewController.h"
#import "StartTimePickerViewController.h"
#import "WorkNameTableViewController.h"
#import "AppDelegate.h"
#import "CropsTableViewController.h"


@implementation EditDiaryViewController
@synthesize Label1,Label2;

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
/*- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder:aDecoder]))
	{
		NSLog(@"init PlayerDetailsViewController");
        workName= @"肥料散布";
	}
	return self;
}*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"作業項目を編集";
    editTable.dataSource=self;
    editTable.delegate=self;
    Label1=[NSArray arrayWithObjects:@"作業名",@"農作物",@"作業場",@"作業時間",nil];
    Label2=[NSArray arrayWithObjects:@"作業名",@"農作物",@"作業場",@"開始時間",nil];
    //[startTimePicker setHidden:YES];
    // Do any additional setup after loading the view from its nib.
}
-(void)didSelectCrop:(NSString *)crop{
    [Label2 insertObject:crop atIndex:1];
    self.title=crop;
    [editTable reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text=[Label1 objectAtIndex:indexPath.row];
    NSString *workTimeString=[[NSString alloc]initWithFormat:@"%@~%@",startTimeString,finishTimeString];
    if (indexPath.row==3) {
        //cell.detailTextLabel.text=workTimeString;
        cell.detailTextLabel.text=workTimeString;
    }
    else if(indexPath.row==0){
        AppDelegate *theWorkData=(AppDelegate *)[[UIApplication sharedApplication] delegate];
        cell.detailTextLabel.text=theWorkData.workData;
    }
    else
     cell.detailTextLabel.text=[Label2 objectAtIndex:indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==3) {
        StartTimePickerViewController *detailViewController = [[StartTimePickerViewController alloc] initWithNibName:@"StartTimePickerViewController" bundle:nil];
        // ...
        // Pass the selected object to the new view controller.
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    else if(indexPath.row==0){
        WorkNameTableViewController *detailViewController = [[WorkNameTableViewController alloc] initWithNibName:@"WorkNameTableViewController" bundle:nil];
        // ...
        // Pass the selected object to the new view controller.
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    else if(indexPath.row==1){
        CropsTableViewController *detailViewController = [[CropsTableViewController alloc] initWithNibName:@"CropsTableViewController" bundle:nil];
        // ...
        // Pass the selected object to the new view controller.
        [self presentModalViewController:detailViewController animated:YES];
        //[self.navigationController pushViewController:detailViewController animated:YES];
    }
}
-(IBAction)tes:(id)sender{
    CropsTableViewController *detailViewController = [[CropsTableViewController alloc] initWithNibName:@"CropsTableViewController" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self presentModalViewController:detailViewController animated:YES]; 
}
-(void)workNameTableViewController:(WorkNameTableViewController *)controller didSelectWork:(NSString *)theWork{
    workName=theWork;
    [editTable reloadData];
}
-(void)startTimePickerViewControllerDelegate:(StartTimePickerViewController *)controller didSelectStartTime:(NSString *)startTime didSelectFinishTime:(NSString *)finishTime{
    startTimeString=startTime;
    finishTimeString=finishTime;
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"tes" message:@"tes" delegate:self cancelButtonTitle:@"tes" otherButtonTitles: nil];
    [alert show];
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
