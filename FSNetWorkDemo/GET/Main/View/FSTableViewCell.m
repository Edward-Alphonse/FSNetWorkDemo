//
//  FSTableViewCell.m
//  FSNetWork
//
//  Created by zhichang.he on 2018/6/3.
//  Copyright © 2018年 zhichang.he. All rights reserved.
//

#import "FSTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#import "FSWebImage.h"
#import "UIView+FSExtension.h"
#import "FSVideoView.h"

@interface FSTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *LogoView;
@property (weak, nonatomic) IBOutlet UILabel *LogoLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) FSVideoView *videoView;
@property (nonatomic, strong) FSGetCellModel *model;
@end

@implementation FSTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _videoView = [[FSVideoView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_videoView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupWithModel:(FSGetCellModel *)model {
    _model = model;
    [self layoutCell];
}

- (void)layoutCell {
    _LogoLabel.text = _model.logoTitle;
    [[FSWebImage manager] getImageOfHttpsURL: _model.logoURL completionHandler:^(UIImage *image) {
        _LogoView.image = image;
    }];
    _titleLabel.text = _model.topicTitle;
    _titleLabel.numberOfLines = 2;
    _titleLabel.width = self.width - 30;
    [_titleLabel sizeToFit];
//    [[FSWebImage manager] getImageOfHttpsURL:_model.videoImageURL completionHandler:^(UIImage *image) {
//        _videoView.image = image;
//    }];
    _videoView.frame = CGRectMake(15, CGRectGetMaxY(_titleLabel.frame), CGRectGetWidth(self.frame) - 30, CGRectGetHeight(self.frame) - CGRectGetMaxY(_titleLabel.frame) - 10);
    [_videoView playWithImagePath:_model.videoImageURL videoPath:_model.videoPath];
//    NSString *filePath = _model.videoPath;
//    NSURL *url = [NSURL URLWithString:filePath];
//    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:url];
//    AVPlayer *player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
//    AVPlayer *player = [[AVPlayer alloc] initWithURL:url];
//    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
//    playerLayer.frame = _videoView.frame;
//    
//    [self.layer addSublayer:playerLayer];
//    [player play];
}



@end
