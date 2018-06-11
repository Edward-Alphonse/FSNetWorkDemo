//
//  FSTableViewCell.h
//  FSNetWork
//
//  Created by zhichang.he on 2018/6/3.
//  Copyright © 2018年 zhichang.he. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSGetCellModel.h"

@interface FSTableViewCell : UITableViewCell

- (void)setupWithModel:(FSGetCellModel *)model;

@end
