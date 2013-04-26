//
//  AppDelegate.h
//  gooMemo
//
//  Created by KitamuraShogo on 12/11/29.
//  Copyright (c) 2012年 KitamuraShogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,retain)UINavigationController *rootViewcontroller;

@property (strong, nonatomic) ViewController *viewController;

@end
