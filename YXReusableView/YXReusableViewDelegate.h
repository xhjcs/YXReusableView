//
//  YXReusableViewDelegate.h
//  KG_Video
//
//  Created by Heikki on 2018/12/7.
//  Copyright © 2018 快更. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YXReusableViewDelegate <NSObject>

- (void)yx_registerClass:(nullable Class)viewClass forViewReuseIdentifier:(NSString *)identifier;
- (nullable __kindof UIView *)yx_dequeueReusableViewWithIdentifier:(NSString *)identifier;
- (void)yx_inqueueReusableView:(UIView *)reusable identifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
