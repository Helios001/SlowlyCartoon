//
//  MIneDetailViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "MIneDetailViewController.h"

#import "MineDetailTableViewCell.h"

#import "MineDetailHeadCell.h"
#define WinW [UIScreen mainScreen].bounds.size.width

#define WinH [UIScreen mainScreen].bounds.size.height
@interface MIneDetailViewController ()

<
    UITableViewDataSource,
    UITableViewDelegate
>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

//conten数组

@property (strong, nonatomic) NSArray * dataArray;

//详情数组

@property (strong, nonatomic) NSMutableArray * detailArray;

//更新个人信息详情
@property (strong, nonatomic) NSString * updateInfo;


//userInfoModel
@property(strong,nonatomic)PersonManager * personManager;
@end

@implementation MIneDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _tableView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    
    //    关闭滑动
    _tableView.scrollEnabled = NO;
    
//   初始化数据
    [self setUpDataArray];
    
//    初始化修改数据视图
    
  
//    注册
    
    [_tableView registerNib:[UINib nibWithNibName:@"MineDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MineDetailTableViewCell_Identify];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MineDetailHeadCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MineDetailHeadCell_Identify];
    
//    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuse"];
    
    //leftItem
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithTitle:@"<个人中心" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftItemAction:)];
    
    
    
    [leftItem setTitleTextAttributes:@{NSFontAttributeName:Font_24} forState:(UIControlStateNormal)];
    
    
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)leftItemAction:(UIBarButtonItem*)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
//初始化数据
- (void)setUpDataArray{
    _dataArray = @[@[@"头像"],@[@"账户",@"性别",@"出生年月",@"所在城市"],@[@"QQ",@"微信",@"微博",@"邮箱",@"手机"]];
    

    
    NSArray * array = [[CoreDataManager shareCoreDataManager] selectPersonManager];
    
    for (PersonManager* person1 in array) {
        
        if ([person1.userName isEqualToString:[[NSUserDefaults standardUserDefaults]valueForKey:@"userName"]]) {
            
            _personManager = person1;
        }
    }
    
    _detailArray = @[@[@""],@[@"",_personManager.gender,_personManager.bornYear,_personManager.cityName],@[_personManager.qqNumber,_personManager.weChatNumber,_personManager.weBoNumber,_personManager.mailboxNumber,_personManager.phoneNumber]].mutableCopy;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -     UITableViewDataSource,UITableViewDelegate

//返回每个分区头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ( section == 0) {
        return 5;
    }
    if (section == 1) {
        return 5;
    }
    return 10;
}
//返回cell高度
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.section == 0) {
        
        return 100;
    }
    return 50;
}
//返回分区数
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArray.count;
}

//返回每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_dataArray[section] count];
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//  第一分区
    if ( indexPath.section == 0) {
        
        MineDetailHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:MineDetailHeadCell_Identify];
    
        if (cell == nil) {
            
            cell = [[MineDetailHeadCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:MineDetailHeadCell_Identify];
            
        }
        NSString * userName = [[NSUserDefaults standardUserDefaults] valueForKey:@"userName"];
        
//        从数据库中获取 avator
     NSArray * array = [[CoreDataManager shareCoreDataManager] selectPersonManager];
        
        for (PersonManager * person1 in array) {
            
            if ([person1.userName isEqualToString:userName]) {
                
                _personManager = person1;
            }
        }
        
        if (_personManager.avator != nil) {
            
            cell.avatorImage.image = [UIImage imageWithData:_personManager.avator];
        }
    
        cell.contentLabel.text = _dataArray[indexPath.section][indexPath.row];
        
        return cell;
    }
// 其他分区
    MineDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:MineDetailTableViewCell_Identify];
    
    if (cell == nil) {
        
        cell = [[MineDetailTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:MineDetailTableViewCell_Identify];
    }
//    conment
    
    cell.comentLabel.text = _dataArray[indexPath.section][indexPath.row];
   
//    详细内容
    cell.detailLabel.text = _detailArray[indexPath.section][indexPath.row];
    
    NSString * userName = [[NSUserDefaults standardUserDefaults] valueForKey:@"userName"];
    
    if (indexPath.section == 1 && indexPath.row == 0 && userName.length != 0 ) {
        
       
        cell.detailLabel.text = userName;
        
    }
    
    return cell;
}

