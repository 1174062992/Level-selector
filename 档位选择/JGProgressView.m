//
//  JGProgressView.m
//  JGProgressDemo
//  2017-12-30  曹记
//

#import "JGProgressView.h"

#define KProgressPadding 5.0f
#define KProgressLineWidth 3.0f



@implementation JGProgressView



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

    }
    
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    CGFloat maxWidth = self.bounds.size.width;
    CGFloat heigth = self.bounds.size.height-10;
    int Count = maxWidth / (KProgressPadding + KProgressLineWidth);
    int LCount = maxWidth * progress / (KProgressPadding + KProgressLineWidth);
    for (int i = 0 ; i < Count; i++) {
        CGFloat X = i * (KProgressLineWidth + KProgressPadding);
        UIView *Line = [[UIView alloc] initWithFrame:CGRectMake(X, 5, KProgressLineWidth, heigth)];
                if (i<LCount&&i==LCount-1) {
                    Line.frame =CGRectMake(X, 0, KProgressLineWidth, self.bounds.size.height);
                    Line.tag =100+LCount-1;
                    for (id tmpview in self.subviews) {
                        if ([tmpview isKindOfClass:[UIView class]]) {
                            UIView* vc =(UIView*)tmpview;
                            if (vc.tag>100&&vc.tag!=(100+LCount-1)) {
                                [tmpview removeFromSuperview];
                            }
                        }
                    }
                }
                //选择0档位时
                if (LCount==0) {
                    for (id tmpview in self.subviews) {
                        if ([tmpview isKindOfClass:[UIView class]]) {
                            UIView* vc =(UIView*)tmpview;
                            if (vc.tag>100) {
                                [tmpview removeFromSuperview];
                            }
                        }
                    }
                }
                Line.backgroundColor = (i < LCount) ? [UIColor colorWithRed:238/255.0 green:193/255.0 blue:126/255.0 alpha:1.0] : [UIColor colorWithRed:252/255.0 green:243/255.0 blue:229/255.0 alpha:1.0];
          [self addSubview:Line];
    }
}
@end
