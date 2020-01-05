//
//  YCQuantityComponent.mm
//  YCQuantityControl
//
//  Created by liushuai on 2020/1/5.
//  Copyright © 2020 shuai. All rights reserved.
//

#import "YCQuantityComponent.h"

@implementation YCQuantityComponent

+ (instancetype)newWithConfiguration:(const YCQuantityComponentConfiguration &)configuration {
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
                    [CKComponent
                     newWithView:{
                        [UIView class],
                        {
                            {@selector(setBackgroundColor:), [UIColor blueColor]}
                        }
                     }
                     size:{44, 44}],
                },
                {
                    [CKComponent
                    newWithView:{
                       [UIView class],
                       {
                           {@selector(setBackgroundColor:), [UIColor redColor]}
                       }
                    }
                    size:{.height = 44}],
                    .flexGrow = 1
                },
                {
                    [CKComponent
                    newWithView:{
                       [UIView class],
                       {
                           {@selector(setBackgroundColor:), [UIColor blueColor]}
                       }
                    }
                    size:{44, 44}],
                }
            }]];
}

@end
