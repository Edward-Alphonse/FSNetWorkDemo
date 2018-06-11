//
//  SubViewController.h
//  NSURLSessionDemo
//
//  Created by QITMAC000242 on 16/9/3.
//  Copyright © 2016年 QITMAC000242. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubViewController : UIViewController <UITabBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *myTableView;

@end
