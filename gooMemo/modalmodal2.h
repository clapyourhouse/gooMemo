//
//  modalmodal2.h
//  gooMemo
//
//  Created by KitamuraShogo on 12/12/12.
//  Copyright (c) 2012年 KitamuraShogo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface modalmodal2 : UIViewController
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *helpLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *dismissButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *resizeButton;

- (IBAction)dissmissButtonDidTouch:(id)sender;
- (IBAction)resizeSemiModalView:(id)sender;

@end
