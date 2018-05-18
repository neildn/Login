//
//  RegisteredView.m
//  wulian
//
//  Created by Dong Neil on 2018/5/18.
//  Copyright © 2018年 Neil. All rights reserved.
//

#import "RegisteredView.h"
#import "Toast+UIView.h"

@interface RegisteredView () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textInputeAccount;
@property (weak, nonatomic) IBOutlet UITextField *textInputPassword;
@property (weak, nonatomic) IBOutlet UITextField *textInputCode;
@property (weak, nonatomic) IBOutlet UITextField *textSecretProtection;
@property (weak, nonatomic) IBOutlet UILabel *lblInputAccount;
@property (weak, nonatomic) IBOutlet UILabel *lblInputPassword;
@property (weak, nonatomic) IBOutlet UILabel *lblInputCode;
@property (weak, nonatomic) IBOutlet UILabel *lblSecretProtection;
@property (weak, nonatomic) IBOutlet UIButton *btnCode;
- (IBAction)btnCode:(id)sender;
- (IBAction)btnCancel:(UIButton *)sender;
- (IBAction)btnRegistered:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnRegistered;

@end

@implementation RegisteredView


- (void)registeredSuccess{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RegisteredViewbtnRegistered" object:nil];
}

- (void)setBorder{
    _lblInputAccount.layer.masksToBounds = YES;
    _lblInputPassword.layer.masksToBounds = YES;
    _lblInputCode.layer.masksToBounds = YES;
    _btnRegistered.layer.masksToBounds = YES;
    _btnCancel.layer.masksToBounds = YES;
    _lblSecretProtection.layer.masksToBounds = YES;
        
    _lblInputAccount.layer.cornerRadius = 5;
    _lblInputPassword.layer.cornerRadius = 5;
    _lblInputCode.layer.cornerRadius = 5;
    _btnRegistered.layer.cornerRadius = 5;
    _btnCancel.layer.cornerRadius = 5;
    _lblSecretProtection.layer.cornerRadius = 5;
    
    _textInputeAccount.delegate = self;
    _textInputPassword.delegate = self;
    _textInputCode.delegate = self;
    _textSecretProtection.delegate = self;
    
    [_btnCode setTitle:[NSString stringWithFormat:@"%.4d",arc4random() % 10000] forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldResignFirstResponder) name:@"backTap" object:nil];
}

- (IBAction)backTap:(id)sender {
    [self textFieldResignFirstResponder];
}
- (IBAction)btnCode:(id)sender {
    [_btnCode setTitle:[NSString stringWithFormat:@"%.4d",arc4random() % 10000] forState:UIControlStateNormal];
}

- (IBAction)btnCancel:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RegisteredViewbtnCancel" object:nil];
}

- (IBAction)btnRegistered:(UIButton *)sender {
    if (_textInputeAccount.text.length < 6 || _textInputPassword.text.length < 6) {
        [self makeToast:@"密码或者账号输入位数有误" duration:1.7];
        [_btnCode setTitle:[NSString stringWithFormat:@"%.4d",arc4random() % 10000] forState:UIControlStateNormal];
    } else if (![_textInputCode.text isEqualToString:_btnCode.titleLabel.text]){
        [self makeToast:@"验证码输入有误" duration:1.7];
        [_btnCode setTitle:[NSString stringWithFormat:@"%.4d",arc4random() % 10000] forState:UIControlStateNormal];
    } else if ([_textInputeAccount.text isEqualToString:[[NSUserDefaults standardUserDefaults] stringForKey:@"oldAccount"]]) {
        [self makeToast:@"账号已存在" duration:1.7];
        [_btnCode setTitle:[NSString stringWithFormat:@"%.4d",arc4random() % 10000] forState:UIControlStateNormal];
    } else if (_textSecretProtection.text.length < 6) {
        [self makeToast:@"密保输入有误" duration:1.7];
        [_btnCode setTitle:[NSString stringWithFormat:@"%.4d",arc4random() % 10000] forState:UIControlStateNormal];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:_textInputeAccount.text forKey:@"oldAccount"];
        [[NSUserDefaults standardUserDefaults] setObject:_textInputPassword.text forKey:@"oldPassword"];
        [[NSUserDefaults standardUserDefaults] setObject:_textSecretProtection.text forKey:@"oldSecretProtection"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RegisteredViewSuccess" object:nil];
        
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didStartEditing" object:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didEndEditing" object:nil];
}


- (void)textFieldResignFirstResponder{
    [_textSecretProtection resignFirstResponder];
    [_textInputCode resignFirstResponder];
    [_textInputPassword resignFirstResponder];
    [_textInputeAccount resignFirstResponder];
}
@end
