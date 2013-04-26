//
//  ViewController.m
//  gooMemo
//
//  Created by KitamuraShogo on 12/11/29.
//  Copyright (c) 2012年 KitamuraShogo. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+KNSemiModal.h"
#import <QuartzCore/QuartzCore.h>
#import "NSUserdefaults.h"

#define MY_BANNER_UNIT_ID @"a150c8ad7e6de66"


@interface ViewController (){
    NSMutableArray *_objects;

}

@end

@implementation ViewController
@synthesize words;


//modal2の動き。
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        modal2 = [[modalmodal2 alloc] initWithNibName:@"modalmodal2" bundle:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(semiModalPresented:)
                                                     name:kSemiModalDidShowNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(semiModalDismissed:)
                                                     name:kSemiModalDidHideNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(semiModalResized:)
                                                     name:kSemiModalWasResizedNotification
                                                   object:nil];
        
        // Custom initialization
    }
    return self;
}
- (void) semiModalResized:(NSNotification *) notification {
    if(notification.object == self){
        NSLog(@"The view controller presented was been resized");
    }
}

- (void)semiModalPresented:(NSNotification *) notification {
    if (notification.object == self) {
        NSLog(@"This view controller just shown a view with semi modal annimation");
    }
}
- (void)semiModalDismissed:(NSNotification *) notification {
    if (notification.object == self) {
        NSLog(@"A view controller was dismissed with semi modal annimation");
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // スクロールビューを作成します。
    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,30, 320, 320)];
    [self.view addSubview:myScrollView];
    [myScrollView release];
    
   //textViewなら改行できる。
    GooMenV = [[[UITextView alloc]initWithFrame:CGRectMake(35,180,250,35)] autorelease];
    GooMenV.backgroundColor = [UIColor clearColor];
    GooMenV.returnKeyType = UIReturnKeyDefault;
    GooMenV.layer.borderWidth = 1;
    GooMenV.layer.borderColor = [[UIColor colorWithRed:0.0 green:0.3 blue:1.0 alpha:0.5] CGColor];
    GooMenV.layer.cornerRadius = 5;
    GooMenV.font = [UIFont systemFontOfSize:20];
    GooMenV.delegate = self;
    [myScrollView addSubview:GooMenV];
    
        
    
//    GooMenText = [[[UITextField alloc]initWithFrame:CGRectMake(35,180,250,30)] autorelease];
//    GooMenText.borderStyle = UITextBorderStyleRoundedRect;
//    GooMenText.backgroundColor = [UIColor clearColor];
//    GooMenText.returnKeyType = UIReturnKeyDefault;
//    
//    GooMenText.delegate = self;
//    [myScrollView addSubview:GooMenText];
    
    UIView* accessoryView =[[[UIView alloc] initWithFrame:CGRectMake(0,0,320,50)] autorelease];
    accessoryView.backgroundColor = [UIColor clearColor];
    
    // ボタンを作成する。
    UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    closeButton.frame = CGRectMake(210,10,100,30);
    [closeButton setTitle:@"閉じる" forState:UIControlStateNormal];
    // ボタンを押したときによばれる動作を設定する。
    [closeButton addTarget:self action:@selector(closeKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    // ボタンをViewに貼る
    [accessoryView addSubview:closeButton];
    GooMenV.inputAccessoryView = accessoryView;
    
    // キーボードが表示されたときのNotificationをうけとります。（後で）
    [self registerForKeyboardNotifications];

    //ロード。
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"MEMO"];
    [GooMenV setText:str];
    
    //modalmodalの生成。
    modal = [[ModalModal alloc] initWithStyle:UITableViewStylePlain];
    
    [self iAdMoveBannerView];//iAd
    [self admobView]; //admob
    
    nadView_ = [[NADView alloc] initWithFrame:CGRectMake(0,320,320,50)];
    [nadView_ setNendID:@"a6eca9dd074372c898dd1df549301f277c53f2b9" spotID:@"3172"];//ここのIDは後で変更。
    [nadView_ setDelegate:self];
    [nadView_ setRootViewController:self];
    [nadView_ load];
    [self.view addSubview:nadView_]; // 最初から表示する場合
    [nadView_ setDelegate:self];
    
}

