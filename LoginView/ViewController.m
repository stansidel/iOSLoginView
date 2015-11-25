//
//  ViewController.m
//  LoginView
//
//  Created by Stanislav Sidelnikov on 25/11/15.
//  Copyright © 2015 Stanislav Sidelnikov. All rights reserved.
//

#import "ViewController.h"
#import "HNLoginViewController.h"
#import "HNLogin.h"

@interface ViewController () <HNLoginDelegate>
@property (nonatomic, strong) UIBarButtonItem *loginBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *logoutBarButtonItem;
@property (nonatomic, strong) HNLoginViewController *loginViewController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Login", @"Login bar button title") style:UIBarButtonItemStylePlain target:self action:@selector(loginBarButtonPressed:)];
    self.logoutBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Logout", @"Logout bar button title") style:UIBarButtonItemStylePlain target:self action:@selector(logoutBarButtonPressed:)];
    [self updateLoginButton];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)updateLoginButton {
    self.navigationItem.rightBarButtonItem = [HNLogin isLoggedIn] ? self.logoutBarButtonItem : self.loginBarButtonItem;
}

- (void)logoutBarButtonPressed:(UIBarButtonItem *)sender {
    HNLogin *login = [[HNLogin alloc] init];
    BOOL logoutScheduled = [login logoutCurrentUser:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.navigationItem.rightBarButtonItem.enabled = YES;
            [self updateLoginButton];
        });
    }];
    if (logoutScheduled) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    } else {
        [self updateLoginButton];
    }
}

- (void)loginBarButtonPressed:(UIBarButtonItem *)sender {
    self.loginViewController = [[HNLoginViewController alloc] init];
    self.loginViewController.loginDelegate = self;
    [self.navigationController pushViewController:self.loginViewController animated:YES];
}

- (void)loginSucceeded:(NSString *)username {
    if (self.loginViewController) {
        [self.loginViewController.navigationController popToRootViewControllerAnimated:YES];
        self.loginViewController = nil;
    }
    [self updateLoginButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateLoginButton];
}

@end
