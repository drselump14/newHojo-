//
//  MemoViewController.m
//  hojo!
//
//  Created by slamet kristanto on 1/23/12.
//  Copyright (c) 2012 香川高専高松キャンパス. All rights reserved.
//

#import "MemoViewController.h"
#import "MemoAttachmentFile.h"
#import <unistd.h>

const unsigned char SpeechKitApplicationKey[] = {0x8c, 0x19, 0x46, 0x0a, 0x51, 0x54, 0x4d, 0x92, 0x80, 0x8c, 0x05, 0xbe, 0xec, 0xb7, 0xda, 0xcc, 0xc1, 0x03, 0x06, 0xe2, 0xfa, 0x42, 0x30, 0x16, 0xbd, 0x9d, 0x45, 0xf5, 0xa1, 0x0e, 0x31, 0x2e, 0x27, 0x78, 0x38, 0x78, 0xcc, 0x85, 0x0a, 0x4c, 0x11, 0x0f, 0x0b, 0xfe, 0xc7, 0xe5, 0xca, 0x88, 0xe9, 0xd0, 0x6a, 0xe3, 0x12, 0x9a, 0xf9, 0xcf, 0x37, 0x3e, 0xc5, 0xd9, 0x4c, 0xf6, 0x07, 0x73};

@implementation MemoViewController
@synthesize recordButton,playButton,stopButton;
@synthesize memoTextView;

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
- (void)viewWillAppear:(BOOL)animated{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *pngFilePath = [NSString stringWithFormat:@"%@/MyName.png",docDir];
    //UIImage *image = [[UIImage alloc] initWithContentsOfFile:pngFilePath];
    NSFileManager *filemgr;
    filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: pngFilePath ] == YES)
    {
        NSLog (@"File exists");
        attachFile.enabled=YES;
        //attachFile.highlighted=YES;
        [attachFile setTitle:@"添付ファイルを表示" forState:UIControlStateNormal];

    }    else
    {
        NSLog (@"File not found");
        attachFile.enabled=NO;
        //attachFile.highlighted=NO;
        [attachFile setTitle:@"添付ファイルはなし" forState:UIControlStateNormal];
    }
    
}
/*-(void)loadView{
    [super loadView];
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scroll.pagingEnabled=YES;
    scroll.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*2);
    [self.view addSubview:scroll];
}*/
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    memoTextView.editable=YES;
    playButton.enabled = NO;
    stopButton.enabled = NO;
    recordActivity.hidden=YES;
    memoTextView.delegate=self;
    [SpeechKit setupWithID:@"NMDPTRIAL_botoks20111030234755"
                      host:@"sandbox.nmdp.nuancemobility.net"
                      port:443
                    useSSL:NO
                  delegate:nil];   
    SKEarcon* earconStart	= [SKEarcon earconWithName:@"earcon_listening.wav"];
	SKEarcon* earconStop	= [SKEarcon earconWithName:@"earcon_done_listening.wav"];
	SKEarcon* earconCancel	= [SKEarcon earconWithName:@"earcon_cancel.wav"];
	
	[SpeechKit setEarcon:earconStart forType:SKStartRecordingEarconType];
	[SpeechKit setEarcon:earconStop forType:SKStopRecordingEarconType];
	[SpeechKit setEarcon:earconCancel forType:SKCancelRecordingEarconType];

    //vocalizer = [[SKVocalizer alloc] initWithLanguage:@"ja_JP"delegate:self];
    NSArray *dirPaths;
    NSString *docsDir;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    NSString *soundFilePath = [docsDir
                               stringByAppendingPathComponent:@"sound.caf"];
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    NSDictionary *recordSettings = [NSDictionary 
                                    dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:AVAudioQualityMin],
                                    AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt:16], 
                                    AVEncoderBitRateKey,
                                    [NSNumber numberWithInt: 2], 
                                    AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:44100.0], 
                                    AVSampleRateKey,
                                    nil];
    
    NSError *error = nil;
    
    audioRecorder = [[AVAudioRecorder alloc]
                     initWithURL:soundFileURL
                     settings:recordSettings
                     error:&error];
    
    if (error)
    {
        NSLog(@"error: %@", [error localizedDescription]);
    } else {
        [audioRecorder prepareToRecord];
    }

    
}
-(IBAction)textFieldReturn:(id)sender{
    [sender resignFirstResponder];
}
-(IBAction)backgroundTouched:(id)sender{
    [memoTextView resignFirstResponder];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range 
 replacementText:(NSString *)text
{
    // Any new character added is passed in as the "text" parameter
    if ([text isEqualToString:@"\n"]) {
        // Be sure to test for equality using the "isEqualToString" message
        [textView resignFirstResponder];
        
        // Return FALSE so that the final '\n' character doesn't get added
        return FALSE;
    }
    // For any other character return TRUE so that the text gets added to the view
    return TRUE;
}
-(IBAction)showActionSheet:(id)sender{
    UIActionSheet *pictActionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"キャンセル" destructiveButtonTitle:nil otherButtonTitles:@"写真撮影",@"ライブラリから選択",nil];
    pictActionSheet.delegate=self;
    [pictActionSheet showInView:self.parentViewController.tabBarController.view];
    
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
    picker.allowsEditing = NO;
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
-(IBAction)viewAttachment:(id)sender{
    MemoAttachmentFile *attachmentView=[[MemoAttachmentFile alloc]initWithNibName:@"MemoAttachmentFile" bundle:nil];
    attachmentView.imageView.image=attachmentPict;
    attachmentView.delegate=self;
    [self presentModalViewController:attachmentView animated:YES];
    //[self.navigationController pushViewController:attachmentView animated:YES];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    imageView.image=image;
    //attachmentPict=image;
    [picker dismissModalViewControllerAnimated:YES];
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *pngFilePath = [NSString stringWithFormat:@"%@/MyName.png",docDir];
    NSData *data = [NSData dataWithData:UIImagePNGRepresentation(image)];
    [data writeToFile:pngFilePath atomically:YES];
    attachFile.enabled=YES;
    //attachFile.highlighted=YES;
    [attachFile setTitle:@"添付ファイルを表示" forState:UIControlStateNormal];
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:pngFilePath];
    imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    imageButton.frame = CGRectMake(10, 150, 280, 140);
    [imageButton setImage:img forState:UIControlStateNormal];
    //[self.view addSubview:imageButton];
    [self.memoTextView addSubview:imageButton];
    [imageButton addTarget:self action:@selector(viewAttachment:) forControlEvents:UIControlEventTouchUpInside];
    /*UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 150, 300, 200)];
    //NSString *imgFilepath = [[NSBundle mainBundle] pathForResource:@"brick" ofType:@"png"];
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:pngFilePath];
    [imgView setImage:img];
    [self.view addSubview:imgView];*/
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissModalViewControllerAnimated:YES];
}
-(void)removeButton{
    [imageButton removeFromSuperview];
}
-(void) recordAudio
{
    if (transactionState == TS_RECORDING) {
        [recognizer stopRecording];
        //[recordActivity stopAnimating];
    }
    else if (transactionState == TS_IDLE) {
        playButton.enabled = NO;
        stopButton.enabled = YES;
        stopButton.highlighted=YES;
        //[recordActivity startAnimating];
        NSLog(@"録音が始まる");
        //[audioRecorder record];
        recognizer = [[SKRecognizer alloc] initWithType:SKSearchRecognizerType
                                              detection:SKLongEndOfSpeechDetection
                                               language:@"ja_JP"
                                               delegate:self];

    }
}
-(void)stop
{
    stopButton.enabled = NO;
    playButton.enabled = YES;
    recordButton.enabled = YES;
    
    if (audioRecorder.recording)
    {
        [audioRecorder stop];
        playButton.highlighted=YES;
    } else if (audioPlayer.playing) {
        [audioPlayer stop];
    }
}
-(void) playAudio
{
    if (!audioRecorder.recording)
    {
        stopButton.enabled = YES;
        stopButton.highlighted=YES;
        recordButton.enabled = NO;
        
       NSError *error;
        
        audioPlayer = [[AVAudioPlayer alloc] 
                       initWithContentsOfURL:audioRecorder.url                                    
                       error:&error];
        
        audioPlayer.delegate = self;
        
        if (error)
            NSLog(@"Error: %@", 
                  [error localizedDescription]);
        else
            [audioPlayer play];
    }
}

