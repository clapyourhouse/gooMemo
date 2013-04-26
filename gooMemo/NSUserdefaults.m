//
//  NSUserdefaults.m
//  gooMemo
//
//  Created by KitamuraShogo on 12/12/28.
//  Copyright (c) 2012年 KitamuraShogo. All rights reserved.
//

#import "NSUserdefaults.h"

@interface NSUserdefaults ()

@end

@implementation NSUserdefaults
@synthesize customButton1;
@synthesize categoryTableView;
@synthesize picker;
@synthesize donebtn;
@synthesize doneview;
@synthesize sakujyobtn;
@synthesize contents;


- (void)viewDidLoad {
    [super viewDidLoad];
  // self.view.backgroundColor = [UIColor blueColor];
    //-- カスタムボタンの設定 その1 --//
    self.customButton1 = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
    self.customButton1.frame = CGRectMake(0,0, 30.0, 30.0);
    [self.customButton1 setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [self.customButton1 addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:self.customButton1 atIndex:2];
    
    //arrayforkeyで保存されているファイルを呼び出す
    NSUserDefaults *_userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *array;
    array = [_userDefaults arrayForKey:@"datacontent"];
    if (array) {
        //ファイルがあった場合は、contentsにかき出す
        contents =  [array mutableCopy];
    } else {
        //ファイルがなかったら、arrayforkeyでファイルを作成、保存する
        contents = [[NSMutableArray alloc] initWithObjects:@"aa",@"a", @"b", @"c", nil];
        NSArray *array = contents;
        [_userDefaults setObject:array forKey:@"datacontent"];
        [_userDefaults synchronize];
    }
    
    
    activities = [[NSMutableArray alloc] initWithObjects:
                  @"11111",
                  @"222222",
                  @"33333",
                  @"4444",
                  nil];
    sakujyobtn.title = @"削除";
}

//テーブルのセルの行を決定
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [contents count];
}
//テーブルに表示する内容を決定する
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //同じ形式のセルを使うため、そのセルを再利用する
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (cell == nil) {
        
        //基本となるセルがまだ出来てなかったらセルを作成する
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"identifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell autorelease];
    }
    
    //indexpathに表示するテキストを決定する
    if (indexPath.row < [contents count]) {
        cell.textLabel.text = [contents objectAtIndex:indexPath.row];
    }
    return cell;
}

//セル選択時のアクションを設定
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // NSString* message = [contents objectAtIndex:indexPath.row];
    NSString *message = [contents objectAtIndex:indexPath.row];
    if (message == @"aaaaaa") {
        NSURL *url = [NSURL URLWithString:@"https://www.facebook.com/sharer/sharer.php?u=http://douwashindan3310.appspot.com/kekka12.html"];
        [[UIApplication sharedApplication] openURL:url];
    } else {
        NSURL *url = [NSURL URLWithString:@"http://www.atmarkit.co.jp/fcoding/articles/objc/05/objc05b.html"];
        [[UIApplication sharedApplication] openURL:url];
    }
    
    
}

//セルを本当に削除する
-(void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        //データソースからデータを削除
        [contents removeObjectAtIndex:indexPath.row];
        //テーブルから該当セルを削除
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
        
        //データを読み込んで削除=========================
        NSUserDefaults *_userDefaults = [NSUserDefaults standardUserDefaults];
        NSArray *arr;
        arr = [_userDefaults arrayForKey:@"datacontent"]; //読み込み
        arr = contents;
        [_userDefaults setObject:arr forKey:@"datacontent"];
        [_userDefaults synchronize];
        //データを読み込んで削除=========================
        
    } else if (UITableViewCellEditingStyleInsert == editingStyle) {
        //データソースに１件追加
        [contents insertObject:@"new item" atIndex:(contents.count - 1)];
        //テーブルにセルを追加
        [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationTop];
    }
}
-(IBAction)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    // 編集モードにする
    if(self.categoryTableView.editing == NO) {
        [self.categoryTableView setEditing:YES animated:YES];
        sakujyobtn.title = @"完了";
    } else if(self.categoryTableView.editing == YES)  {
        [self.categoryTableView setEditing:NO animated:YES];
        sakujyobtn.title = @"削除";
    }
    [super setEditing:editing animated:YES];
}

-(UITableViewCellEditingStyle)tableView:(UITableView*)tableView
          editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

//-- アクションの設定 --------------------------------//
// 戻るボタンが押された時のアクションを設定します。
//-------------------------------------------------//
- (void)action:(id)sender
{
    //表示していたビューを消す
    [self dismissModalViewControllerAnimated:YES];
}

//-- アクションの設定 --------------------------------//
// 追加ボタンが押された時のアクションを設定します。
//-------------------------------------------------//
-(IBAction)setEditingadd:(BOOL)editing animated:(BOOL)animated {
    picker = [[[UIPickerView alloc] initWithFrame:CGRectMake(0,265,320,200)] autorelease];
    picker.delegate = self;
    picker.dataSource = self;
    [self.view addSubview:picker];
    doneview = [[[UIView alloc]initWithFrame:CGRectMake(0,225,320,40)] autorelease];
    doneview.backgroundColor = [UIColor blackColor];
    doneview.alpha = 0.5;
    [self.view addSubview:doneview];
    donebtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    donebtn.frame = CGRectMake(230, 232, 80, 30);
    [donebtn setTitle:@"完了" forState:UIControlStateNormal];
    [donebtn addTarget:self
                action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:donebtn];
}


//列数の設定（設定する列の数をreturnで返す）
- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

//！！行も列も番号は0から始まるので注意
//列（componentの値で渡される）に対する、行数の設定（設定する行の数をreturnで返す）
- (NSInteger) pickerView: (UIPickerView*)pView
 numberOfRowsInComponent:(NSInteger) component {
        return [activities count];
}


//列（componentの値）、行（rowの値）に対する表示するものを設定
- (NSString*)pickerView: (UIPickerView*)pView
            titleForRow:(NSInteger) row forComponent:(NSInteger)component {
    return [activities objectAtIndex:row];
}
// 呼ばれるdoneメソッド
-(void)done:(UIButton*)button{
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:contents.count inSection:0];
    /*NSInteger component = [picker selectedRowInComponent:0];
     NSString* datatitle = [NSString stringWithFormat:@"%d",component];*/
    //NSString *activity = [contents objectAtIndex: [picker selectedRowInComponent:0]];
    NSString *activity = [activities objectAtIndex: [picker selectedRowInComponent:0]];
    NSString *message = [[NSString alloc] initWithFormat: @"%@", activity];
    [contents addObject:message];
    
    //読み込んで追加=========================
    NSUserDefaults *_userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *arr;
    NSMutableArray *mArr;
    arr = [_userDefaults arrayForKey:@"datacontent"]; //読み込み
    mArr = [NSMutableArray arrayWithArray:arr];
    [mArr addObject:message];
    arr = mArr;
    [_userDefaults setObject:arr forKey:@"datacontent"];
    [_userDefaults synchronize];
    //読み込んで追加=========================
    
    //[contents addObject:datatitle];
    [self.categoryTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                  withRowAnimation:UITableViewRowAnimationTop];
    // ここに何かの処理を記述する
    // （引数の button には呼び出し元のUIButtonオブジェクトが引き渡されてきます）
    self.picker.hidden = YES;
    self.donebtn.hidden = YES;
    self.doneview.hidden = YES;
}

- (void)dealloc {
    [super dealloc];
    [contents release];
}


@end
