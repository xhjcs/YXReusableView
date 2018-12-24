//
//  UITableView+YXAdd.m
//  KG_Video
//
//  Created by Heikki on 2018/12/7.
//  Copyright © 2018 快更. All rights reserved.
//

#import <objc/runtime.h>
#import "UITableView+Reusable.h"

static char reusable_map_key;

@interface UITableView ()

@property (nonatomic, readonly) NSMutableDictionary *yx_reusableMap;

@end

@implementation UITableView (Reusable)

static NSString * const CLASS_KEY = @"class";

static NSString * const REUSABLE_KEY = @"reusable";
static NSString * const VISIABLE_KEY = @"visiable";

- (NSMutableDictionary *)yx_reusableMap {
    NSMutableDictionary *map = objc_getAssociatedObject(self, &reusable_map_key);
    if (!map) {
        map = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, &reusable_map_key, map, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return map;
}

- (void)yx_registerClass:(Class)viewClass forViewReuseIdentifier:(NSString *)identifier {
    if (identifier.length == 0) {
        return;
    }
    if (!viewClass) {
        self.yx_reusableMap[identifier] = nil;
        return;
    }
    
    NSMutableArray *reusableQueue = [[NSMutableArray alloc] init];
    NSMutableArray *visiableQueue = [[NSMutableArray alloc] init];
    
    NSDictionary *content = @{CLASS_KEY : viewClass,
                              REUSABLE_KEY : reusableQueue,
                              VISIABLE_KEY : visiableQueue
                              };
    self.yx_reusableMap[identifier] = content;
}

- (UIView *)yx_dequeueReusableViewWithIdentifier:(NSString *)identifier {
    NSDictionary *content = self.yx_reusableMap[identifier];
    NSMutableArray *reusableQueue = content[REUSABLE_KEY];
    NSMutableArray *visiableQueue = content[VISIABLE_KEY];
    
    UIView *v = reusableQueue.firstObject;
    if (v) {
        [reusableQueue removeObjectAtIndex:0];
    } else {
        Class cls = content[CLASS_KEY];
        v = [[cls alloc] init];
    }
    [visiableQueue addObject:v];
    return v;
}

- (void)yx_inqueueReusableView:(UIView *)reusable identifier:(NSString *)identifier {
    NSDictionary *content = self.yx_reusableMap[identifier];
    NSMutableArray *reusableQueue = content[REUSABLE_KEY];
    NSMutableArray *visiableQueue = content[VISIABLE_KEY];
    [reusableQueue addObject:reusable];
    [visiableQueue removeObject:reusable];
}

@end
