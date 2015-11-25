//
//  HNLogin.h
//  HackerNewsNetworker
//
//  Created by Stanislav Sidelnikov on 17/11/15.
//  Copyright © 2015 Ryan Nystrom. All rights reserved.
//

@import Foundation;

@interface HNLogin : NSObject <NSURLSessionDelegate, NSURLSessionTaskDelegate>

+ (BOOL)isLoggedIn;
- (void)loginUser:(NSString *)username
     withPassword:(NSString *)password
       completion:(void (^)(NSString*, NSError*))completion;
- (BOOL)logoutCurrentUser:(void (^)(NSError*))completion;
+ (NSString *)currentUserLogin;

@end
