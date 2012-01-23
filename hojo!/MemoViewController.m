//
//  MemoViewController.m
//  hojo!
//
//  Created by slamet kristanto on 1/23/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import "MemoViewController.h"

@implementation MemoViewController

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    memoTextView.editable=YES;
    
}

-(IBAction)showActionSheet:(id)sender{
    UIActionSheet *pictActionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"キャンセル" destructiveButtonTitle:nil otherButtonTitles:@"写真撮影",@"ライブラリから選択",nil];
    pictActionSheet.delegate=self;
    [pictActionSheet showInView:self.parentViewController.tabBarController.view];
    //[pictActionSheet dismissWithClickedButtonIndex:0 animated:YES];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        NSLog(@"0");
        [self performSelector:@selector(takePicture)];
    } 
    else if(buttonIndex==1){
        NSLog(@"1");
        [self performSelector:@selector(pictureFromLibrary)];
    }
    else {
        NSLog(@"2");
    }
}
-(IBAction)takePicture{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType=UIImagePickerControllerSourceTypeCamera;
    [self presentModalViewController: picker animated:YES];
}
-(IBAction)pictureFromLibrary{
    if ([UIImagePickerController  isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary ]) {
        UIImagePickerController *picker=[[UIImagePickerController alloc]init];
        picker.delegate=self;
        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentModalViewController:picker animated:YES];
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    imageView.image=image;
    [picker dismissModalViewControllerAnimated:YES];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissModalViewControllerAnimated:YES];
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
