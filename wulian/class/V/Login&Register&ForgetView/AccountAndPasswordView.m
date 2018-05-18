//
//  AccountAndPasswordView.m
//  wulian
//
//  Created by Dong Neil on 2018/5/17.
//  Copyright © 2018年 Neil. All rights reserved.
//

#import "AccountAndPasswordView.h"
#import "Toast+UIView.h"

@interface AccountAndPasswordView () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgAPViewBj;
@property (weak, nonatomic) IBOutlet UILabel *lblAccount;
@property (weak, nonatomic) IBOutlet UILabel *lblPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UITextField *textAccount;
@property (weak, nonatomic) IBOutlet UITextField *textPassword;
@property (weak, nonatomic) IBOutlet UIView *LoginView;

@end



@implementation AccountAndPasswordView

- (void)setBorder{
    _lblAccount.layer.masksToBounds = YES;
    _lblPassword.layer.masksToBounds = YES;
    _textAccount.layer.masksToBounds = YES;
    _textPassword.layer.masksToBounds = YES;
    _btnLogin.layer.masksToBounds = YES;
    
    _lblAccount.layer.cornerRadius = 5;
    _lblPassword.layer.cornerRadius = 5;
    _textAccount.layer.cornerRadius = 5;
    _textPassword.layer.cornerRadius = 5;
    _btnLogin.layer.cornerRadius = 5;
    
    _textAccount.delegate = self;
    _textPassword.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldResignFirstResponder) name:@"backTap" object:nil];
}

- (IBAction)backTap:(id)sender {
    [self textFieldResignFirstResponder];
}

- (IBAction)btnLogin:(UIButton *)sender {
    NSString *currentAccount = _textAccount.text;
    NSString *currentPassword = _textPassword.text;
    
    NSString *oldAccount = [[NSUserDefaults standardUserDefaults] stringForKey:@"oldAccount"];
    NSString *oldPassword = [[NSUserDefaults standardUserDefaults] stringForKey:@"oldPassword"];
    
    if (_textAccount.text.length < 6) {
        [self makeToast:@"账号输入错误" duration:1.7];
    } else {
        if (![currentAccount isEqualToString:oldAccount]) {
            [self makeToast:@"账号不存在" duration:1.7];
        } else if (![currentPassword isEqualToString:oldPassword]) {
            [self makeToast:@"密码输入错误" duration:1.7];
        } else {
            [self makeToast:@"登录成功" duration:1.7];
        }
    }
}

- (IBAction)btnRegistered:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginViewControllerRegistered" object:nil];
}

- (IBAction)btnForget:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginViewControllerForgetted" object:nil];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didStartEditing" object:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didEndEditing" object:nil];
}

- (void)textFieldResignFirstResponder{
    [self.textAccount resignFirstResponder];
    [self.textPassword resignFirstResponder];
}
@end
