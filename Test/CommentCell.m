//
//  CommentCell.m
//  Test
//
//  Created by 方恒 on 2018/12/9.
//  Copyright © 2018年 Caichong. All rights reserved.
//

#import "CommentCell.h"
#import "Masonry.h"
#import "YYKit.h"

@interface CommentCell ()

@property (nonatomic, strong) YYLabel *commentLabel;

@end

@implementation CommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.commentLabel = [[YYLabel alloc] init];
    self.commentLabel.preferredMaxLayoutWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - 10;
    [self.contentView addSubview:self.commentLabel];
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).mas_offset(5);
        make.left.equalTo(self.contentView).mas_offset(5);
        make.right.equalTo(self.contentView).mas_offset(-5);
        make.bottom.equalTo(self.contentView).mas_offset(-5);
    }];
}

- (void)configDataWithModel:(CommentModel *)model {
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:model.comment];
    text.font = [UIFont systemFontOfSize:20];
    text.color = [UIColor purpleColor];
    
    self.commentLabel.attributedText = text;
    
    if (model.isShow) {
        self.commentLabel.numberOfLines = 0;
    } else {
        self.commentLabel.numberOfLines = 3;
    }
    
    __weak typeof(self) _self = self;
    NSMutableAttributedString *showMore = [[NSMutableAttributedString alloc] initWithString:@"...展开"];
    
    UIImage *image = [UIImage imageNamed:@"arrow"];
    image = [UIImage imageWithCGImage:image.CGImage scale:2 orientation:UIImageOrientationUp];
    NSMutableAttributedString *attachText = [NSMutableAttributedString attachmentStringWithContent:image contentMode:(UIViewContentModeCenter) attachmentSize:image.size alignToFont:self.commentLabel.font alignment:(YYTextVerticalAlignmentCenter)];
    [showMore appendAttributedString:attachText];
    
    YYTextHighlight *textHighlight = [[YYTextHighlight alloc] init];
    textHighlight.tapAction = ^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        NSLog(@"click show more : containerView: %@, text: %@", containerView, text);
        model.isShow = YES;
        if (_self.delegate && [_self.delegate respondsToSelector:@selector(commentCell:didClickShowMoreView:)]) {
            [_self.delegate commentCell:self didClickShowMoreView:containerView];
        }
    };
    
    NSRange range = [showMore.string rangeOfString:@"展开"];
    [showMore setColor:[UIColor redColor] range:range];
    [showMore setTextHighlight:textHighlight range:range];
    showMore.font = self.commentLabel.font;
    
    YYLabel *showMoreLabel = [[YYLabel alloc] init];
    showMoreLabel.attributedText = showMore;
    [showMoreLabel sizeToFit];
    
    NSAttributedString *truncationToken = [NSAttributedString attachmentStringWithContent:showMoreLabel contentMode:(UIViewContentModeCenter) attachmentSize:showMoreLabel.size alignToFont:showMore.font alignment:(YYTextVerticalAlignmentCenter)];
    self.commentLabel.truncationToken = truncationToken;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
