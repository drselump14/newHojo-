//
//  MemberPickerController.m
//  hojo!
//
//  Created by slamet kristanto on 1/24/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import "MemberPickerController.h"

@implementation MemberPickerController
@synthesize delegate;
@synthesize memberArray;
@synthesize member;

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
    self.title=@"メンバーを追加";
    memberPickerTable.dataSource=self;
    memberPickerTable.delegate=self;
    memberArray=[[NSMutableArray alloc]initWithObjects:@"内海",@"井上",@"清水",@"吉田",@"山尾",@"重田",@"加藤",@"佐藤",@"田口", nil];
    selectedIndex=[memberArray indexOfObject:self.member];
    // Do any additional setup after loading the view from its nib.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [memberArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text=[memberArray objectAtIndex:indexPath.row];
    if (indexPath.row==selectedIndex) {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (selectedIndex!=NSNotFound) {
        UITableViewCell *cell=[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0]];
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    selectedIndex=indexPath.row;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType=UITableViewCellAccessoryCheckmark;
    NSString *theMember=[memberArray objectAtIndex:indexPath.row];
    //NSLog(@"%@",theMember);
    [delegate didReceiveMember:theMember];
    [self.navigationController popViewControllerAnimated:YES];
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
