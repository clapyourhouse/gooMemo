//
//  ViewController.h
//  gooMemo
//
//  Created by KitamuraShogo on 12/11/29.
//  Copyright (c) 2012年 KitamuraShogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemoVC.h"
#import "KNView.h"
#import "KNView2.h"
#import "ModalModal.h"
#import "modalmodal2.h"
#import <iAd/iAd.h>
#import "GADBannerView.h"
#import "NADView.h"
@class ModalModal;
@class modalmodal2;
@interface ViewController : UIViewController<UITextFieldDelegate,ADBannerViewDelegate,GADBannerViewDelegate,NADViewDelegate,UITextViewDelegate>{
    
    UITextField *GooMenText;
    UIScrollView *myScrollView;
    ModalModal *modal;
    modalmodal2 * modal2;
    NSUserDefaults *userdefaults;
    ADBannerView *adView;
    GADBannerView *bannerView_;
    NADView *nadView_;
    NSMutableArray *words;
    UITextView *GooMenV;
}

- (IBAction)nsuBtn:(UIButton *)sender;
- (void)insertNewObject:(id)sender;


@property(nonatomic,retain)NSMutableArray *words;
@property (nonatomic, assign) id <NADViewDelegate> delegate;

- (IBAction)gooSaveBtn:(UIButton *)sender;
- (IBAction)MoveView:(UIButton *)sender;
- (IBAction)GooMemSarchBtn:(id)sender;
//iAdバーナーのメソッド
-(void)iAdMoveBannerView;
-(void)moveBannerViewOnscreen;
-(void)moveBannerViewOffscreen;
-(void)iAdDidFaildError; //iAdの表示を1どれ失敗した場合呼ばれる。
//NadViewのメソッド
- (void)load;
- (void)load:(NSDictionary *)parameter;
- (void) nadViewDidFinishLoad:(NADView *)adView;
//admobのメソッド
-(void)admobView;

@end
