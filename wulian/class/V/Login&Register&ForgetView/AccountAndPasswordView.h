//
//  AccountAndPasswordView.h
//  wulian
//
//  Created by Dong Neil on 2018/5/17.
//  Copyright © 2018年 Neil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountAndPasswordView : UIView

- (IBAction)btnLogin:(UIButton *)sender;
- (IBAction)btnRegistered:(UIButton *)sender;
- (IBAction)btnForget:(UIButton *)sender;

- (void)setBorder;
- (IBAction)backTap:(id)sender;

@end
