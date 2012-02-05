//
//  MemoAttachmentFile.m
//  hojo!
//
//  Created by slamet kristanto on 1/26/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import "MemoAttachmentFile.h"

@implementation MemoAttachmentFile
@synthesize imageView;
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
    
    self.title=@"添付ファイルを表示";
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *pngFilePath = [NSString stringWithFormat:@"%@/MyName.png",docDir];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:pngFilePath];
    
    imageView.image=image;
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)doneViewer:(id)sender{
    [self dismissModalViewControllerAnimated:YES];
}
-(IBAction)deletePict:(id)sender{
    UIActionSheet *deleteConfirm=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"キャンセル" destructiveButtonTitle:@"写真を削除" otherButtonTitles: nil];
    [deleteConfirm showInView:self.view];
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *buttonTitle=[actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"写真を削除"]){
        if (imageView!=nil) {
            [UIView beginAnimations:@"suck" context:NULL];
            [UIView setAnimationDuration:0.9f];
            [UIView setAnimationTransition:103 forView:self.imageView cache:YES];
            //[UIView setAnimationPosition:CGPointMake(204, 460)]; // どこを吸い込まれる中心点にするかの設定
            [UIView commitAnimations];
            imageView.image=nil;
            NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *pngFilePath = [NSString stringWithFormat:@"%@/MyName.png",docDir];
            NSFileManager *filemgr;
            
            filemgr = [NSFileManager defaultManager];
            
            if ([filemgr removeItemAtPath: 
                 pngFilePath error: NULL]  == YES){
                NSLog (@"Remove successful");
                fileGoneLabel.hidden=NO;
                [delegate removeButton];
            }
            
            else{
                NSLog (@"Remove failed");
                fileGoneLabel.hidden=YES;
            }
        }
        
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

@end
