//
//  ModalModal.m
//  gooMemo
//
//  Created by KitamuraShogo on 12/12/12.
//  Copyright (c) 2012年 KitamuraShogo. All rights reserved.
//

#import "ModalModal.h"


@interface ModalModal (){
    
    NSMutableArray *mutable;
}

@end

@implementation ModalModal
@synthesize searchData;
@synthesize myTableView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.view.frame = CGRectMake(0, 0, 320, 290);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //検索外観。
    
    UISearchBar *searchBar;
    searchBar = [[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 40, 44.0f)] autorelease];
    searchBar.showsCancelButton = YES;
    searchBar.barStyle = UIBarStyleBlackTranslucent;
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
//    
//    NSUserDefaults *load = [NSUserDefaults standardUserDefaults];
//    originalData = [load arrayForKey:@"words"];
//    searchData = [NSMutableArray arrayWithObject:originalData];
//    
//    //起動時にロード。
//    NSUserDefaults *load = [NSUserDefaults standardUserDefaults];
//    originalData = [load arrayForKey:@"MEMO"];
//    for ( NSString* object in originalData ) {
//        searchData = [[NSMutableArray arrayWithCapacity: originalData.count] retain];
//    }
//    
    

    //今一個しか残せないし、ViewDidLoadだから再起動しなきゃ更新されない。
   // originalData = [[NSArray alloc] initWithObjects:array,nil];
   // searchData = [[NSMutableArray arrayWithCapacity: originalData.count] retain];


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

//各セクションのセルの数。
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == self.searchDisplayController.searchResultsTableView) {
        return searchData.count / 2;
    }
    
    return originalData.count / 2;
}



//セルの大きさ
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
      return 100.0;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
    }
        
//        NSUserDefaults *load = [NSUserDefaults standardUserDefaults];
//        //    NSData *data = [load objectForKey:@"words"];
//        
//        originalData = [load arrayForKey:@"words"];
//        searchData = [[NSMutableArray arrayWithCapacity: originalData.count] retain];
        
        
//    
//        
//        if (indexPath.row < [searchData count]) {
//            cell.textLabel.text = [searchData objectAtIndex:indexPath.row];
//        }
//    }
   
               
//        [self viewWillAppear:YES];
//        //一度Nsstringで読み込んで表示。その後に、ミュータブルに格納して検索にかける。
//        
//        searchData = [[[NSUserDefaults standardUserDefaults] objectForKey:@"words"] mutableCopy];
//        [searchData insertObject:originalData atIndex:0];
//        
//        cell.textLabel.text = searchData;
//        cell.detailTextLabel.text = searchData;
////        cell.textLabel.text = [load stringForKey:@"words"];
//        cell.detailTextLabel.text = [load stringForKey:@"words"];
//        
//        NSUserDefaults *_userDefaults = [NSUserDefaults standardUserDefaults];
//        originalData = [_userDefaults arrayForKey:@"words"];
//        if (originalData) {
//            //ファイルがあった場合は、contentsにかき出す
//            searchData =  [originalData mutableCopy];
//        } else {
//            //ファイルがなかったら、arrayforkeyでファイルを作成、保存する
//            searchData = [[NSMutableArray alloc] initWithObjects:@"aa",@"a", @"b", @"c", nil];
//            originalData = searchData;
//            [_userDefaults setObject:originalData forKey:@"words"];
//            [_userDefaults synchronize];
//        }
//        

//       if(indexPath.section == 0) {
//            if(indexPath.row == 0) {
//                cell.textLabel.text =  [load stringForKey:@"words"];
//            } else if(indexPath.row == 1){
//                cell.textLabel.text = [load stringForKey:@"words"];
//            } else {
//                cell.textLabel.text = @"セクション0 行2";
//            }
//        }
////        
//    }
//   //あくまでこれは検索を行うものだが、ここの値が反映されている。
   
        
    if(tableView == self.searchDisplayController.searchResultsTableView){
        cell.textLabel.text = [searchData objectAtIndex:indexPath.row * 2];
        cell.detailTextLabel.text = [searchData objectAtIndex:indexPath.row * 2 + 1];
    }else{
        cell.textLabel.text = [originalData objectAtIndex:indexPath.row * 2];
        cell.detailTextLabel.text = [originalData objectAtIndex:indexPath.row * 2 + 1];
        
    }
    
    if (indexPath.row * 2 < [searchData count]) {
        cell.textLabel.text = [searchData objectAtIndex:indexPath.row * 2];
        cell.detailTextLabel.text = [searchData objectAtIndex:indexPath.row * 2 + 1];
    }
    
    return cell;
}



