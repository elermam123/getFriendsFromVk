//
//  FSServerManager.h
//  APIFriendsTest
//
//  Created by Elerman on 12.01.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSServerManager : NSObject

+ (FSServerManager*) sharedManager;

- (void) getFriendsWithOffset:(NSInteger) offset
                        count:(NSInteger) count
                    onSuccess:(void(^)(NSArray* friends)) success
                    onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) getFriendInfoById:(NSString*) userID
                 onSuccess:(void(^)(NSArray* friends)) success
                 onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;

- (void) getWallById:(NSString*) userID
               count:(NSInteger) count
              offset:(NSInteger) offset
           onSuccess:(void(^)(NSArray* friends)) success
           onFailure:(void(^)(NSError* error, NSInteger statusCode)) failure;


@end
