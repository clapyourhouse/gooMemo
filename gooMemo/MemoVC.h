//
//  MemoVC.h
//  gooMemo
//
//  Created by KitamuraShogo on 12/11/29.
//  Copyright (c) 2012年 KitamuraShogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemoSearch.h"
#import "ViewController.h"

@interface MemoVC : UIViewController

@property (retain, nonatomic)  UIView *primaryView;
@property (retain, nonatomic)  UIView *secondaryView;
@property (retain, nonatomic)  UIView *primaryShadeView;


- (IBAction)MemoSearchBtn:(UIButton *)sender;

@end
