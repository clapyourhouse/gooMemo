//
//  ModalModal.h
//  gooMemo
//
//  Created by KitamuraShogo on 12/12/12.
//  Copyright (c) 2012年 KitamuraShogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface ModalModal : UITableViewController<UISearchBarDelegate,UISearchDisplayDelegate>{
    
    NSArray *originalData;
    NSMutableArray *searchData;
    UITableView *myTableView;

}


@property (nonatomic, retain) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) NSMutableArray *searchData;

@end

