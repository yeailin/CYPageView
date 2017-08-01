//
//  ViewController.m
//  CYPageView
//
//  Created by aaa on 2017/7/5.
//  Copyright © 2017年 caoye. All rights reserved.
//

#import "ViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"CYPageView";
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const ID = @"CYTableViewID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"左右切换页面";
    } else {
        cell.textLabel.text = @"表情键盘";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        OneViewController *one = [[OneViewController alloc] init];
        [self.navigationController pushViewController:one animated:true];
    } else {
        TwoViewController *two = [[TwoViewController alloc] init];
        [self.navigationController pushViewController:two animated:true];
    }
}

@end
