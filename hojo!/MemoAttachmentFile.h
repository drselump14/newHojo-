//
//  MemoAttachmentFile.h
//  hojo!
//
//  Created by slamet kristanto on 1/26/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemoViewController.h"

@protocol MemoViewDelegate;

@interface MemoAttachmentFile : UIViewController<UIActionSheetDelegate>{
    IBOutlet UILabel *fileGoneLabel;
    id<MemoViewDelegate> delegate;
    IBOutlet UIScrollView *scrollView;
}

@property (nonatomic,retain) IBOutlet UIImageView *imageView;
@property (nonatomic,retain) id<MemoViewDelegate> delegate;

-(IBAction)doneViewer:(id)sender;
-(IBAction)deletePict:(id)sender;

@end
