//
//  FSUser.h
//  APIFriendsTest
//
//  Created by Elerman on 12.01.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSUser : NSObject

@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSString* userId;
@property (strong, nonatomic) NSURL* imageUrl_50;
@property (strong, nonatomic) NSURL* imageUrl_100;
@property (strong, nonatomic) NSString* cityTitle;
@property (assign, nonatomic) NSString* sex;
@property (strong, nonatomic) NSString* bDate;
@property (strong, nonatomic) NSString* isOnline;



-(id) initWithServerResponse:(NSDictionary*) responseObject;


@end
