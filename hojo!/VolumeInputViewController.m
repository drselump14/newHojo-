//
//  VolumeInputViewController.m
//  hojo!
//
//  Created by slamet kristanto on 1/25/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import "VolumeInputViewController.h"

@implementation VolumeInputViewController
@synthesize volumePickerView;
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
    volumePickerTable.dataSource=self;
    volumePickerTable.delegate=self;
    volumePickerView.delegate=self;
    volumePickerView.dataSource=self;
    array1=[[NSMutableArray alloc]initWithObjects:@"1",@"10",@"25",@"50",@"100",@"250",@"500",@"1000", nil];
    array2=[[NSMutableArray alloc]initWithObjects:@"mL",@"L",@"cc",nil];
    // Do any additional setup after loading the view from its nib.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text=@"農薬のボリューム";
    cell.detailTextLabel.text=volumeString;
    return cell;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component==0) {
        return [array1 count];
    } else {
        return [array2 count];
    }
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component==0) {
        return [array1 objectAtIndex:row];
    } else {
        return [array2 objectAtIndex:row];
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    volumeString=[NSString stringWithFormat:@"%@%@",[array1 objectAtIndex:[volumePickerView selectedRowInComponent:0]],[array2 objectAtIndex:[volumePickerView selectedRowInComponent:1]]];
    NSLog(@"%@",volumeString);
    [volumePickerTable reloadData];
    [delegate didreceivePestisideVolume:volumeString];
    
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