//大小、曖昧な検索。
- (void)filterContentForSearchText:(NSString*)searchString scope:(NSString*)scope {
    [searchData removeAllObjects];
    
    for(NSString *label in originalData) {
        NSRange range = [label rangeOfString:searchString
                                     options:NSCaseInsensitiveSearch];
        if(range.length > 0)
            [searchData addObject:label];
    }
}

- (BOOL)searchDisplayController:(UISearchDisplayController*)controller shouldReloadTableForSearchString:(NSString*)searchString {
    [self filterContentForSearchText: searchString
                               scope: [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

////削除ボタンを出す。消すはエラー。
//-(void)tableView:(UITableView *)tableView
//commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
//forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (UITableViewCellEditingStyleDelete == editingStyle) {
//        //データソースからデータを削除
//        [searchData removeObjectAtIndex:indexPath.row];
//        //テーブルから該当セルを削除
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
//                         withRowAnimation:UITableViewRowAnimationFade];
//    }
//}
//

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [myTableView setEditing:editing animated:YES];
    if (editing) { // 現在編集モードです。
        UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                    target:self action:@selector(addRow:)] autorelease];
        [self.navigationItem setLeftBarButtonItem:addButton animated:YES]; // 追加ボタンを表示します。
    } else { // 現在通常モードです。
        [self.navigationItem setLeftBarButtonItem:nil animated:YES]; // 追加ボタンを非表示にします。
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            [searchData removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        } else if (editingStyle == UITableViewCellEditingStyleInsert) {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}// 行はすべて編集可能にする
-(BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath
{
    return YES;
}

//何か次の動きがあったとき。
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    
//    NSUserDefaults *load = [NSUserDefaults standardUserDefaults];
//    mutable = [NSMutableArray arrayWithObject:load];
//    
//    originalData = [load arrayForKey:@"words"];
//    
//    searchData = [[NSMutableArray arrayWithCapacity: originalData.count] retain];
//    
//    
    
    
    NSUserDefaults *_userDefaults = [NSUserDefaults standardUserDefaults];
    originalData = [_userDefaults arrayForKey:@"words"];
    searchData =  [originalData mutableCopy];
    [searchData count];
    NSLog(@"results = %@",searchData);

    

//    //   //あくまでこれは検索を行うものだが、ここの値が反映されている。
//    NSUserDefaults *load = [NSUserDefaults standardUserDefaults];
//    originalData = [load arrayForKey:@"words"];
//    searchData = [[NSMutableArray arrayWithCapacity:originalData.count]retain];
//    [searchData count];
//    NSLog(@"results = %@",searchData);
//
    
//    
//    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:searchData.count inSection:0];
//    NSArray *indexPaths = [NSArray arrayWithObjects:indexPath,nil];
//    [searchData addObject:[NSString stringWithFormat:@"追加された行その%d",addCount]];
//    addCount++; // 次に使うとき用にaddCountに1足しています。
//    [tableView_ insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
//    
//    


    // ロード
////    NSUserDefaults *load = [NSUserDefaults standardUserDefaults];
//    NSMutableArray *str = [load objectForKey:@"words"];
//    
//    // 表示内容更新
//    NSMutableArray *ary = [NSMutableArray arrayWithArray:originalData];
//    [ary addObject:str];
//    [originalData release];
//    originalData = [[NSArray alloc] initWithArray:ary];
//    
//    [searchData release];
//    searchData = [[NSMutableArray arrayWithCapacity: originalData.count] retain];
////    
//    // 実際の表示更新
    [self.tableView reloadData];
}

-(void)dealloc{
    [super dealloc];
    [myTableView release];
    [searchData release];
}
@end
