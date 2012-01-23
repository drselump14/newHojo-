//
//  MemoViewController.h
//  hojo!
//
//  Created by slamet kristanto on 1/23/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MemoViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,AVAudioPlayerDelegate,AVAudioRecorderDelegate,UITextViewDelegate>{
    IBOutlet UITextView *memoTextView;
    IBOutlet UIButton *fotoButton,*recordButton,*saveButton;
    IBOutlet UIImageView *imageView;
    AVAudioRecorder *audioRecorder;
    AVAudioPlayer *audioPlayer;
    UIButton *playButton;
    UIButton *stopButton;

    
    
}
@property (nonatomic, retain) IBOutlet UIButton *playButton;
@property (nonatomic, retain) IBOutlet UIButton *recordButton;
@property (nonatomic, retain) IBOutlet UIButton *stopButton;
-(IBAction)recordAudio;
-(IBAction)playAudio;
-(IBAction)stop;

-(IBAction)showActionSheet:(id)sender;
-(IBAction)takePicture;
-(IBAction)pictureFromLibrary;

-(IBAction)textFieldReturn:(id)sender;
-(IBAction)backgroundTouched:(id)sender;

@end
