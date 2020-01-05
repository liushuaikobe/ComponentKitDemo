//
//  YCDemoViewController.mm
//  YCQuantityControl
//
//  Created by liushuai on 2020/1/5.
//  Copyright © 2020 shuai. All rights reserved.
//

#import "YCDemoViewController.h"

#import <ComponentKit/ComponentKit.h>

#import "YCQuantityComponent.h"

@interface YCDemoViewController () <CKComponentProvider, CKComponentHostingViewDelegate>
@end

@implementation YCDemoViewController {
    CKComponentHostingView *_hostingView;
    CKComponentFlexibleSizeRangeProvider *_sizeRangeProvider;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sizeRangeProvider = [CKComponentFlexibleSizeRangeProvider providerWithFlexibility:CKComponentSizeRangeFlexibleWidthAndHeight];
    
    _hostingView = [[CKComponentHostingView alloc] initWithComponentProvider:self.class
                                                           sizeRangeProvider:_sizeRangeProvider];
    _hostingView.delegate = self;
    
    [_hostingView updateModel:[NSObject new] mode:CKUpdateModeSynchronous];
    
    _hostingView.frame = CGRectMake(18, 100, 300, 80);
    
    _hostingView.layer.borderColor = [UIColor redColor].CGColor;
    _hostingView.layer.borderWidth = 1;
    _hostingView.clipsToBounds = NO;
    
    [self.view addSubview:_hostingView];
}

#pragma mark - CKComponentProvider

+ (CKComponent *)componentForModel:(id<NSObject>)model context:(id<NSObject>)context {
    return [YCQuantityComponent newWithConfiguration:{
        .maxValue = 10,
        .minValue = 1,
        .currentValue = 5
    }];
}

#pragma mark - CKComponentHostingViewDelegate

- (void)componentHostingViewDidInvalidateSize:(CKComponentHostingView *)hostingView {
    NSLog(@"componentHostingViewDidInvalidateSize");
}

@end
