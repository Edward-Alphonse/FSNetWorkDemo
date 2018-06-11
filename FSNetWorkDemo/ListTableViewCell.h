//
//  ListTableViewCell.h
//  CySessionDemo
//
//  Created by QITMAC000242 on 16/9/12.
//  Copyright © 2016年 QITMAC000242. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewCell : UITableViewCell

#pragma mark - 界面布局元素
@property (nonatomic, strong) UILabel *titleLbl;
@property (nonatomic, strong) UIProgressView *downloadProgressView;
@property (nonatomic, strong) UILabel *progressLbl;
@property (nonatomic, strong) UILabel *speedLbl;
@property (nonatomic, strong) UIButton *downloadBtn;

#pragma mark - 功能元素
@property (nonatomic, copy) void(^downloadCallBack)(UIButton *btn);
@property (nonatomic, strong) NSURLSessionDownloadTask *task;

@end
