
#import "UIImageView+Util.h"

#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (Util)

- (void)loadImageWithImageUrl:(NSURL *)imgUrl
{
    [self sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"default-portrait"] options:0];
}

@end
