//
//  modalmodal2.m
//  gooMemo
//
//  Created by KitamuraShogo on 12/12/12.
//  Copyright (c) 2012年 KitamuraShogo. All rights reserved.
//

#import "modalmodal2.h"
#import "UIViewController+KNSemiModal.h"
#import <QuartzCore/QuartzCore.h>

@interface modalmodal2 ()

@end

@implementation modalmodal2
@synthesize helpLabel;
@synthesize dismissButton;
@synthesize resizeButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.frame = CGRectMake(0, 0, 320, 200);

        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dismissButton.layer.cornerRadius  = 10.0f;
    dismissButton.layer.masksToBounds = YES;
    resizeButton.layer.cornerRadius   = 10.0f;
    resizeButton.layer.masksToBounds  = YES;
    // Do any additional setup after loading the view from its nib.
}
- (void)viewDidUnload {
    [self setHelpLabel:nil];
    [self setDismissButton:nil];
    [self setResizeButton:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dissmissButtonDidTouch:(id)sender {
    UIViewController * parent = [self.view containingViewController];
    if ([parent respondsToSelector:@selector(dismissSemiModalView)]) {
        [parent dismissSemiModalView];
    }

}

- (IBAction)resizeSemiModalView:(id)sender {
    UIViewController * parent = [self.view containingViewController];
    if ([parent respondsToSelector:@selector(resizeSemiView:)]) {
//        [parent resizeSemiView:CGSizeMake(320, arc4random() % 280 + 180)];
        [parent resizeSemiView:CGSizeMake(320, 200)];
    }

}
@end
