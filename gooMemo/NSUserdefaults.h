//
//  NSUserdefaults.h
//  gooMemo
//
//  Created by KitamuraShogo on 12/12/28.
//  Copyright (c) 2012年 KitamuraShogo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSUserdefaults : UITableViewController<UIPickerViewDelegate,UIPickerViewDataSource>{
    
    UIButton *customButton1;
    NSMutableArray *activities;
    
}
@property (nonatomic,retain) UIButton *customButton1;

@property (nonatomic,retain) UITableView *categoryTableView;
@property (nonatomic,retain) UIButton *donebtn;
@property (nonatomic,retain) UIView *doneview;
@property (nonatomic,retain) UIPickerView *picker;
@property (nonatomic,retain) UIBarButtonItem *sakujyobtn;
@property (nonatomic,retain) NSMutableArray *contents;

-(IBAction)setEditingadd:(BOOL)editing animated:(BOOL)animated;

@end
