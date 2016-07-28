//
//  ContactViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "ContactViewController.h"

#import "MineSettingTableViewCell.h"
@interface ContactViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate
>
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@property (strong, nonatomic) NSArray * dataArray;

@property (strong, nonatomic) NSArray * infoArray;
@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    关闭滑动
    _tableView.scrollEnabled = NO;
    
    //    关闭用户交互 这里只是展示
//    _tableView.userInteractionEnabled = NO;
    
    _tableView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    
    [self setUpDataArray];
    
    //注册cell
    [_tableView registerNib:[UINib nibWithNibName:@"MineSettingTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MineSettingTableViewCell_Identify];

    //leftItem
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithTitle:@"<个人中心" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftItemAction:)];
    
    
    
    [leftItem setTitleTextAttributes:@{NSFontAttributeName:Font_24} forState:(UIControlStateNormal)];
    
    
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)leftItemAction:(UIBarButtonItem*)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)setUpDataArray{
    _dataArray = @[@[@"漫漫用户QQ群",@"漫漫粉丝QQ群"],@[@"微博",@"微信公众号"]];
    
    _infoArray = @[@[@"203205793",@"203205793"],@[@"527956348@qq.com",@"Eternitydao"]];
}
#pragma mark- UITableViewDelegate,UITableViewDataSource

//每个section的高度
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//    return 10;
//}
//tableView中的section个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
//cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray[section] count];
}
//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineSettingTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:MineSettingTableViewCell_Identify];
    
    if (cell ==nil) {
        cell = [[MineSettingTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:MineSettingTableViewCell_Identify];
    }
    
    cell.contentLabel.text = _dataArray[indexPath.section][indexPath.row];
    cell.detailLbel.text = _infoArray[indexPath.section][indexPath.row];
    return cell;
}
//点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    关闭tableViewcel点击状态
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
   

    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                //         漫漫用户QQ群
                
//                NSLog(@"%ld====%ld",indexPath.section,indexPath.row);
                
                [self pasteInfoFromCellText:indexPath];
                
            }else{
                //          漫漫粉丝QQ群
//                NSLog(@"%ld====%ld",indexPath.section,indexPath.row);
                [self pasteInfoFromCellText:indexPath];
            }
            break;
        case 1:
            if (indexPath.row == 0) {
                //         微博
//                NSLog(@"%ld====%ld",indexPath.section,indexPath.row);
                [self pasteInfoFromCellText:indexPath];
            }else{
                //         微信公众号
//                NSLog(@"%ld====%ld",indexPath.section,indexPath.row);
                [self pasteInfoFromCellText:indexPath];
            }
            break;
        default:
            break;
    }
}

- (void)pasteInfoFromCellText:(NSIndexPath*)indexPath{
    
    NSString * text = _infoArray[indexPath.section][indexPath.row];
    
    NSString * name = _dataArray[indexPath.section][indexPath.row];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    
    pasteboard.string = text;
    
    [self showAlertWithTitle:@"" message:[NSString stringWithFormat:@"%@已经复制到剪切板",name] dalayTime:1.5];
}

#pragma mark 自动消失alertView

//初始化UIAlertView
- (void)showAlertWithTitle:(NSString*)title message:(NSString*)message dalayTime:(CGFloat)delayTime{
    
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    promptAlert.backgroundColor = [UIColor darkGrayColor];
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:delayTime
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:NO];
    
    [promptAlert show];
}

//UIAlertView 自动消失
- (void)timerFireMethod:(NSTimer*)theTimer
{
    
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    
    [promptAlert dismissWithClickedButtonIndex:0 animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- UITableViewDataSource,UITableViewDelegate

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
