//
//  YCQuantityComponent.mm
//  YCQuantityControl
//
//  Created by liushuai on 2020/1/5.
//  Copyright © 2020 shuai. All rights reserved.
//

#import "YCQuantityComponent.h"

#import <ComponentKit/CKComponentSubclass.h>


@interface YCQuantityComponentController : CKComponentController
- (void)minusTapped;
- (void)addTapped;
@end


@interface YCQuantityComponentState : NSObject
@property(nonatomic, assign) NSInteger minValue;
@property(nonatomic, assign) NSInteger maxValue;
@property(nonatomic, assign) NSInteger currentValue;
+ (instancetype)newWithMinValue:(NSInteger)minValue maxValue:(NSInteger)maxValue currentValue:(NSInteger)currentValue;
+ (instancetype)minValueStateWithState:(YCQuantityComponentState *)state;
+ (instancetype)maxValueStateWithState:(YCQuantityComponentState *)state;
@end


@interface YCQuantityComponent () {
    @public
    YCQuantityComponentConfiguration _configuration;
}

@end

@implementation YCQuantityComponent

+ (instancetype)newWithConfiguration:(const YCQuantityComponentConfiguration &)configuration {
    
    CKComponentScope scope(self, nil, ^id{
        YCQuantityComponentState *initialState = [[YCQuantityComponentState alloc] init];
        initialState.minValue = configuration.minValue;
        initialState.maxValue = configuration.maxValue;
        initialState.currentValue = configuration.currentValue;
        return initialState;
    });
    
    YCQuantityComponentState *state = scope.state();
    
    YCQuantityComponent *const c =
      [YCQuantityComponent newWithComponent:
        [CKFlexboxComponent
         newWithView: {}
         size: {}
         style: {
            .direction = CKFlexboxDirectionRow,
            .alignItems = CKFlexboxAlignItemsCenter,
            .justifyContent = CKFlexboxJustifyContentSpaceBetween
         }
         children:{
            {
                [CKButtonComponent
                 newWithAction:@selector(minusTapped)
                 options:{
                    .images = {
                        {UIControlStateNormal, [UIImage imageNamed:@"minus_normal"]},
                        {UIControlStateDisabled, [UIImage imageNamed:@"minus_disable"]}
                    },
                    .size = {24, 24},
                    .enabled = (state.currentValue > state.minValue)
                 }]
            },
            {
                [CKComponent
                 newWithView:{
                   [UITextField class],
                   {
                       {@selector(setKeyboardType:), UIKeyboardTypeNumberPad},
                       {@selector(setReturnKeyType:), UIReturnKeyDone},
                       {@selector(setTextAlignment:), NSTextAlignmentCenter},
                       {@selector(setClipsToBounds:), YES},
                       {@selector(setEnablesReturnKeyAutomatically:), YES},
                       {@selector(setText:), [NSString stringWithFormat:@"%zd", state.currentValue]}
                   }
                }
                 size:{.height = 44}],
                .flexGrow = 1,
                .spacingBefore = 8,
                .spacingAfter = 8
            },
            {
                [CKButtonComponent
                newWithAction:@selector(addTapped)
                options:{
                   .images = {
                       {UIControlStateNormal, [UIImage imageNamed:@"add_normal"]},
                       {UIControlStateDisabled, [UIImage imageNamed:@"add_disable"]}
                   },
                   .size = {24, 24},
                   .enabled = (state.currentValue < state.maxValue)
                }]
            },
        }]];
    
    if (c) {
        c -> _configuration = configuration;
    }
    
    return c;
}

+ (Class<CKComponentControllerProtocol>)controllerClass {
    return [YCQuantityComponentController class];
}

@end


@implementation YCQuantityComponentController {
    YCQuantityComponentConfiguration _configuration;
}

- (instancetype)initWithComponent:(YCQuantityComponent *)component {
    if (self = [super initWithComponent:component]) {
        _configuration = component -> _configuration;
    }
    
    return self;
}

- (void)minusTapped {
    [self.component updateState:^id(YCQuantityComponentState *currentState) {
        NSInteger newValue = currentState.currentValue - 1;
        
        YCQuantityComponentConfiguration config = self -> _configuration;
        
        if (newValue < config.minValue) {
            
            if (config.quantityMinOverflowBlock) {
                config.quantityMinOverflowBlock(config.minValue);
            }
            
            return [YCQuantityComponentState minValueStateWithState:currentState];
        } else {
            return [YCQuantityComponentState newWithMinValue:currentState.minValue
                                                    maxValue:currentState.maxValue
                                                currentValue:newValue];
        }
    } mode:CKUpdateModeSynchronous];
}

- (void)addTapped {
    [self.component updateState:^id(YCQuantityComponentState *currentState) {
        NSInteger newValue = currentState.currentValue + 1;
        
        YCQuantityComponentConfiguration config = self -> _configuration;
        
        if (newValue > config.maxValue) {
            
            if (config.quantityMaxOverflowBlock) {
                config.quantityMaxOverflowBlock(config.maxValue);
            }
            
            return [YCQuantityComponentState maxValueStateWithState:currentState];
        } else {
            return [YCQuantityComponentState newWithMinValue:currentState.minValue
                                                    maxValue:currentState.maxValue
                                                currentValue:newValue];
        }
    } mode:CKUpdateModeSynchronous];
}

@end


@implementation YCQuantityComponentState

- (instancetype)init {
    if (self = [super init]) {
        self.minValue = 0;
        self.maxValue = NSIntegerMax;
        self.currentValue = 1;
    }
    return self;
}

+ (instancetype)newWithMinValue:(NSInteger)minValue maxValue:(NSInteger)maxValue currentValue:(NSInteger)currentValue {
    YCQuantityComponentState *s = [[YCQuantityComponentState alloc] init];
    s.currentValue = currentValue;
    s.minValue = minValue;
    s.maxValue = maxValue;
    return s;
}

+ (instancetype)maxValueStateWithState:(YCQuantityComponentState *)state {
    return [self newWithMinValue:state.minValue maxValue:state.maxValue currentValue:state.maxValue];
}

+ (instancetype)minValueStateWithState:(YCQuantityComponentState *)state {
    return [self newWithMinValue:state.minValue maxValue:state.maxValue currentValue:state.minValue];
}

@end
