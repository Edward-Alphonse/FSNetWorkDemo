//
//  ListTableViewCell.m
//  CySessionDemo
//
//  Created by QITMAC000242 on 16/9/12.
//  Copyright © 2016年 QITMAC000242. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        _downloadBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_downloadBtn setTitle:@"下载" forState:UIControlStateNormal];
        [_downloadBtn setTitle:@"暂停" forState:UIControlStateSelected];
        [_downloadBtn addTarget:self action:@selector(clickDownloadBtn:) forControlEvents:UIControlEventTouchUpInside];

        
        [self addSubview:_downloadBtn];
        
        _titleLbl = [[UILabel alloc]init];
        [self addSubview:_titleLbl];
        
        _downloadProgressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleBar];
        _downloadProgressView.progress = 10.f;
        _downloadProgressView.hidden = NO;
        [self addSubview:_downloadProgressView];
        
        _progressLbl = [[UILabel alloc]init];
        _progressLbl.text = @"请开始下载任务";
        [self addSubview:_progressLbl];
        
        _speedLbl = [[UILabel alloc]init];
        [self addSubview:_speedLbl];
    }
    return self;
}

- (void)clickDownloadBtn:(id)sender
{
    if(_downloadCallBack)
    {
        _downloadCallBack(sender);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
