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
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, assign) BOOL isPlay;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@end

@implementation FSVideoView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_imageView];
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [_playButton setTintColor:[UIColor redColor]];
        [self addSubview:_playButton];
        _isPlay = false;
        _playerLayer = [[AVPlayerLayer alloc] init];

        
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
    NSURL *url = [NSURL URLWithString:videoPath];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    _playerLayer.player = player;
}

- (void)layoutSubviews {
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    _imageView.frame = CGRectMake(0, 0, width, height);
    _playerLayer.frame = CGRectMake(0, 0, width, height);
    _playButton.frame = CGRectMake(0, 0, 40, 40);
    _playButton.center = CGPointMake(width/2, height/2);
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
    _playButton.hidden = _isPlay;
    _imageView.hidden = _isPlay;
    [self.layer addSublayer:_playerLayer];
    [_playerLayer.player play];
}

- (void)pause {
    _isPlay = false;
    _imageView.hidden = _isPlay;
    _playButton.hidden = _isPlay;
    [_playerLayer.player pause];
    [_playerLayer removeFromSuperlayer];
}

#pragma mark: Class Method
+ (instancetype)playWithImagePath:(NSString *)imagePath videoPath:(NSString *)videoPath {
    FSVideoView *videoView = [[FSVideoView alloc] init];
    [videoView playWithImagePath:imagePath videoPath:videoPath];
    return videoView;
}

@end
