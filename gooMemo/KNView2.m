//
//  KNView2.m
//  gooMemo
//
//  Created by KitamuraShogo on 12/12/12.
//  Copyright (c) 2012年 KitamuraShogo. All rights reserved.
//

#import "KNView2.h"
#import "modalmodal2.h"
#import "UIViewController+KNSemiModal.h"

@interface KNView2 ()

@end

@implementation KNView2

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

- (IBAction)buttonDidTouch:(id)sender {
    
    // You can also present a UIViewController with complex views in it
    // and optionally containing an explicit dismiss button for semi modal
    [self presentSemiViewController:modal2 withOptions:@{
     KNSemiModalOptionKeys.pushParentBack    : @(YES),
     KNSemiModalOptionKeys.animationDuration : @(2.0),
     KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
	 }];

}

#pragma mark - Optional notifications

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

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

@end
