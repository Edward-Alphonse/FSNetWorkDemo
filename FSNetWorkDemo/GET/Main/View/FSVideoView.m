//
//  FSVideoView.m
//  FSNetWorkDemo
//
//  Created by zhichang.he on 2018/6/9.
//  Copyright © 2018年 zhichang.he. All rights reserved.
//

#import "FSVideoView.h"
#import <AVFoundation/AVFoundation.h>
#import "FSWebImage.h"
#import "FSCommonDefine.h"

@interface FSVideoView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *playIcon;
@property (nonatomic, assign) BOOL isPlay;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, copy) NSString *videoPath;
@end

@implementation FSVideoView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_imageView];
//        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        _playIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"play"]];
        [_playIcon setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_playIcon];
        _isPlay = false;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickButton:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)playWithImagePath:(NSString *)imagePath videoPath:(NSString *)videoPath {
    [[FSWebImage manager] getImageOfHttpsURL:imagePath completionHandler:^(UIImage *image) {
        _imageView.image = image;
    }];
    
    if(isStringEmpey(videoPath)) {
        return ;
    }
    _videoPath = videoPath;
}

- (void)layoutSubviews {
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    _imageView.frame = CGRectMake(0, 0, width, height);
    _playIcon.frame = CGRectMake(0, 0, 40, 40);
    _playIcon.layer.cornerRadius = 40 / 2;
    _playIcon.center = CGPointMake(width/2, height/2);
}

#pragma mark: lazy load
- (AVPlayerLayer *)playerLayer {
    if(!_playerLayer) {
        NSURL *url = [NSURL URLWithString:_videoPath];
        AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
        AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
        _playerLayer = [[AVPlayerLayer alloc] init];
        _playerLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        _playerLayer.player = player;
    }
    return _playerLayer;
}

#pragma mark: 事件
- (void)clickButton:(id)sender {
    if(!_isPlay) {
        [self play];
    } else {
        [self pause];
    }
}

- (void)play {
    _isPlay = true;
    _playIcon.hidden = _isPlay;
    _imageView.hidden = _isPlay;
    //TODO: 会出现两张图重叠出现
//    _imageView.image = [UIImage imageNamed:@"pause"];
    [self.layer addSublayer:self.playerLayer];
    [self.playerLayer.player play];
}

- (void)pause {
    _isPlay = false;
    _imageView.hidden = _isPlay;
    _playIcon.hidden = _isPlay;
    [self.playerLayer.player pause];
    [self.playerLayer removeFromSuperlayer];
}

#pragma mark: Class Method
+ (instancetype)playWithImagePath:(NSString *)imagePath videoPath:(NSString *)videoPath {
    FSVideoView *videoView = [[FSVideoView alloc] init];
    [videoView playWithImagePath:imagePath videoPath:videoPath];
    return videoView;
}

@end
