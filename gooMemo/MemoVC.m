//
//  MemoVC.m
//  gooMemo
//
//  Created by KitamuraShogo on 12/11/29.
//  Copyright (c) 2012年 KitamuraShogo. All rights reserved.
//

#import "MemoVC.h"
#import <QuartzCore/QuartzCore.h>

@interface MemoVC ()

@end

@implementation MemoVC
@synthesize primaryView,primaryShadeView,secondaryView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    secondaryView.frame = CGRectMake(0, primaryView.frame.size.height, secondaryView.frame.size.width, secondaryView.frame.size.height);
    secondaryView.hidden = false;
}


- (IBAction)MemoSearchBtn:(UIButton *)sender {
    
    {
        primaryView.userInteractionEnabled=NO;
        
        [UIView animateWithDuration:0.3 animations:^{
            secondaryView.frame = CGRectMake(0, primaryView.frame.size.height - secondaryView.frame.size.height, secondaryView.frame.size.width, secondaryView.frame.size.height);
            
//            CALayer *layer = primaryView.layer;
//            layer.zPosition = -4000;//z軸の移動距離
//            CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
//            rotationAndPerspectiveTransform.m34 = 1.0 / -300;
//            layer.transform = CATransform3DRotate(rotationAndPerspectiveTransform, 10.0f * M_PI / 180.0f, 1.0f, 0.0f, 0.0f);
//            primaryShadeView.alpha = 0.35;//アニメーション後の暗さ
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.3 animations:^{
//                primaryView.transform = CGAffineTransformMakeScale(0.9, 0.9);
//                primaryShadeView.alpha = 0.5; //アニメーション後の暗さ
//            }];
        }];
    }

    
    //透明
//    MemoSearch *memoSea = [[MemoSearch alloc]init];
//    memoSea.view.backgroundColor = [UIColor clearColor];
//    self.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
//    memoSea.modalTransitionStyle = UIModalPresentationFormSheet;
//    [self presentViewController:memoSea animated:YES completion:nil];
//    //ただのモーダル
//   MemoSearch *memoSea = [[MemoSearch alloc]init];
//    memoSea.modalTransitionStyle = UIModalPresentationCurrentContext;
//    [self presentViewController:memoSea animated:YES completion:nil];
   
}
@end
