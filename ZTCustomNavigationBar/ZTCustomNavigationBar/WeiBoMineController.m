//
//  WeiBoMineController.m
//  ZTCustomNavigationBar
//
//  Created by 荣 li on 2017/7/24.
//  Copyright © 2017年 荣 li. All rights reserved.
//

#import "WeiBoMineController.h"
#import "ZTNavigationBar.h"
#import "AppDelegate.h"
#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT - NAV_HEIGHT*2)
#define IMAGE_HEIGHT 220
#define NAV_HEIGHT 64
@interface WeiBoMineController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *topView;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *fansLabel;
@property (nonatomic, strong) UILabel *detailsLabel;

@end

@implementation WeiBoMineController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.title = @"";
    [self.view addSubview:self.tableView];
    [self.topView addSubview:self.iconView];
    self.iconView.center = CGPointMake(self.topView.center.x, self.topView.center.y - 10);
    [self.topView addSubview:self.nameLabel];
    self.nameLabel.frame = CGRectMake(0, self.iconView.frame.size.height + self.iconView.frame.origin.y + 6, self.view.frame.size.width, 19);
    [self.topView addSubview:self.fansLabel];
    self.fansLabel.frame = CGRectMake(0, self.nameLabel.frame.origin.y + 19 + 5, self.view.frame.size.width, 16);
    [self.topView addSubview:self.detailsLabel];
    self.detailsLabel.frame = CGRectMake(0, self.fansLabel.frame.origin.y + 16 + 5, self.view.frame.size.width, 15);
    self.tableView.tableHeaderView = self.topView;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"··· " style:UIBarButtonItemStyleDone target:self action:nil];
    
    // 设置导航栏颜色
    [self zt_setNavBarBarTintColor:[UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0]];
    
    // 设置初始导航栏透明度
    [self zt_setNavBarBackgroundAlpha:0];
    
    // 设置导航栏按钮和标题颜色
    [self zt_setNavBarTintColor:[UIColor whiteColor]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_COLORCHANGE_POINT)
    {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
        [self zt_setNavBarBackgroundAlpha:alpha];
        [self zt_setNavBarTintColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self zt_setNavBarTitleColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self zt_setStatusBarStyle:UIStatusBarStyleDefault];
        self.title = @"荣li";
    }
    else
    {
        [self zt_setNavBarBackgroundAlpha:0];
        [self zt_setNavBarTintColor:[UIColor whiteColor]];
        [self zt_setNavBarTitleColor:[UIColor whiteColor]];
        [self zt_setStatusBarStyle:UIStatusBarStyleLightContent];
        self.title = @"";
    }
}


#pragma mark - tableview delegate / dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:nil];
    NSString *str = [NSString stringWithFormat:@"ZTNavigationBar %zd",indexPath.row];
    cell.textLabel.text = str;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = MainViewColor;
    NSString *str = [NSString stringWithFormat:@"ZTNavigationBar %zd",indexPath.row];
    vc.title = str;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getter / setter
- (UITableView *)tableView
{
    if (_tableView == nil) {
        CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _tableView = [[UITableView alloc] initWithFrame:frame
                                                  style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIImageView *)topView
{
    if (_topView == nil) {
        _topView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wbBG"]];
        _topView.frame = CGRectMake(0, 0, self.view.frame.size.width, IMAGE_HEIGHT);
    }
    return _topView;
}

- (UIImageView *)iconView
{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image5"]];
        _iconView.bounds = CGRectMake(0, 0, 80, 80);
        _iconView.layer.cornerRadius = 40;
        _iconView.layer.masksToBounds = YES;
    }
    return _iconView;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.text = @"荣li";
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:17];
    }
    return _nameLabel;
}

- (UILabel *)fansLabel
{
    if (_fansLabel == nil) {
        _fansLabel = [UILabel new];
        _fansLabel.backgroundColor = [UIColor clearColor];
        _fansLabel.textColor = [UIColor whiteColor];
        _fansLabel.text = @"关注 121  |  粉丝 17";
        _fansLabel.textAlignment = NSTextAlignmentCenter;
        _fansLabel.font = [UIFont systemFontOfSize:14];
    }
    return _fansLabel;
}

- (UILabel *)detailsLabel
{
    if (_detailsLabel == nil) {
        _detailsLabel = [UILabel new];
        _detailsLabel.backgroundColor = [UIColor clearColor];
        _detailsLabel.textColor = [UIColor whiteColor];
        _detailsLabel.text = @"简介:知想科技 iOS工程师";
        _detailsLabel.textAlignment = NSTextAlignmentCenter;
        _detailsLabel.font = [UIFont systemFontOfSize:13];
    }
    return _detailsLabel;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
