

#import "KSGuaidViewCell.h"

@implementation KSGuaidViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView = [[UIImageView alloc] init];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.userInteractionEnabled = YES;
        self.imageView.clipsToBounds = YES;
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
}

@end

NSString * const KSGuaidViewCellID = @"KSGuaidViewCellID";