//キーボード閉じ。
-(void)closeKeyboard:(id)sender{
    [GooMenV resignFirstResponder];
}

//キーボードが押されたときに呼ばれる。
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}
//キーボードのアニメーションアップ
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    CGPoint scrollPoint = CGPointMake(0.0,140.0);
    GooMenV.frame = CGRectMake(0, 161, 320, 190);
    [myScrollView setContentOffset:scrollPoint animated:YES];
}
//キーボードのアニメーションダウン
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    GooMenV.frame = CGRectMake(35,180,250,40);
    [myScrollView setContentOffset:CGPointZero animated:YES];
    
}


//-- バナービューの生成--//
-(void)iAdMoveBannerView{
    
    //iAd
    adView = [[ADBannerView alloc] initWithFrame:CGRectMake(0.0, 367.0, 320.0, 50.0)];
	adView.delegate = self;
    
    [self.view addSubview: adView];
    //-- バナービューの設定 その4:とりあえず最初は画面の外へ --//
	[self moveBannerViewOffscreen];
}
//-- バナービューの設定 自作機能1:バナーを画面の外へ追い出す機能 --//
- (void)moveBannerViewOffscreen{
    NSLog(@"1");
    CGRect newBannerView = self.view.frame;
	newBannerView.origin.y = self.view.frame.size.height;
	adView.frame = newBannerView;
}

//-- バナービューの設定 自作機能2:バナーを画面の中へ引っ張り入れる機能 --//
- (void)moveBannerViewOnscreen{
    NSLog(@"2");
    CGRect newBannerView = self.view.frame;
	newBannerView.origin.y = self.view.frame.size.height - adView.frame.size.height;
    
	//-- アニメーションで引っ張り入れる --//
	[UIView beginAnimations:@"BannerViewIntro" context:NULL];
	adView.frame = newBannerView;
	[UIView commitAnimations];
	
}

//-- バナービューの設定 デリゲート機能1:広告読み込みがエラーになったら反応する --//
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError * )error{
	//-- バナーを追い出す --//
	[self moveBannerViewOffscreen];
    //[self iAdDidFaildError];
}

//-- バナービューの設定 デリゲート機能2:広告読み込みが完了（成功）したら反応する --//
- (void)bannerViewDidLoadAd:(ADBannerView *)banner{
	//-- バナーを引っ張り入れる --//
    NSLog(@"3");
	[self moveBannerViewOnscreen];
}

//-- バナービューの設定 デリゲート機能3:ローテーションする直前に反応する --//
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{

}
//NAdのメソッド。
//iAd表示が失敗すればこちら呼び出し。
-(void)iAdDidFaildError{
    
    //NADView の作成
    //    nadView_ = [[NADView alloc] initWithFrame:CGRectMake(0,0,
    //                                                         NAD_ADVIEW_SIZE_320x50.width, NAD_ADVIEW_SIZE_320x50.height )];
//    nadView_ = [[NADView alloc] initWithFrame:CGRectMake(0,320,320,50)];
    
    nadView_ = [[NADView alloc] initWithFrame:CGRectMake(0,410,320,50)];
    [nadView_ setNendID:@"a6eca9dd074372c898dd1df549301f277c53f2b9" spotID:@"3172"];//ここのIDは後で変更。
    [nadView_ setDelegate:self];
    [nadView_ setRootViewController:self];
    [nadView_ load];
    [self.view addSubview:nadView_]; // 最初から表示する場合
    [nadView_ setDelegate:self];
}

