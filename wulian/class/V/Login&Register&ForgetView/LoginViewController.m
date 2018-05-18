//
//  LoginViewController.m
//  wulian
//
//  Created by Dong Neil on 2018/5/17.
//  Copyright © 2018年 Neil. All rights reserved.
//

#import "LoginViewController.h"
#import "AccountAndPasswordView.h"
#import "RegisteredView.h"
#import "ForgettedView.h"
#import "Toast+UIView.h"

@interface LoginViewController () {
    UIImageView *imgLoginView;
    AccountAndPasswordView *APView;
    RegisteredView *RDV;
    ForgettedView *FDV;
}

@property (weak, nonatomic) IBOutlet UIButton *btnStart;
- (IBAction)btnStart:(UIButton *)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    _btnStart.layer.masksToBounds = YES;
    _btnStart.layer.cornerRadius = 100;
}

- (void)viewWillDisappear:(BOOL)animated{
    
}

- (IBAction)btnStart:(UIButton *)sender {
    _btnStart.hidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Registered) name:@"LoginViewControllerRegistered" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Forgetted) name:@"LoginViewControllerForgetted" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didStartEditing) name:@"didStartEditing" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEndEditing) name:@"didEndEditing" object:nil];
    APView = [[AccountAndPasswordView alloc] init];
    APView = [[[NSBundle mainBundle] loadNibNamed:@"AccountAndPasswordView" owner:self options:nil] lastObject];
    [APView setBorder];
    APView.frame = CGRectMake(0, 400, self.view.frame.size.width, 210);
    APView.layer.masksToBounds = YES;
    APView.layer.cornerRadius = 20;
    imgLoginView = [[UIImageView alloc] initWithFrame:self.view.frame];
    imgLoginView.image = [UIImage imageNamed:@"LoginImage"];
    [self.view addSubview:imgLoginView];
    [self.view addSubview:APView];
}

- (void)Registered{
    APView.hidden = YES;
    RDV = [[RegisteredView alloc] init];
    RDV = [[[NSBundle mainBundle] loadNibNamed:@"RegisteredView" owner:self options:nil] lastObject];
    RDV.frame = CGRectMake(0, 350, self.view.frame.size.width, 270);
    RDV.layer.masksToBounds = YES;
    RDV.layer.cornerRadius = 5;
    [RDV setBorder];
    [self.view addSubview:RDV];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RegisteredViewbtnCancel) name:@"RegisteredViewbtnCancel" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RegisteredViewSuccess) name:@"RegisteredViewSuccess" object:nil];
}

- (void)Forgetted{
    APView.hidden = YES;
    FDV = [[ForgettedView alloc] init];
    FDV = [[[NSBundle mainBundle] loadNibNamed:@"ForgettedView" owner:self options:nil] lastObject];
    FDV.frame = CGRectMake(0, 300, self.view.frame.size.width, 320);
    FDV.layer.masksToBounds = YES;
    FDV.layer.cornerRadius = 5;
    [FDV setBorder];
    [self.view addSubview:FDV];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ForgetteddViewbtnCancel) name:@"ForgettedViewbtnCancel" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ForgettedViewSuccess) name:@"ForgettedViewSuccess" object:nil];
}

- (void)RegisteredViewbtnCancel{
    [RDV removeFromSuperview];
    APView.hidden = NO;
}
- (void)RegisteredViewSuccess{
    [RDV removeFromSuperview];
    APView.hidden = NO;
    [APView makeToast:@"注册成功" duration:1.7];
}

- (void)ForgetteddViewbtnCancel{
    [FDV removeFromSuperview];
    APView.hidden = NO;
}
- (void)ForgettedViewSuccess{
    [FDV removeFromSuperview];
    APView.hidden = NO;
    [APView makeToast:@"重置成功" duration:1.7];
}

- (void)didStartEditing{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = - 160;
        self.view.frame = frame;
    }];
}
- (void)didEndEditing{
    [UIView animateWithDuration:0.25 animations:^{
        self.view.frame = [UIScreen mainScreen].bounds;
    }];
}

- (IBAction)backTap:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"backTap" object:nil];
}
@end
