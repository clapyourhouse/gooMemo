//
//  MemoSearch.h
//  gooMemo
//
//  Created by KitamuraShogo on 12/11/29.
//  Copyright (c) 2012年 KitamuraShogo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemoSearch : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate> {
    NSArray *_items;
    NSMutableArray *_filteredListContent;
}
@end