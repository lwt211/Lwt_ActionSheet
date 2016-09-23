//
//  Lwt_ActionSheet.m
//  shuangtu
//
//  Created by 李文韬 on 16/9/22.
//  Copyright © 2016年 TD_. All rights reserved.
//

#import "Lwt_ActionSheet.h"




@interface Lwt_ActionSheet ()
{
    NSString *_cancelBtnTitle;
    NSString *_destructiveBtnTitle;
    NSArray  *_otherBtnTitlesArr;
    
    UIView   *_bgView; // 存放子控件的View
}

@property (nonatomic, copy) ActionBlock ActionBlock;


@end


@implementation Lwt_ActionSheet

- (instancetype)initWithCancelBtnTitle:(NSString *)cancelBtnTitle destructiveButtonTitle:(NSString *)destructiveBtnTitle otherBtnTitlesArr:(NSArray *)otherBtnTitlesArr actionBlock:(ActionBlock)ActionBlock{
    if(self = [super init]){
        
    
        self.frame = SCREEN_BOUNDS;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
    
        
        _cancelBtnTitle = cancelBtnTitle;
        _destructiveBtnTitle = destructiveBtnTitle;
        
        NSMutableArray *titleArr = [NSMutableArray array];
        if(_destructiveBtnTitle.length){
            [titleArr addObject:_destructiveBtnTitle];
        }
        
        [titleArr addObjectsFromArray:otherBtnTitlesArr];
        _otherBtnTitlesArr = [NSArray arrayWithArray:titleArr];
        _ActionBlock = ActionBlock;
        
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
  
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:_bgView];
    
    for (NSInteger i = 0; i < _otherBtnTitlesArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        [button setTitle:_otherBtnTitlesArr[i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        button.titleLabel.font = CONTENT_FONT;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        if (i==0 && _destructiveBtnTitle.length) {
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        
        UIImage *image = [self createImageWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.3]] ;
        [button setBackgroundImage:image forState:UIControlStateHighlighted];
        
        [button addTarget:self action:@selector(buttonIndexClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonY = SectionHeight * i;
        button.frame = CGRectMake(0, buttonY, SCREEN_WIDTH, SectionHeight);
        [_bgView addSubview:button];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
        line.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        line.frame = CGRectMake(0, buttonY,SCREEN_WIDTH, 0.5);
        
        [_bgView addSubview:line];
    }

    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.tag = _otherBtnTitlesArr.count;
    [cancelButton setTitle:_cancelBtnTitle?_cancelBtnTitle:@"取消" forState:UIControlStateNormal];
    cancelButton.backgroundColor = [UIColor whiteColor];
    cancelButton.titleLabel.font = CONTENT_FONT;
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIImage *image = [self createImageWithColor:[[UIColor blackColor] colorWithAlphaComponent:0.4]];
    [cancelButton setBackgroundImage:image forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    CGFloat buttonY = SectionHeight * (_otherBtnTitlesArr.count) + 5;
    cancelButton.frame = CGRectMake(0, buttonY, SCREEN_WIDTH, SectionHeight);
    [_bgView addSubview:cancelButton];
    
    CGFloat height = SectionHeight * (_otherBtnTitlesArr.count + 1) + 5;
    _bgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, height);

    
    
    
}


- (void)buttonIndexClick:(UIButton *)sender{
    if(_ActionBlock){
        _ActionBlock(sender.tag);
    }
    [self dismiss];
}

- (void)show{

    _bgView.transform = CGAffineTransformIdentity;
    self.alpha = 0;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 1;
        [_bgView setTransform:CGAffineTransformMakeTranslation(0, -_bgView.frame.size.height)];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss{
    [UIView animateWithDuration:0.3f animations:^{
        [_bgView setTransform:CGAffineTransformIdentity];
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark - 将颜色转化成图片
 - (UIImage*)createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