- (void)load{
    [nadView_ load];
}
- (void)load:(NSDictionary *)parameter{
    // 例) 問い合わせエラー時には 60 分間隔で再問い合わせする
    [nadView_ load:[NSDictionary dictionaryWithObjectsAndKeys:@"3600", @"retry", nil]];
}
-(void)nadViewDidFinishLoad:(NADView *)adView {
    NSLog(@"delegate nadViewDidFinishLoad:");
}

 //admob
-(void)admobView{
   
    bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    bannerView_.frame = CGRectMake(0,367,320,50);
    bannerView_.adUnitID = MY_BANNER_UNIT_ID;
    bannerView_.rootViewController = self;
    
    [self.view addSubview:bannerView_];
    
    GADRequest *request = [GADRequest request];
    request.testing = YES;
    [bannerView_ loadRequest:request];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//保存ボタン
- (IBAction)gooSaveBtn:(UIButton *)sender {
    
    //セーブ
//    NSString *str = [GooMenText text];
//    userdefaults = [NSUserDefaults standardUserDefaults];
//    [userdefaults setObject:str forKey:@"MEMO"];
//    [userdefaults synchronize];
//
    [self keyboardWillBeHidden:nil];

    //時間。
    NSDate *nowdate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *datamoji = [formatter stringFromDate:nowdate];
    //保存。
//    NSArray *ary = [NSArray arrayWithObjects:GooMenV.text,datamoji,nil];
    userdefaults = [NSUserDefaults standardUserDefaults];
//    words = [NSMutableArray arrayWithObjects:GooMenText.text,datamoji, nil];
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:words];
    
//    [userdefaults setObject:ary forKey:@"words"];
//    [userdefaults synchronize];

    // 保存済みデータのロード
    NSArray *loadAry = [userdefaults objectForKey:@"words"];
    if ( !loadAry ) {
        loadAry = [NSArray array];
    }
    // データを追加できるように、 NSMutableArrayにする
    NSMutableArray *mAry = [NSMutableArray arrayWithArray:loadAry];
    // 先頭にデータを追加する
    [mAry insertObject:datamoji atIndex:0];
    [mAry insertObject:GooMenV.text atIndex:0];
    // 追加が終わったので保存する
    [userdefaults setObject:mAry forKey:@"words"];
    [userdefaults synchronize];
    
    
    NSLog(@"保存しました＝%@",userdefaults);
    

    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:@"お知らせ" message:@"保存しました"
                              delegate:self cancelButtonTitle:@"確認" otherButtonTitles:nil];
    [alert show];

}

- (IBAction)MoveView:(UIButton *)sender {
//    KNView *kn = [[KNView alloc]init];
//    [self presentViewController:kn animated:YES completion:nil];
//
    
    [GooMenV resignFirstResponder];
    

    // You have to retain the ownership of ViewController that you are presenting
    [self presentSemiViewController:modal withOptions:@{
     KNSemiModalOptionKeys.pushParentBack : @(NO),
     KNSemiModalOptionKeys.parentAlpha : @(0.8)
	 }];

}
- (IBAction)GooMemSarchBtn:(id)sender {
//    KNView2 *kn2 = [[KNView2 alloc]init];
//    [self presentViewController:kn2 animated:YES completion:nil];
//
    [self presentSemiViewController:modal2 withOptions:@{
     KNSemiModalOptionKeys.pushParentBack    : @(YES),
     KNSemiModalOptionKeys.animationDuration : @(1.0),
     KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
	 }];

}
- (void)dealloc {
    [GooMenV release];
   // [GooMenText release];
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (void)drawRect:(CGRect)rect
{
    /* 私はコンテキストがどーとか全然わかりません。。。 */
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    
    [super drawRect:rect];
}

- (IBAction)nsuBtn:(UIButton *)sender {
    NSUserdefaults *kn = [[NSUserdefaults alloc]init];
    [self presentViewController:kn animated:YES completion:nil];
    
    

}
@end
