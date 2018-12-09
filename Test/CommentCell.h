//
//  CommentCell.h
//  Test
//
//  Created by 方恒 on 2018/12/9.
//  Copyright © 2018年 Caichong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"
NS_ASSUME_NONNULL_BEGIN

@class CommentCell;

@protocol CommentCellDelegate <NSObject>

- (void)commentCell:(CommentCell *)cell didClickShowMoreView:(UIView *)view;

@end

@interface CommentCell : UITableViewCell

@property (nonatomic, weak) id<CommentCellDelegate> delegate;

- (void)configDataWithModel:(CommentModel *)model;

@end

NS_ASSUME_NONNULL_END
