//
//  Lwt_ActionSheet.h
//  shuangtu
//
//  Created by 李文韬 on 16/9/22.
//  Copyright © 2016年 TD_. All rights reserved.
//

#import <UIKit/UIKit.h>


#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#endif

#ifndef SCREEN_HEIGHT
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#endif

#ifndef SCREEN_BOUNDS
#define SCREEN_BOUNDS [[UIScreen mainScreen] bounds]
#endif

#define CONTENT_FONT [UIFont systemFontOfSize:18.f]


static CGFloat const SectionHeight = 45; //每个的高度



typedef void(^ActionBlock)(NSInteger clickIndex);


@interface Lwt_ActionSheet : UIView

- (instancetype)initWithCancelBtnTitle:(NSString *)cancelBtnTitle
                destructiveButtonTitle:(NSString *)destructiveBtnTitle
                     otherBtnTitlesArr:(NSArray *)otherBtnTitlesArr
                           actionBlock:(ActionBlock)ActionBlock;

- (void)show;
- (void)dismiss;



@end
