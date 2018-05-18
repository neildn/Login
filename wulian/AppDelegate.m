//
//  AppDelegate.m
//  wulian
//
//  Created by Dong Neil on 2018/5/17.
//  Copyright © 2018年 Neil. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "TabBarOneViewController.h"
#import "TabBarTwoViewController.h"
#import "LoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSString *token = @"10001";
    
    if (token.length > 1) {
        [self setLoginView];
    } else {
        [self setRootViewController];
    }
    
    
    return YES;
}

- (void)setLoginView{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setRootViewController) name:@"AppDelegateSetRootViewController" object:nil];
    LoginViewController *LoginView = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    
    [self.window setRootViewController:LoginView];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
}

- (void)setRootViewController{
    
}

- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {

}


@end