//tableViewcell点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    关闭tableViewcel点击状态
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
    
//拼接提示信息和placeholder
    
    NSString* message = [NSString stringWithFormat:@"修改%@",_dataArray[indexPath.section][indexPath.row]];
    
    NSString* placeholder = [NSString stringWithFormat:@"请输入您的%@",_dataArray[indexPath.section][indexPath.row]];
  
//    调用修改信息
    [self alertAddInfoViewWithMessage:message placeholder:placeholder indexPath:indexPath];

}
#pragma mark- 修改信息方法
- (void)alertAddInfoViewWithMessage:(NSString*)message placeholder:(NSString*)placeholder indexPath:(NSIndexPath*)indexPath{
    
//   调用之前 把updateInfo置为nil
    
    _updateInfo = nil;
    
    
    
    UILabel * appearanceLabel = [UILabel appearanceWhenContainedIn:UIAlertController.class, nil];
    
   
    
    appearanceLabel.font = Font_18;
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction* cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:@"提交" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        
//        调用updateBlcok 给updateInfo赋值
        self.updateBlcok();
        
//    调用数组数据处理的方法（如果输入信息不为空）
        if (_updateInfo.length != 0) {
            
            [self addInfoForCellByIndexPath:indexPath cellInfo:_updateInfo];
        }
        NSLog(@"updateInfo=============================%@",_updateInfo);
        
        [self dismissViewControllerAnimated:YES completion:^{

        }];

    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       
        textField.placeholder = placeholder;
        
        self.updateBlcok = ^{
            
            _updateInfo = textField.text;
        };
    }];
    
    [alertController addAction:cancleAction];
    
    [alertController addAction:confirmAction];
    
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
    
}
//添加信息视图
- (void)addInfoForCellByIndexPath:(NSIndexPath*)indexPath cellInfo:(NSString*)cellInfo{
    
//        这里的replace  因为是二维数组，临时数组必须被初始化  而不是指向二维数组中的数组
        
        NSMutableArray * tempArray = [NSMutableArray array];
        
//        遍历得到新的数组
        for (NSString* string in _detailArray[indexPath.section]) {
            
            [tempArray addObject:string];
        }
        
//        替换数组中数组的元素
        
        [tempArray replaceObjectAtIndex:indexPath.row withObject:cellInfo];
    
//        临时数组替换数组中的数组
        
        [_detailArray replaceObjectAtIndex:indexPath.section withObject:tempArray];
    
//    存入数据库
#pragma mark- 创建保存数据按钮
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveInfo)];
    
    [rightItem setTitleTextAttributes:@{NSFontAttributeName:Font_24} forState:(UIControlStateNormal)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
//    修改详情信息 数组  之后刷新Tableview
        [_tableView reloadData];
}
#pragma mark-  将修改的数据写入数据库
- (void)saveInfo{
    
//    _detailArray = @[@[@""],@[@"",_personManager.gender,_personManager.bornYear,_personManager.cityName],@[_personManager.qqNumber,_personManager.weChatNumber,_personManager.weBoNumber,_personManager.mailboxNumber,_personManager.phoneNumber]].mutableCopy;
//     _dataArray = @[@[@"头像"],@[@"账户",@"性别",@"出生年月",@"所在城市"],@[@"QQ",@"微信",@"微博",@"邮箱",@"手机"]];
    

    
    
    _personManager.gender = [[_detailArray objectAtIndex:1] objectAtIndex:1];
    _personManager.bornYear = _detailArray[1][2];
    _personManager.cityName = _detailArray[1][3];
    
    _personManager.qqNumber = _detailArray[2][0];
    _personManager.weChatNumber = _detailArray[2][1];
    _personManager.weBoNumber = _detailArray[2][2];
    _personManager.mailboxNumber = _detailArray[2][3];
    _personManager.phoneNumber = _detailArray[2][4];
    NSLog(@"---------------%@", _detailArray[1][1]);
    
//    [[CoreDataManager shareCoreDataManager] upDateWithPerson:person dbName:dataBaseName];
    
}
//

//- (void)commitUserInfo:(UIButton * ) sender{
//    
//    NSLog(@"===============%@",sender);
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
