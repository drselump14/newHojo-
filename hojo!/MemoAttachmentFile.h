//
//  MemoAttachmentFile.h
//  hojo!
//
//  Created by slamet kristanto on 1/26/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemoViewController.h"

@interface MemoAttachmentFile : UIViewController

@property (nonatomic,retain) IBOutlet UIImageView *imageView;

-(IBAction)doneViewer:(id)sender;

@end
