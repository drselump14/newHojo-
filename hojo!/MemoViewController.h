//
//  MemoViewController.h
//  hojo!
//
//  Created by slamet kristanto on 1/23/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemoViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    IBOutlet UITextView *memoTextView;
    IBOutlet UIButton *fotoButton,*recordButton,*saveButton;
    IBOutlet UIImageView *imageView;
    
}
-(IBAction)showActionSheet:(id)sender;
-(IBAction)takePicture;
-(IBAction)pictureFromLibrary;

@end