-(void)audioPlayerDidFinishPlaying:
(AVAudioPlayer *)player successfully:(BOOL)flag
{
    recordButton.enabled = YES;
    playButton.highlighted=YES;
    stopButton.enabled = NO;
    stopButton.highlighted=NO;
}
-(void)audioPlayerDecodeErrorDidOccur:
(AVAudioPlayer *)player 
                                error:(NSError *)error
{
    NSLog(@"Decode Error occurred");
}
-(void)audioRecorderDidFinishRecording:
(AVAudioRecorder *)recorder 
                          successfully:(BOOL)flag
{
    playButton.highlighted=YES;
    NSLog(@"録音成功");
}
-(void)audioRecorderEncodeErrorDidOccur:
(AVAudioRecorder *)recorder 
                                  error:(NSError *)error
{
    NSLog(@"Encode Error occurred");
}
#pragma mark -
#pragma mark SKRecognizerDelegate methods

- (void)recognizerDidBeginRecording:(SKRecognizer *)recognizer
{
    NSLog(@"Recording started.");
    //[vocalizer speakString:@"録音開始"];
    transactionState = TS_RECORDING;
    //recordActivity.hidden=NO;
    //[recordActivity startAnimating];
    [recordButton setTitle:@"録音中..." forState:UIControlStateNormal];
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    HUD.labelText = @"録音中";
	[HUD show:YES];
    //[HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}
- (void)recognizerDidFinishRecording:(SKRecognizer *)recognizer
{
    NSLog(@"Recording finished.");
    //[vocalizer speakString:@"録音終了"];
    transactionState = TS_PROCESSING;
    [recordButton setTitle:@"処理中" forState:UIControlStateNormal];
    //[HUD hide:YES];
    HUD.labelText=@"処理中";
    //[HUD show:YES];
}

- (void)recognizer:(SKRecognizer *)recognizer didFinishWithResults:(SKRecognition *)results
{
    NSLog(@"Got results.");
    [HUD hide:YES];
    long numOfResults = [results.results count];
    
    transactionState = TS_IDLE;
    [recordActivity stopAnimating];
    recordActivity.hidden=YES;
    [recordButton setTitle:@"音声メモ" forState:UIControlStateNormal];
    
    if (numOfResults > 0)
        memoTextView.text = [results firstResult];
    
	if (numOfResults > 1) 
		memoTextView.text = [[results.results subarrayWithRange:NSMakeRange(1, numOfResults-1)] componentsJoinedByString:@"\n"];
    
    if (results.suggestion) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Suggestion"
                                                        message:results.suggestion
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];        
        [alert show];
        
    }
    
	//[voiceSearch release];
	self->recognizer = nil;
}

- (void)recognizer:(SKRecognizer *)recognizer didFinishWithError:(NSError *)error suggestion:(NSString *)suggestion
{
    NSLog(@"Got error.");
    [HUD hide:YES];
    transactionState = TS_IDLE;
    [recordButton setTitle:@"音声" forState:UIControlStateNormal];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];        
    [alert show];
    
    if (suggestion) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Suggestion"
                                                        message:suggestion
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];        
        [alert show];
        
        
    }
    
    //voiceSearch = nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    audioPlayer = nil;
    audioRecorder = nil;
    stopButton = nil;
    recordButton = nil;
    playButton = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
