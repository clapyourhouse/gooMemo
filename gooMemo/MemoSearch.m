//
//  MemoSearch.m
//  gooMemo
//
//  Created by KitamuraShogo on 12/11/29.
//  Copyright (c) 2012年 KitamuraShogo. All rights reserved.
//

#import "MemoSearch.h"

@implementation MemoSearch


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Products";
    // InterfaceBuilderを使わずに view を作成
    self.view = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view release];
    // InterfaceBuilderを使わずに tableView を作成
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1.0];
    self.tableView.separatorStyle = 3;
    [self.tableView release];
    
    
    // InterfaceBuilderを使わずに UISearchBar を追加
    //検索外観。
    UISearchBar *searchBar;
    searchBar = [[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44.0f)] autorelease];
    searchBar.showsCancelButton = YES;
    searchBar.tintColor = [UIColor whiteColor];
    searchBar.delegate = self;
    searchBar.placeholder = @"検索ワードを入力してください";
    searchBar.showsCancelButton = NO;
    [searchBar sizeToFit];
    self.tableView.tableHeaderView = searchBar;
    //検索する内容。
    UISearchDisplayController *searchDisplayController;
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchDisplayController.delegate = self;
    searchDisplayController.searchResultsDelegate = self;
    searchDisplayController.searchResultsDataSource = self;
    // 配列を生成
    _items = [[NSArray alloc] initWithObjects:@"iPhone", @"iPod", @"iPod touch", @"iMac", @"Mac Pro", @"iBook", @"MacBook", @"MacBook Pro", @"PowerBook", nil];
    _filteredListContent = [[NSMutableArray arrayWithCapacity:[_items count]] retain];
    [self.tableView reloadData];
    self.tableView.scrollEnabled = YES;
}

- (void)viewDidUnload {
    _filteredListContent = nil;
    [super viewDidUnload];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [_filteredListContent count];
    }
    return [_items count];
}
//タブの大きさ。範囲。
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSString *label;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        label = [_filteredListContent objectAtIndex:indexPath.row];
    } else {
        label = [_items objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = label;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *detailsViewController = [[UIViewController alloc] init];
    NSString *label;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        label = [_filteredListContent objectAtIndex:indexPath.row];
    } else {
        label = [_items objectAtIndex:indexPath.row];
    }
    detailsViewController.title = label;
    [[self navigationController] pushViewController:detailsViewController animated:YES];
    [detailsViewController release];
}

#pragma mark - Content Filtering

- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope {
    [_filteredListContent removeAllObjects];
    for (NSString *label in _items) {
        NSComparisonResult result = [label compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        if (result == NSOrderedSame) {
            [_filteredListContent addObject:label];
        }
    }
}

#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}


- (void)dealloc {
    [_items release];
    [_filteredListContent release];
    [super dealloc];
}




@end
