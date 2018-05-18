//
//  ForgettedView.m
//  wulian
//
//  Created by Dong Neil on 2018/5/18.
//  Copyright © 2018年 Neil. All rights reserved.
//

#import "ForgettedView.h"
#import "Toast+UIView.h"


@interface ForgettedView () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblAccount;
@property (weak, nonatomic) IBOutlet UILabel *lblSecretProtection;
@property (weak, nonatomic) IBOutlet UILabel *lblNewPassword;
@property (weak, nonatomic) IBOutlet UILabel *lblSureNewPassword;
@property (weak, nonatomic) IBOutlet UILabel *lblCode;
- (IBAction)btnCancel:(UIButton *)sender;
- (IBAction)btnSure:(UIButton *)sender;
- (IBAction)btnCode:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnCode;
@property (weak, nonatomic) IBOutlet UIButton *btnSure;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;

@property (weak, nonatomic) IBOutlet UITextField *textAccount;
@property (weak, nonatomic) IBOutlet UITextField *textSecretProtection;
@property (weak, nonatomic) IBOutlet UITextField *textNewPassword;
@property (weak, nonatomic) IBOutlet UITextField *textSureNewPassword;
@property (weak, nonatomic) IBOutlet UITextField *textCode;
@end


@implementation ForgettedView

- (void)setBorder{
    _lblAccount.layer.masksToBounds = YES;
    _lblSecretProtection.layer.masksToBounds = YES;
    _lblNewPassword.layer.masksToBounds = YES;
    _lblCode.layer.masksToBounds = YES;
    _lblSureNewPassword.layer.masksToBounds = YES;
    _btnSure.layer.masksToBounds = YES;
    _btnCancel.layer.masksToBounds = YES;
    
    _lblAccount.layer.cornerRadius = 5;
    _lblNewPassword.layer.cornerRadius = 5;
    _lblSureNewPassword.layer.cornerRadius = 5;
    _lblCode.layer.cornerRadius = 5;
    _btnCancel.layer.cornerRadius = 5;
    _lblSecretProtection.layer.cornerRadius = 5;
    _btnSure.layer.cornerRadius = 5;
    
    _textAccount.delegate = self;
    _textSecretProtection.delegate = self;
    _textNewPassword.delegate = self;
    _textSureNewPassword.delegate = self;
    _textCode.delegate = self;
    
    [_btnCode setTitle:[NSString stringWithFormat:@"%.4d",arc4random() % 10000] forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldResignFirstResponder) name:@"backTap" object:nil];
}

- (IBAction)backTap:(id)sender {
    [self textFieldResignFirstResponder];
}

- (IBAction)btnCancel:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ForgettedViewbtnCancel" object:nil];
}

- (IBAction)btnSure:(UIButton *)sender {
    if (_textAccount.text.length < 6 || _textSecretProtection.text.length < 6 ) {
        [self makeToast:@"账号或密保输入格式错误" duration:1.7];
        [_btnCode setTitle:[NSString stringWithFormat:@"%.4d",arc4random() % 10000] forState:UIControlStateNormal];
    } else if ( ![_textAccount.text isEqualToString:[[NSUserDefaults standardUserDefaults] stringForKey:@"oldAccount"]] ) {
        [self makeToast:@"账号不存在" duration:1.7];
        [_btnCode setTitle:[NSString stringWithFormat:@"%.4d",arc4random() % 10000] forState:UIControlStateNormal];
    } else if ( ![_textSecretProtection.text isEqualToString:[[NSUserDefaults standardUserDefaults] stringForKey:@"oldSecretProtection"]]) {
        [self makeToast:@"密保错误" duration:1.7];
        [_btnCode setTitle:[NSString stringWithFormat:@"%.4d",arc4random() % 10000] forState:UIControlStateNormal];
    } else if ( ![_textNewPassword.text isEqualToString:[NSString stringWithFormat:@"%@",_textSureNewPassword.text]]) {
        [self makeToast:@"密码和确认密码不一致" duration:1.7];
        [_btnCode setTitle:[NSString stringWithFormat:@"%.4d",arc4random() % 10000] forState:UIControlStateNormal];
    } else if (![_textCode.text isEqualToString:_btnCode.titleLabel.text]) {
        [self makeToast:@"验证码错误" duration:1.7];
        [_btnCode setTitle:[NSString stringWithFormat:@"%.4d",arc4random() % 10000] forState:UIControlStateNormal];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:_textNewPassword.text forKey:@"oldPassword"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ForgettedViewSuccess" object:nil];
    }
}

- (IBAction)btnCode:(UIButton *)sender {
    [_btnCode setTitle:[NSString stringWithFormat:@"%.4d",arc4random() % 10000] forState:UIControlStateNormal];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didStartEditing" object:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didEndEditing" object:nil];
}

- (void)textFieldResignFirstResponder{
    [_textSecretProtection resignFirstResponder];
    [_textCode resignFirstResponder];
    [_textAccount resignFirstResponder];
    [_textNewPassword resignFirstResponder];
    [_textSureNewPassword resignFirstResponder];
}
@end
