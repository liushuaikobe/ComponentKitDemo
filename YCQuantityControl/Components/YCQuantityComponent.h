//
//  YCQuantityComponent.h
//  YCQuantityControl
//
//  Created by liushuai on 2020/1/5.
//  Copyright © 2020 shuai. All rights reserved.
//

#import <ComponentKit/ComponentKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^YCQuantityChangedBlock)(NSInteger quantity);
typedef void (^YCQuantityMaxOverflowBlock)(NSInteger maxQuantity);
typedef void (^YCQuantityMinOverflowBlock)(NSInteger minQuantity);

struct YCQuantityComponentConfiguration {
    NSInteger maxValue;
    NSInteger minValue;
    NSInteger currentValue;
    YCQuantityChangedBlock quantityChangedBlock;
    YCQuantityMaxOverflowBlock quantityMaxOverflowBlock;
    YCQuantityMinOverflowBlock quantityMinOverflowBlock;
};

@interface YCQuantityComponent : CKCompositeComponent

+ (instancetype)newWithConfiguration:(const YCQuantityComponentConfiguration &)configuration;

@end

NS_ASSUME_NONNULL_END
