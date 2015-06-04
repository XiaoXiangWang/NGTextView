//
//  NGTextView.m
//  NGTextViewDemo
//
//  Created by 汪潇翔 on 15/6/4.
//  Copyright (c) 2015年 NG. All rights reserved.
//

#import "NGTextView.h"


#if !__has_feature(objc_arc)
#error NGTextView must be built with ARC.
// You can turn on ARC for files by adding -fobjc-arc to the build phase for each of its files.
#endif

@interface NGTextView ()

@property(nonatomic,weak) UILabel* xPlaceHolderLabel;

@property(nonatomic,assign) UIEdgeInsets placeHolderInset;

@end

@implementation NGTextView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self _initSubViews];
    }
    return self;
}

-(void)awakeFromNib
{
    [self _initSubViews];
}

-(void)_getTextContainerConfig
{
    if ([self respondsToSelector:@selector(textContainerInset)]) {
        self.placeHolderInset = UIEdgeInsetsMake(self.textContainerInset.top,
                                                 5,
                                                 self.textContainerInset.bottom,
                                                 5);
    }else{
        self.placeHolderInset = UIEdgeInsetsMake(8,
                                                 8,
                                                 8,
                                                 8);
    }
}

-(void)_initSubViews
{
    [self _getTextContainerConfig];
    UILabel* placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.placeHolderInset.left,
                                                                          self.placeHolderInset.top,
                                                                          CGRectGetWidth(self.bounds)-self.placeHolderInset.left-self.placeHolderInset.right,
                                                                          CGRectGetHeight(self.bounds)-self.placeHolderInset.top-self.placeHolderInset.bottom)];
    placeHolderLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin;
    placeHolderLabel.backgroundColor = [UIColor clearColor];
    
//    placeHolderLabel.font = self.font;//此刻font为空
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor grayColor];
    self.xPlaceHolderLabel = placeHolderLabel;
    //同步placeHolderLabel和当前textView的字体大小
    self.font = [UIFont systemFontOfSize:14];
    //xib上可能已经有文字了
    placeHolderLabel.hidden = self.text && self.text.length > 0;
    [self addSubview:placeHolderLabel];
    
    //Notification
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_xTextDidChange:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)layoutSubviews
{
    CGFloat width = CGRectGetWidth(self.bounds)-self.placeHolderInset.left-self.placeHolderInset.right;
    CGFloat height = CGRectGetHeight(self.bounds)-self.placeHolderInset.top-self.placeHolderInset.bottom;
    CGSize size = [self.xPlaceHolderLabel sizeThatFits:CGSizeMake(width, height)];
    CGRect frame = CGRectMake(self.placeHolderInset.left,
                              self.placeHolderInset.top,
                              width,
                              height);
    frame.size = size;
    self.xPlaceHolderLabel.frame = frame;
}

-(void)_xTextDidChange:(NSNotification*)note
{
    if (note.object == self && self.placeHolder) {
        BOOL hidden = self.text != nil && self.text.length != 0;
        self.xPlaceHolderLabel.hidden = hidden;
    }
}


-(void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    self.xPlaceHolderLabel.text = placeHolder;
    [self setNeedsLayout];
    
}
-(void)setText:(NSString *)text
{
    [super setText:text];
    self.xPlaceHolderLabel.hidden = self.text && self.text.length;
}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.xPlaceHolderLabel.font = self.font;
    [self setNeedsLayout];
}

@end
