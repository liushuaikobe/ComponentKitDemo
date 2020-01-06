//
//  YCQuantityComponent.mm
//  YCQuantityControl
//
//  Created by liushuai on 2020/1/5.
//  Copyright © 2020 shuai. All rights reserved.
//

#import "YCQuantityComponent.h"

#import <ComponentKit/CKComponentSubclass.h>

@implementation YCQuantityComponent

+ (instancetype)newWithConfiguration:(const YCQuantityComponentConfiguration &)configuration {
    
    CKComponentScope scope(self);
    
    return [super newWithComponent:
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
                        .size = {24, 24}
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
                           {@selector(setText:), [NSString stringWithFormat:@"%@", scope.state()]}
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
                       .size = {24, 24}
                    }]
                },
            }]];
}

+ (id)initialState {
    return @(0);
}

- (void)minusTapped {
    
}

- (void)addTapped {
    
}

@end
